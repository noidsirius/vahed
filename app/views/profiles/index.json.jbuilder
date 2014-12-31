json.array!(@profiles) do |profile|
  json.extract! profile, :id, :first_name, :second_name, :entrance_year, :student_no, :user_id
  json.url profile_url(profile, format: :json)
end
