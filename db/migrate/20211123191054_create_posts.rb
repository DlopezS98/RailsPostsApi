class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.string :short_description
      t.string :image_url
      t.boolean :deleted, default: false

      t.timestamp :created_at, default: -> { "CURRENT_TIMESTAMP" }
      t.timestamp :updated_at
      t.references :user
    end
  end
end
