class AddColumnToAccountsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :birthday, :string
    add_column :accounts, :last_name, :string
    
    # rename_column :posts, :description, :text_body
    rename_column :accounts, :name, :first_name
  end
end
