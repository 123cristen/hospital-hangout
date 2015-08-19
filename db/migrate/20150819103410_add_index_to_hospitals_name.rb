class AddIndexToHospitalsName < ActiveRecord::Migration
  def change
  	add_index :hospitals, :name, unique: true
  end
end
