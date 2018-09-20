class AddLanguageToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :language, :text, null: false, default: "English"
  end
end
