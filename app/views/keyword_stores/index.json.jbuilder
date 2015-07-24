json.array!(@keyword_stores) do |keyword_store|
  json.extract! keyword_store, :id, :image_mst_id, :keyword_mst_id
  json.url keyword_store_url(keyword_store, format: :json)
end
