class CreateSimilarImages < ActiveRecord::Migration
  def change
    create_table :similar_images, id:false do |t|
      t.integer :image_id_src
      t.integer :image_id_tgt
      t.float :inner_product

      t.timestamps null: false
    end
      add_index :similar_images ,[:image_id_src, :image_id_tgt], unique:true
  end
end
