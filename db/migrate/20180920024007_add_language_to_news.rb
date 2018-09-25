class AddLanguageToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :language, :text, null: false, default: "English"
    add_index :news, :language
  end
end
