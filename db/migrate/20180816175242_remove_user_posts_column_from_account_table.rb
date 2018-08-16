class RemoveUserPostsColumnFromAccountTable < ActiveRecord::Migration[5.2]
  def change
    remove_column(:accounts, :user_posts)
  end
end
