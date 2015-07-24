json.array!(@keyword_ignores) do |keyword_ignore|
  json.extract! keyword_ignore, :id, :image_mst_id, :keyword_mst_id
  json.url keyword_ignore_url(keyword_ignore, format: :json)
end
