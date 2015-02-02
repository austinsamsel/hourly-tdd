json.array!(@works) do |work|
  json.extract! work, :id, :start_time, :end_time, :title, :description, :billed
  json.url work_url(work, format: :json)
end
