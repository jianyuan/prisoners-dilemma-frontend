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

  def check_syntax
    response = RestClient.post('http://localhost:5000/verify', source_code: self.code)
    JSON.parse(response)
  end
end
