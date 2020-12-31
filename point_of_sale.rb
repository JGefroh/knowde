require_relative 'catalog/products'

class PointOfSale
  attr_accessor :items
  attr_accessor :output_devices

  def initialize
    @items = []
    @input_devices = []
    @output_devices = []
  end

  ###
  # Setup and initialization
  ###
  def add_input_device(device)
    @input_devices.push(device)
  end

  def add_output_device(device)
    @output_devices.push(device)
  end

  ###
  # Basic functions
  ###
  def render(data)
    @output_devices.each{|device|
      device.render(data)
    }
  end

  ###
  # Operation
  ###
  def add_item_by_code(code)
    product = Products.find(code)
    if product
      @items.push(product)
      render({type: 'product.added', payload: product})
    else
      render({type: 'product.not_found'})
    end
  end

  def finalize
    render({type: 'finalize', payload: {items: items, total_sum: calculate_total_sum}})
  end

  private def calculate_total_sum
    items.inject(0){|sum, item| sum += item[:price_cents] }
  end
end
