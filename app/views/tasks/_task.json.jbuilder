json.extract! task, :id, :description, :status, :user_id, :created_at, :updated_at, :username
json.url task_url(task, format: :json)