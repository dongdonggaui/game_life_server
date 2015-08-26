require 'spec_helper'

describe UserAPI, type: :request do
  it 'should create user' do
    post '/api/users', username: 'test', password: '123456'
    response.status.should be == 200
    body = JSON.parse(response.body)
    body['success'].should be_true
    User.count.should be == 1
  end
end