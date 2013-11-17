# == Schema Information
#
# Table name: algorithms
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  code       :binary
#  privacy    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Algorithm < ActiveRecord::Base
  belongs_to :user

  extend Enumerize
  enumerize :privacy, in: [:public, :private], default: :private

  validates :name, presence: true
  validates :privacy, presence: true
end
