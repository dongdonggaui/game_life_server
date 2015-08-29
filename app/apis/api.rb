# require_relative 'user/user_api'
# require_relative 'user/user_session_api'
require 'api_error'
require 'user_api'
class API < Grape::API
  format :json

  class Grape::Middleware::Error
    def error_message(code, text)
      {
          :code => code,
          :message => text
      }.to_json
    end
  end

  rescue_from Api::InvalidToken do
    rack_response(error_message(50, 'invalid access token provided'), 401)
  end

  rescue_from Api::AccessDenied do
    rack_response(error_message(60, 'access denied'), 403)
  end

  rescue_from Api::InvalidParams do |e|
    rack_response(error_message(30, e.message), 401)
  end

  rescue_from ActiveRecord::RecordNotFound do
    rack_response(error_message(70, 'not found'), 404)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response(error_message(20, e.message), e.status)
  end

  rescue_from StandardError do |e|
    rack_response(error_message(20, e.message), 500)
  end

  rescue_from :all do |e|
    if Rails.env.development?
      raise e
    else
      rack_response(error_message(500, 'internal server error'), 500)
    end
  end

  helpers do
    def authenticate_user!
      token = params[:token]
      raise Api::InvalidParams, 'token could not be nil' if token.nil?
      payload, _ = JWT.decode(token, 'key')
      @current_user = User.find_by!('id = ?', payload['user_id'])
      error!({error: 'unauthorized access'}, 401) if @current_user.nil?
    end

    def current_user
      @current_user
    end

    def wrap_response(obj)
      {code: 1, message: 'success', data: obj}
    end
  end

  # mount UserAPI
  mount GameAPI
  mount UserSessionApi
  mount UserMirrorAPI
  mount StatusAPI
  add_swagger_documentation api_version:'v1',
                            mount_path: '/docs',
                            hide_format: true,
                            base_path: 'http://localhost:3000/api',
                            hide_documentation_path: true,
                            info: {title: 'Game Life Api Document',
                                   description: 'This is a Api document for app Game Life',
                                   contact: 'hly@qq.com',
                                   license: 'MIT',
                                   license_url: 'http://www.baidu.com'},
                            api_documentation: { desc: 'Reticulated splines API swagger-compatible documentation.' }
end