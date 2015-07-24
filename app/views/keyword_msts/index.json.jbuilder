json.array!(@keyword_msts) do |keyword_mst|
  json.extract! keyword_mst, :id, :keyword
  json.url keyword_mst_url(keyword_mst, format: :json)
end
