class GameAPI < Grape::API
  format :json
  resources 'games' do
    desc 'All games list'
    # TODO 'game list'
    get do
      {games: 'games'}
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