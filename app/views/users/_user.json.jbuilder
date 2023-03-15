json.merge!(user.attributes) do
end
json.company do
  json.merge!(user.company.attributes)
  json.address do
    json.merge!(user.company.address.attributes)
  end
end
json.address do
  json.merge!(user.address.attributes)
end
json.bank do
  json.merge!(user.bank.attributes)
end
json.url user_url(user, format: :json)
