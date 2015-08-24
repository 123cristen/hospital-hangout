class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
    	t.string :name, :email, :password_digest, :type
      t.timestamps null: false
    end
    drop_table :users
    drop_table :hospitals
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
