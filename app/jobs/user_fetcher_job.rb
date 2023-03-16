class UserFetcherJob < ApplicationJob
  queue_as :default

  def perform(limit:, skip:)
    UserApiHandler.new(limit: limit, skip: skip).fetch_and_create_users

    rescue StandardError => e
      Rails.logger.error(e)
  end
end
