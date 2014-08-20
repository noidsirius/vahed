json.array!(@terms) do |term|
  json.extract! term, :id, :year, :section
  json.url term_url(term, format: :json)
end
