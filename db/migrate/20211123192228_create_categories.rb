class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.timestamp :created_at, default: -> { "CURRENT_TIMESTAMP" }
      t.timestamp :updated_at
      t.boolean :deleted, default: false
    end

    create_table :posts_categories do |t|
      t.references :post, :category
      t.boolean :deleted, default: false
    end
  end
end
