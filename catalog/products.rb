class Products
  PRODUCT_DATABASE = [
    {sku: '91484', name: 'Potato', price_cents: 99 },
    {sku: '12474', name: 'Banana', price_cents: 400 },
    {sku: '9001', name: 'House', price_cents: 40000000 },
  ]

  def self.find(code)
    # This could potentially be a database lookup or web request.
    return PRODUCT_DATABASE.find{ |product| product[:sku] == code }
  end
end
