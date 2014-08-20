json.array!(@plans) do |plan|
  json.extract! plan, :id, :title, :content, :shared, :score
  json.url plan_url(plan, format: :json)
end
