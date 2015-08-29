class StatusAPI < Grape::API
  format :json
  resources 'status' do
    desc 'Status timeline'
    get do
      statuses = Status.all
      present statuses, with: Status::Entity
    end

    desc 'Publish a status'
    params do
      requires :title, type: String, desc: 'status title'
      requires :content, type: String, desc: 'status content'
    end
    post do
      authenticate_user!
      title = params[:title]
      content = params[:content]
      current_user.statuses.create!({
                                        title: title,
                                        content: content
                                    })
      wrap_response(nil)
    end
  end
end