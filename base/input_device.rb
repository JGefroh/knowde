class InputDevice
  def initialize(point_of_sale)
    @point_of_sale = point_of_sale
  end

  def command(command, payload = {})
    # Implemented by subclasses
    # The device will ultimately call this function as it is being used.
  end
end
