class DatabaseInitialStructure < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :firstname
      t.string :lastname
      t.timestamp :created_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamp :updated_at, null: true
      t.boolean :deleted, default: false
    end

    create_table :posts do |t|
      t.string :title
      t.string :description
      t.string :image_url
      t.timestamp :create_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamp :updated_at, null: true
      t.boolean :deleted, default: false

      t.references :user
    end

    create_table :roles do |t|
      t.string :name
      t.string :description, null: true
      t.timestamp :created_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamp :updated_at, null: true
      t.boolean :deleted, default: false
    end

    create_table :users_roles do |t|
      t.references :user
      t.references :role
      t.timestamp :create_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamp :updated_at, null: true
      t.boolean :deleted, default: false
    end
  end
end
