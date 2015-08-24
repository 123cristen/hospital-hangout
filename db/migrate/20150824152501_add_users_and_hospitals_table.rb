class AddUsersAndHospitalsTable < ActiveRecord::Migration
  def change
  	create_table :hospitals do |t|
  		t.string :name
  		t.string :email
  		t.string :password_digest

  		t.timestamps
  	end

  	create_table :users do |t|
  		t.string :name
  		t.string :email
  		t.string :password_digest
  		
  		t.references :hospital

  		t.timestamps
  	end
  end
end
