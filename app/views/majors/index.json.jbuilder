json.array!(@majors) do |major|
  json.extract! major, :id, :title, :code
  json.url major_url(major, format: :json)
end
