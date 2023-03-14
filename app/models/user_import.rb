class UserImport
  # Documentation for the dummyjson api can be found here:
  # https://dummyjson.com/docs/users

  attr_reader :limit

  def initialize(limit:)
    @limit = limit || 0
  end

  def import
    total_pages.times do |page_number|
      skip = skip(page_number)
      HTTParty.get("https://dummyjson.com/users?limit=#{limit}&skip=#{skip}").parsed_response['users'].each do |user_attributes|
        user_attributes = user_attributes.deep_transform_keys { |key| key.underscore }
        company_attributes = user_attributes.delete('company')
        company_address_attributes = company_attributes.delete('address')
        user_address_attributes = user_attributes.delete('address')
        bank_attributes = user_attributes.delete('bank')
        ActiveRecord::Base.transaction do
          user = User.create!(user_attributes)
          Address.create!(user_address_attributes.merge(addressable: user))
          company = Company.create!(company_attributes.merge(user: user))
          Address.create!(company_address_attributes.merge(addressable: company))
          Bank.create!(bank_attributes.merge(user: user))
        end
      end
    end
  end

  private

  def total_pages
    return 1 if limit.zero?

    100 / limit
  end

  def skip(page_number)
    page_number * limit
  end
end
