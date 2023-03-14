class UserFetcherJob < ApplicationJob
  queue_as :default

  def perform(limit:, skip:)
    HTTParty.get("https://dummyjson.com/users?limit=#{limit}&skip=#{skip}").parsed_response

    rescue StandardError => e
      Rails.logger.error(e)
  end
end
