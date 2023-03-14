class UserImport
  # Documentation for the dummyjson api can be found here:
  # https://dummyjson.com/docs/users

  attr_reader :limit, :skip

  def initialize(limit:, skip:)
    @limit = limit || 0
    @skip = skip || 0
  end

  def import
    HTTParty.get("https://dummyjson.com/users?limit=#{limit}&skip=#{skip}").parsed_response
  end
end
