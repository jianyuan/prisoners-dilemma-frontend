# == Schema Information
#
# Table name: algorithms
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  name                  :string(255)
#  code                  :text
#  privacy               :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  benchmark_against     :boolean          default(FALSE)
#  original_algorithm_id :integer
#

class Algorithm < ActiveRecord::Base
  belongs_to :user
  belongs_to :original_algorithm, class_name: 'Algorithm'

  extend Enumerize
  enumerize :privacy, in: [:public, :private], default: :private, predicates: true, scope: true

  has_paper_trail only: [:name, :code]

  validates :name, presence: true
  validates :privacy, presence: true

  scope :benchmarkable, -> { where(benchmark_against: true) }
  scope :latest, -> { order(updated_at: :desc) }

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  def check_syntax
    response = RestClient.post('http://localhost:5000/verify', source_code: self.code)
    JSON.parse(response)
  end

  def benchmark(iterations = 100)
    names = {}
    names[self.id] = self.name
    source_codes = {}
    source_codes[self.id] = self.code

    Algorithm.benchmarkable.each do |algorithm|
      names[algorithm.id] = algorithm.name
      source_codes[algorithm.id] = algorithm.code
    end

    json_response = RestClient.post('http://localhost:5000/round_robin', source_codes: source_codes.to_json, iterations: iterations)
    response = JSON.parse(json_response)

    response['points'] = response['points'].sort_by { |_, value| value }.map do |row|
      {
        id: row[0].to_i,
        points: row[1].to_i
      }
    end.reverse
    response['names'] = names

    response
  end

  def copy_to_user(user)
    new_algorithm = user.algorithms.new
    new_algorithm.original_algorithm = self
    new_algorithm.name = self.name
    new_algorithm.code = self.code
    new_algorithm.save!

    new_algorithm
  end
end
