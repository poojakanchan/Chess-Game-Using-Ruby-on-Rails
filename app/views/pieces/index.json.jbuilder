json.array!(@pieces) do |piece|
  json.extract! piece, :id, :type, :image, :row, :col
  json.url piece_url(piece, format: :json)
end
