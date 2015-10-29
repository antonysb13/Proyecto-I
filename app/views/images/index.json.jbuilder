json.array!(@images) do |image|
  json.extract! image, :id, :link, :product_id
  json.url image_url(image, format: :json)
end
