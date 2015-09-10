class RemoveTimestampsFromCodes < ActiveRecord::Migration
  def change
  	remove_column :codes, :created_at
  	remove_column :codes, :updated_at
  end
end
