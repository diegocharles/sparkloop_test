# == Schema Information
#
# Table name: banks
#
#  id          :bigint           not null, primary key
#  card_expire :string
#  card_number :string
#  card_type   :string
#  currency    :string
#  iban        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_banks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Bank < ApplicationRecord
  belongs_to :user
end
