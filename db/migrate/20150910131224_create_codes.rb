class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
    	t.string :code_digest
    	t.references :hospital
      t.timestamps null: true
    end
  end
end
