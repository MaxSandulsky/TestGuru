class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.references :category, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: 'users' }
      t.integer :level, null: false, default: 1
      t.string :title, null: false

      t.timestamps
    end
  end
end
