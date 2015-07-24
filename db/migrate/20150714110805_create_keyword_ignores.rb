class CreateKeywordIgnores < ActiveRecord::Migration
  def change
    create_table :keyword_ignores do |t|
      t.integer :image_mst_id
      t.integer :keyword_mst_id

      t.timestamps null: false
    end
  end
end
