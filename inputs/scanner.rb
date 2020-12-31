require_relative '../base/input_device'

class Scanner < InputDevice
  def initialize(point_of_sale)
    @point_of_sale = point_of_sale
  end

  def command(command, payload = {})
    if command == :add_item
      @point_of_sale.add_item_by_code(payload)
    elsif command == :exit
      @point_of_sale.finalize()
    end
  end
end
