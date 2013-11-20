json.array!(@game_rounds) do |game_round|
  json.extract! game_round, :name, :started_at, :ended_at
  json.url game_round_url(game_round, format: :json)
end
