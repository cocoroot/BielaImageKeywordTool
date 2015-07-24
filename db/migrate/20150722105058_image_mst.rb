class ImageMst < ActiveRecord::Migration
  def change
	add_column :image_msts, :vector_size, :float
  end
end
