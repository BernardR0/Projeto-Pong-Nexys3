## Clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

## VGA Syncs
set_property PACKAGE_PIN U11 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports hsync]

set_property PACKAGE_PIN V11 [get_ports vsync]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]

## RGB (3 bits)
set_property PACKAGE_PIN W10 [get_ports {rgb[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[2]}]

set_property PACKAGE_PIN W11 [get_ports {rgb[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[1]}]

set_property PACKAGE_PIN Y11 [get_ports {rgb[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[0]}]

## Botões
set_property PACKAGE_PIN U18 [get_ports btn_up]
set_property IOSTANDARD LVCMOS33 [get_ports btn_up]

set_property PACKAGE_PIN T18 [get_ports btn_down]
set_property IOSTANDARD LVCMOS33 [get_ports btn_down]
