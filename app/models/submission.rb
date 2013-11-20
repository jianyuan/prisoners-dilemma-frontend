# == Schema Information
#
# Table name: submissions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  game_round_id :integer
#  name          :string(255)
#  code          :text
#  created_at    :datetime
#  updated_at    :datetime
#  algorithm_id  :integer
#

class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_round
  belongs_to :algorithm

  validates :user, presence: true
  validates :game_round, presence: true
  validates :name, presence: true
  validates :code, presence: true

  def set_algorithm(algorithm)
    self.algorithm = algorithm
    self.name = algorithm.name
    self.code = algorithm.code
  end
end
