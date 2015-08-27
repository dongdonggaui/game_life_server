# require_relative 'user/user_api'
# require_relative 'user/user_session_api'
require 'api_error'
class API < Grape::API
  format :json

  class Grape::Middleware::Error
    def error_message(code, text)
      {
          :error => {
              :code => code,
              :message => text
          }
      }.to_json
    end
  end

  rescue_from Api::InvalidToken do
    rack_response(error_message(50, 'invalid access token provided'), 401)
  end

  rescue_from Api::AccessDenied do
    rack_response(error_message(60, 'access denied'), 403)
  end

  rescue_from ActiveRecord::RecordNotFound do
    rack_response(error_message(70, 'not found'), 404)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response(error_message(20, e.message), e.status)
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
      payload, _ = JWT.decode(params[:token], 'key')
      raise Api::InvalidToken if payload.nil?
      puts "id --> #{payload}"
      @current_user = User.find_by!('id = ?', payload['user_id'])
      # begin
      # user = User.where(name: '123').first
      #
      #   # @current_user = User.where(id: payload['user_id']).first
      # rescue StandardError
      # end
      error!({error: 'unauthorized access'}, 401) if @current_user.nil?
    end

    def current_user
      @current_user
    end
  end

  mount UserAPI
  mount UserSessionApi
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