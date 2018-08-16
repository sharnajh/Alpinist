class ChangePostsTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :description, :text_body

    add_column :posts, :post_picture, :string
    add_column :posts, :post_title, :string
  end
end
