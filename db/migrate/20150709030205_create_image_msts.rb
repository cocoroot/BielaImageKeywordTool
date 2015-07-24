class CreateImageMsts < ActiveRecord::Migration
  def change
    create_table :image_msts do |t|
      t.string :filename

      t.timestamps null: false
    end
  end
end
