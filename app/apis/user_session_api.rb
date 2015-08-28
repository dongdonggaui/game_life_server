class UserSessionApi < Grape::API
  format :json
  resource 'login' do
    desc 'User login'
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post do
      status 200
      user = User.where(username: params[:username]).first
      if user && user.authenticate(params[:password])
        {token: JWT.encode({user_id: user.id}, 'key')}
      else
        {error: 'wrong username or password'}
      end
    end
    get 'test' do
      {message: 'test'}
    end
    get 'test11' do
      {message: 'test1'}
    end
  end
end