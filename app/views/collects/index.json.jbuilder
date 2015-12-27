json.array!(@collects) do |collect|
  json.extract! collect, :id, :name, :text
  json.url collect_url(collect, format: :json)
end
