json.array!(@locations) do |location|
  json.extract! location, :id, :row, :col
  json.url location_url(location, format: :json)
end
