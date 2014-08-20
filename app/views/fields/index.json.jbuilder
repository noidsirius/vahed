json.array!(@fields) do |field|
  json.extract! field, :id, :title
  json.url field_url(field, format: :json)
end
