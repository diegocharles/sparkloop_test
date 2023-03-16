class UserImporter
  # Documentation for the dummyjson api can be found here:
  # https://dummyjson.com/docs/users

  attr_reader :limit

  def initialize(limit: 0)
    @limit = limit
  end

  def import
    total_pages.times { |page_number| fetch_in_background(page_number) }
  end

  private

  def fetch_in_background(page_number)
    skip = skip(page_number)
    UserFetcherJob.perform_later(limit: limit, skip: skip)
  end

  def total_pages
    return 1 if limit.zero?

    100 / limit
  end

  def skip(page_number)
    page_number * limit
  end
end
