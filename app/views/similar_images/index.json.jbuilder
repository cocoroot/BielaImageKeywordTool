json.array!(@similar_images) do |similar_image|
  json.extract! similar_image, :id, :image_msts_id, :keyword_msts_id, :inner_product
  json.url similar_image_url(similar_image, format: :json)
end
