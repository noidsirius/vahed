json.array!(@reports) do |report|
  json.extract! report, :id, :content, :reportable_type, :reportable_id, :user_id
  json.url report_url(report, format: :json)
end
