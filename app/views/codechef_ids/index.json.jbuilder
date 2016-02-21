json.array!(@codechef_ids) do |codechef_id|
  json.extract! codechef_id, :id, :username, :user_id
  json.url codechef_id_url(codechef_id, format: :json)
end
