# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  address          :string
#  addressable_type :string           not null
#  city             :string
#  coordinates      :string
#  postal_code      :string
#  state            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint           not null
#
# Indexes
#
#  index_addresses_on_addressable  (addressable_type,addressable_id)
#
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
end
