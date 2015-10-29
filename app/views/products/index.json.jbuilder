json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :description, :quantity, :active, :user_id
  json.url product_url(product, format: :json)
end
