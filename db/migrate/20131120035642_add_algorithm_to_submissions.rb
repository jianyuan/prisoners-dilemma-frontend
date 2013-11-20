class AddAlgorithmToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :algorithm, index: true
  end
end
