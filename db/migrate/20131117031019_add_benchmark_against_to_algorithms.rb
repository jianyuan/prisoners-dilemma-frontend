class AddBenchmarkAgainstToAlgorithms < ActiveRecord::Migration
  def change
    add_column :algorithms, :benchmark_against, :boolean, default: false
  end
end
