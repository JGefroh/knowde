require_relative '../base/output_device'

class Display < OutputDevice
  
  def render(data)
    if data[:type] == 'product.added'
      puts "\nLCD DISPLAY: "
      puts "#{data[:payload][:name]} - #{format_as_currency(data[:payload][:price_cents])}"
    elsif data[:type] == 'product.not_found'
      puts "\nLCD DISPLAY: "
      puts "Product not found"
    end
  end

  private def format_as_currency(amount)
    # You can do more advanced currency handling here if you store currency and currency units
    # alongside the item - for now assuming US dollars, stored as cents.
    return "$#{format("%.2f", amount / 100.0)}"
  end
end
