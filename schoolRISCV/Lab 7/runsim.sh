cd program/puzyric

make build
cp program.hex ../..

cd ../..

vlib work
vlog -f list.lst -suppress 2367 +acc
vsim -c work.tb -do script.tcl
