# aclk {FREQ_HZ 166000000 CLK_DOMAIN crossbar_CLOCK PHASE 0.000} aclk1 {FREQ_HZ 166000000 CLK_DOMAIN crossbar_SDRAM_CLOCK PHASE 0.000}
# Clock Domain: crossbar_CLOCK
create_clock -name aclk -period 6.024 [get_ports aclk]
# Clock Domain: crossbar_SDRAM_CLOCK
create_clock -name aclk1 -period 6.024 [get_ports aclk1]
# Generated clocks
