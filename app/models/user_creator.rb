class UserCreator
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes.deep_transform_keys { |key| key.underscore }
  end

  def create!
    ActiveRecord::Base.transaction do
      user = User.create!(user_attributes)
      Address.create!(user_address_attributes.merge(addressable: user))
      company = Company.create!(company_attributes.merge(user: user))
      Address.create!(company_address_attributes.merge(addressable: company))
      Bank.create!(bank_attributes.merge(user: user))
    end
  end

  private

  def user_attributes
    attributes.except('address', 'company', 'bank')
  end

  def user_address_attributes
    attributes['address']
  end

  def company_attributes
    attributes['company'].except('address')
  end

  def bank_attributes
    attributes['bank']
  end

  def company_address_attributes
    attributes.dig('company', 'address')
  end
end
