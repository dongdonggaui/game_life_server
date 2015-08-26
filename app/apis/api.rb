# require_relative 'user/user_api'
# require_relative 'user/user_session_api'
class API < Grape::API
  format :json

  rescue_from ActiveRecord::RecordNotFound do |e|
    Rack::Response.new({
                           error_code: 404,
                           error_message: e.message
                       }.to_json, 404).finish
  end

  rescue_from :all do |e|
    Rack::Response.new({
                           error_code: 500,
                           error_message: e.message
                       }.to_json, 500).finish
  end

  mount UserAPI
  mount UserSessionApi
  add_swagger_documentation api_version:'v1',
                            mount_path: '/docs',
                            hide_format: true,
                            base_path: 'http://localhost:3000/api',
                            hide_documentation_path: true,
                            info: {title: 'Game Life Api Document', description: 'This is a Api document for app Game Life', contact: 'hly@qq.com', license: 'MIT', license_url: 'http://www.baidu.com'},
                            api_documentation: { desc: 'Reticulated splines API swagger-compatible documentation.' }
end