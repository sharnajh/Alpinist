class MakePost < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :account_id
      t.string :description
    end
  end
end
