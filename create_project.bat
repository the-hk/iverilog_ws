@echo off
REM === Check parameter ===
if "%~1"=="" (
    echo Usage: new_project project_name
    exit /b 1
)

set PROJECT=%~1

REM === Create project folder ===
mkdir %PROJECT%
cd %PROJECT%

REM === Create main Verilog module ===
> %PROJECT%.v (
echo // %PROJECT%.v
echo module %PROJECT%^(
echo     input wire a,
echo     input wire b,
echo     output wire y
echo ^);
echo.
echo assign y = a & b; // simple AND gate for demo
echo.
echo endmodule
)

REM === Create testbench ===
> tb_%PROJECT%.v (
echo // tb_%PROJECT%.v
echo `timescale 1ns/1ps
echo.
echo module tb_%PROJECT%;
echo reg a, b;
echo wire y;
echo.
echo %PROJECT% uut ^(
echo     .a(a^),
echo     .b(b^),
echo     .y(y^)
echo ^);
echo.
echo initial begin
echo     $dumpfile("wave.vcd"^);
echo     $dumpvars(0, tb_%PROJECT%^);
echo.
echo     a = 0; b = 0;
echo     #10 a = 1;
echo     #10 b = 1;
echo     #10 a = 0;
echo     #10 $finish;
echo end
echo endmodule
)

REM === Create run.bat ===
> run.bat (
echo @echo off
echo iverilog -o %PROJECT%_tb tb_%PROJECT%.v %PROJECT%.v
echo echo compiled
echo vvp %PROJECT%_tb
echo echo wave form was generated
echo gtkwave wave.vcd
)

echo Project %PROJECT% was created successfully!
