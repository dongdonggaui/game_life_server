class GameAPI < Grape::API
  format :json
  resources 'games' do
    desc 'All games list'
    get do
      Game.all
    end

    desc 'Add new game'
    params do
      requires :name, type: String, desc: 'Game name'
      requires :description, type: String, desc: 'Game Description'
      requires :company, type: String, desc: 'Game company'
      requires :publish_time, type: Date, desc: 'Game publish time'
    end
    post do
      Game.create! name: params[:name], description: params[:description], company: params[:company], publish_time: params[:pubsh_time]
      wrap_response(nil)
    end

    desc 'test'
    get 'list1' do
      users = User.all
      present users, with: UserInfo::Entity
    end

    get 'list' do
      {msg: '23456'}
    end
  end
end