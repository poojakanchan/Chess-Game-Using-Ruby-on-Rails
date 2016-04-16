json.array!(@players) do |player|
  json.extract! player, :id, :name, :thumbnail
  json.url player_url(player, format: :json)
end
