class UserAPI < Grape::API
  format :json
  resources 'users' do
    desc 'User register'
    params do
      requires :username, type: String, desc: 'username'
      requires :password, type: String, desc: 'password'
    end
    post do
      nickname = "USER#{DateTime.now.strftime('%Y%m%d%H%M%s')}"
      user = User.new username: params[:username], password: params[:password], nickname: nickname, email: params[:username]
      if user.save
        wrap_response(nil)
      else
        raise StandardError, user.errors.full_messages
      end
    end

    desc 'Get all users list'
    get do
      User.all
    end

    desc 'Test'
    get 'list' do
      {msg: '1112'}
    end

    get 'add' do
      {msg: '222'}
    end
  end

  resource 'user' do
    get 'qqqq' do
      {msg: 'qqq'}
    end

    get 'www' do
      {msg: 'www'}
    end

    get 'rrr' do
      {msg: 'rrr'}
    end

    get 'ttt' do
      {msg: 'ttt'}
    end
  end
end