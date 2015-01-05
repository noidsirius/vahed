json.array!(@recruits) do |recruit|
  json.extract! recruit, :id, :user_id, :category
  json.url recruit_url(recruit, format: :json)
end
