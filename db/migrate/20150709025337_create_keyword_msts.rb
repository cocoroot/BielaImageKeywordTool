class CreateKeywordMsts < ActiveRecord::Migration
  def change
    create_table :keyword_msts do |t|
      t.string :keyword

      t.timestamps null: false
    end
  end
end
