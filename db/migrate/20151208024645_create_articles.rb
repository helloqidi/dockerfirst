class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :descriptoin

      t.timestamps null: false
    end
  end
end
