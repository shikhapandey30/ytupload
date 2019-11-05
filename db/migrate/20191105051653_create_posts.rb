class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :v_upload
      t.string :category

      t.timestamps
    end
  end
end