
iverilog -o counter_tb tb_counter.v counter.v
echo "compiled"
vvp counter_tb
echo "wave form was generated"
gtkwave wave.vcd