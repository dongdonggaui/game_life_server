require 'spec_helper'

describe UserSessionApi, type: :request do
  before :each do
    @user = User.create!(username: 'test', password: '123456')
  end
  it 'should create session' do
    post '/api/user_session', username: @user.username, password: @user.password
    response.status.should be == 200
    body = JSON.parse(response.body)
    body['token'].should_not be_nil
    body['error'].should be_nil
  end
end