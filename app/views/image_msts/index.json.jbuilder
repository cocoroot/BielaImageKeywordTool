json.array!(@image_msts) do |image_mst|
  json.extract! image_mst, :id, :filename
  json.url image_mst_url(image_mst, format: :json)
end
