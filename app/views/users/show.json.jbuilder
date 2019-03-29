json.products @products do |product|
  json.partial! 'products/product', product: product
end

json.has_more @products.current_page < @products.total_pages
