json.array!(@products) do |product|
  json.id           product.id
  json.name         product.name
  json.price        number_to_currency(product.price)
  json.image_url    image_tag(product.image.normal)
end