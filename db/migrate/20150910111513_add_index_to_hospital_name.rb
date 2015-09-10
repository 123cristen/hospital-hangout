class AddIndexToHospitalName < ActiveRecord::Migration
  def change
  	add_index :hospitals, :name, unique: true
  	remove_index :hospitals, :email
  end
end
