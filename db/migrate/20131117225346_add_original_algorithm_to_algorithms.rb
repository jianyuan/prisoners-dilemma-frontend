class AddOriginalAlgorithmToAlgorithms < ActiveRecord::Migration
  def change
    add_reference :algorithms, :original_algorithm, index: true
  end
end
