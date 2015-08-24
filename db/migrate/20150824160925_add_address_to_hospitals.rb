class AddAddressToHospitals < ActiveRecord::Migration
  def change
  	add_column :hospitals, :address_line_1, :string
  	add_column :hospitals, :address_line_2, :string
  	add_column :hospitals, :city, :string
  	add_column :hospitals, :state, :string
  	add_column :hospitals, :zip, :string
  end
end
