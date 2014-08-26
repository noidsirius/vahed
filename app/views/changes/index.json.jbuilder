json.array!(@changes) do |change|
  json.extract! change, :id, :content
  json.url change_url(change, format: :json)
end
