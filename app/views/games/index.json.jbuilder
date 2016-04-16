json.array!(@games) do |game|
  json.extract! game, :id, :category, :password, :public
  json.url game_url(game, format: :json)
end
