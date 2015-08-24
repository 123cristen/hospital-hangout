class AddIndicesToUsersAndHospitals < ActiveRecord::Migration
  def change
  	add_index :hospitals, :email, unique: true
  	add_index :users, :email, unique: true
  end
end
