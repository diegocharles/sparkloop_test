# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  age         :integer
#  birth_date  :date
#  blood_group :string
#  domain      :string
#  ein         :string
#  email       :string
#  eye_color   :string
#  first_name  :string
#  gender      :string
#  hair        :string
#  height      :integer
#  image       :string
#  ip          :string
#  last_name   :string
#  mac_address :string
#  maiden_name :string
#  password    :string
#  phone       :string
#  ssn         :string
#  university  :string
#  user_agent  :string
#  username    :string
#  weight      :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :last_name, presence: true

  has_one :bank
  has_one :company
  has_one :address, as: :addressable
end
