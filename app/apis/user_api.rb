class UserAPI < Grape::API
  include Grape::Entity::DSL
  format :json
  resources 'users' do
    desc 'User register'
    params do
      requires :username, type: String, desc: 'user login account', documentation: {example: 'hly@qq.com'}
      requires :password, type: String, desc: 'user login password', documentation: {example: '111111'}
    end
    post do
      status 200
      t = DateTime.now.strftime('%Y%m%d%H%M%S')
      nickname = "USER#{t}"
      user = User.new(username: params[:username], password: params[:password], email: params[:username], nickname: nickname)
      if user.save
        {success: true}
      else
        {error: user.errors.full_messages}
      end
    end
  end

  resource 'user' do
    before do
      authenticate_user!
    end
    resource  'info' do
      desc 'Get user info'
      get do
        present current_user, with: UserInfo::Entity
      end
    end
  end
end