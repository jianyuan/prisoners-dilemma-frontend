# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  ic_username            :string(255)
#  name                   :string(255)
#  description            :text
#

class User < ActiveRecord::Base
  has_many :algorithms
  has_many :submissions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:eesoc]

  def name
    read_attribute(:name) || self.ic_username || self.email.split('@')[0]
  end

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  def avatar_url(size = 50)
    Identicon.data_url_for(self.id, size)
  end

  def submission_for_round(game_round)
    self.submissions.where(game_round: game_round).first
  end

  def submitted_to_round?(game_round)
    self.submissions.where(game_round: game_round).any?
  end

  class << self
    def find_for_imperial_oauth(auth, user = nil)
      # Try IC username
      user ||= User.where(ic_username: auth.uid).first

      # Try email
      user ||= User.where(email: auth.info.email).first

      user_hash = {
        ic_username: auth.uid,
        name: auth.info.name,
        email: auth.info.email,
        description: auth.info.description,
        admin: auth.extra.raw_info.admin
      }

      if user
        user.update_attributes(user_hash)
      else
        user = User.create({ password: Devise.friendly_token[0,20] }.merge(user_hash))
      end

      user
    end
  end

end
