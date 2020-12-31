require_relative '../base/output_device'

class Printer < OutputDevice
  def render(data)
    if data[:type] == 'finalize'
      puts "\nPRINTER: "
      items = data[:payload][:items]
      items.each{|item|
        puts "#{item[:name]} - #{format_as_currency(item[:price_cents])}"
      }
      puts "\nTotal: #{format_as_currency(data[:payload][:total_sum])}"
    end
  end

  private def format_as_currency(amount)
    # You can do more advanced currency handling here if you store currency and currency units
    # alongside the item - for now assuming US dollars, stored as cents.
    # Note - duplication in display.
    return "$#{format("%.2f", amount / 100.0)}"
  end
end
