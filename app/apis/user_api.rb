class UserAPI < Grape::API
  format :json
  resources 'users' do
    desc 'User register'
    params do
      requires :username, type: String, desc: 'user login account', documentation: {example: 'hly@qq.com'}
      requires :password, type: String, desc: 'user login password', documentation: {example: '111111'}
    end
    post do
      status 200
      user = User.new(username: params[:username], password: params[:password])
      if user.save
        {success: true}
      else
        {error: user.errors.full_messages}
      end
    end
  end
end