class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.text :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
