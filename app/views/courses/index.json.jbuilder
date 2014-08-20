json.array!(@courses) do |course|
  json.extract! course, :id, :title, :content, :unit_num, :code
  json.url course_url(course, format: :json)
end
