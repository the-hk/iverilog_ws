@echo off
iverilog -o first_trial_tb tb_first_trial.v first_trial.v
echo compiled
vvp first_trial_tb
echo wave form was generated
gtkwave wave.vcd
