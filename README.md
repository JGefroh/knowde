# Barcode

## How to run
You can run the test file via the following command:
```
ruby test.rb
```

The test file adds several items to the cart via the `Scanner` input device, and then calls the `exit` command. In a real-world scenario, `Scanner#command` would be called an arbitrary number of times.


## Sample output

```
knowde % ruby test.rb

LCD DISPLAY:
Banana - $4.00

LCD DISPLAY:
Potato - $0.99

LCD DISPLAY:
Potato - $0.99

LCD DISPLAY:
Potato - $0.99

LCD DISPLAY:
House - $400000.00

LCD DISPLAY:
Product not found

PRINTER:
Banana - $4.00
Potato - $0.99
Potato - $0.99
Potato - $0.99
House - $400000.00

Total: $400006.97
```

## General design and approach

Input and Output devices register with the Point of Sale system upon initialization of the system, similar to plugins. This will enable the parts of the system to communicate with each other.

```
pos = PointOfSale.new
scanner = Scanner.new(pos)
pos.add_input_device(scanner)
pos.add_output_device(Display.new)
pos.add_output_device(Printer.new)
```


### Products
The product catalog is defined in `catalog/products.rb`. This could potentially be a database lookup, a web request, or some other lookup. For now, it is a hard-coded, in-memory store.

### Point of Sale
The Point of Sale system (`point_of_sale.rb`) tracks the cart, and provides several public functions that can be called by input devices. It also handles sending messages to the output devices.

### Input
Input Devices have a specific interface (`base/input_device.rb`) that must be implemented.

Once registered, the Input Devices can execute commands:
```
scanner.command(:add_item, '91484') # Adds an item, if found.
```
What commands can be executed or not wholly depends on the implementation of the input device. Only `Scanner` is implemented right now, but one could imagine things like `Keypad` or even `Web`.


### Output
Output Devices also have a specific interface (`base/output_device.rb`) that must be implemented.
Once registered, the Output devices can receive requests from the Point of Sale system to render something:
```
render({type: 'product.added', payload: product})
```
It is up to the output device to determine when and what they render.

`Printer` and `Display` are implemented, but one could imagine an `Audit` output or some other item.


### Areas of improvement
* The name `render` might be overly restrictive for output devices.
* Currently, much of the possible commands and interfaces are defined as primitives - hashes, strings, symbols, etc. It'd be an improvement to define them as explicit classes to better define the interface.
* Currency support can be added by storing currency and units and using them accordingly. For now, it assumes USD cents.
