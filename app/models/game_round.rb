# == Schema Information
#
# Table name: game_rounds
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  started_at :datetime
#  ended_at   :datetime
#  created_at :datetime
#  updated_at :datetime
#

class GameRound < ActiveRecord::Base
  has_many :submissions

  validates :name, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true
  validate :end_greater_than_start

  scope :hasnt_ended, -> { where ['ended_at > ?', Time.now] }
  scope :starts_earliest, -> { order(started_at: :asc) }

  def self.current_or_upcoming
    self.starts_earliest.hasnt_ended.first
  end

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  def end_greater_than_start
    if self.started_at > self.ended_at
      self.errors.add(:ended_at, "can't be earlier than start datetime")
    end
  end
end
