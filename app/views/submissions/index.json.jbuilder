json.array!(@submissions) do |submission|
  json.extract! submission, :user_id, :game_round_id, :name, :code
  json.url submission_url(submission, format: :json)
end
