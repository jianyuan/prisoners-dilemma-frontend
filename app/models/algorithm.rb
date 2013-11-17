# == Schema Information
#
# Table name: algorithms
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  name              :string(255)
#  code              :text
#  privacy           :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  benchmark_against :boolean          default(FALSE)
#

class Algorithm < ActiveRecord::Base
  belongs_to :user

  extend Enumerize
  enumerize :privacy, in: [:public, :private], default: :private

  validates :name, presence: true
  validates :privacy, presence: true

  scope :benchmarkable, -> { where(benchmark_against: true) }

  def check_syntax
    response = RestClient.post('http://localhost:5000/verify', source_code: self.code)
    JSON.parse(response)
  end

  def benchmark
    names = {}
    names[self.id] = self.name
    source_codes = {}
    source_codes[self.id] = self.code

    Algorithm.benchmarkable.each do |algorithm|
      names[algorithm.id] = algorithm.name
      source_codes[algorithm.id] = algorithm.code
    end

    json_response = RestClient.post('http://localhost:5000/round_robin', source_codes: source_codes.to_json)
    response = JSON.parse(json_response)

    response['points'] = response['points'].sort_by { |_, value| value }.map do |row|
      {
        id: row[0].to_i,
        points: row[1].to_i
      }
    end
    response['names'] = names

    response
  end
end
