class UserApiHandler
  attr_reader :limit, :skip

  def initialize(limit: 0, skip: 0)
    @limit = limit
    @skip = skip
  end

  def fetch_and_create_users
    response = HTTParty.get("https://dummyjson.com/users?limit=#{limit}&skip=#{skip}")
    response.parsed_response['users'].each do |user_attributes|
      UserCreator.new(user_attributes).create!
    end
  end
end
