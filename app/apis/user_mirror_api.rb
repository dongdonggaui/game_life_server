class UserMirrorAPI < Grape::API
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
        token = JWT.encode({user_id: user.id}, 'key')
        wrap_response({token: token})
      else
        raise StandardError, user.errors.full_messages
      end
    end

    desc 'Get all users list'
    get do
      users = User.all
      present users, with: UserInfo::Entity
    end
  end

  resources 'user/info' do
    before do
      authenticate_user!
    end
    desc 'Update user gender'
    params do
      requires :gender, type: String, desc: 'Gender to be update'
    end
    put 'gender' do
      gender = params[:gender]
      raise Api::InvalidParams, 'gender must be \'m\' or \'f\'' if gender != 'm' && gender != 'f'
      if current_user.update(gender: gender)
        wrap_response(nil)
      else
        raise StandardError, 'update gender error'
      end
    end

    desc 'Update user avatar'
    params do
      requires :avatar_url, type: String, desc: 'Avatar url to be update'
    end
    put 'avatar' do
      if current_user.update avatar_url: params[:avatar_url]
        wrap_response(nil)
      else
        raise StandardError, 'update avatar error'
      end
    end
  end

  resources 'mirror' do
    get do
      {msg: '444'}
    end
  end
end