require_relative 'point_of_sale'

require_relative 'outputs/display'
require_relative 'outputs/printer'
require_relative 'inputs/scanner'


pos = PointOfSale.new
scanner = Scanner.new(pos)
pos.add_input_device(scanner)
pos.add_output_device(Display.new)
pos.add_output_device(Printer.new)

scanner.command(:add_item, '12474')
scanner.command(:add_item, '91484')
scanner.command(:add_item, '91484')
scanner.command(:add_item, '91484')
scanner.command(:add_item, '9001')
scanner.command(:add_item, 'fake')
scanner.command(:exit) # Not a fan of the word exit for this, but using here since it is specifically asked for.
