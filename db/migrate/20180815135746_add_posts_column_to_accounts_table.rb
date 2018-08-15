class AddPostsColumnToAccountsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :user_posts, :string, array: true
  end
end
