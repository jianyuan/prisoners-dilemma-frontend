# == Schema Information
#
# Table name: submissions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  game_round_id :integer
#  name          :string(255)
#  code          :binary
#  created_at    :datetime
#  updated_at    :datetime
#

class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_round
end
