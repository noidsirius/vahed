json.array!(@units) do |unit|
  json.extract! unit, :id, :exam_date, :capacity, :code
  json.url unit_url(unit, format: :json)
end
