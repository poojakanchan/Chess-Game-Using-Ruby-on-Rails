json.array!(@statistics) do |statistic|
  json.extract! statistic, :id, :wins, :loses
  json.url statistic_url(statistic, format: :json)
end
