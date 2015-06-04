
REM
REM   ____  ____
REM  /   /\/   /
REM /___/  \  /    Vendor: Xilinx
REM \   \   \/     Version : 1.7
REM  \   \         Application : Virtex-5 FPGA GTX Transceiver Wizard
REM  /   /         Filename : implement_sh.ejava
REM /___/   /\     Timestamp :
REM \   \  /  \
REM  \___\/\___\
REM
REM
REM implement.sh script
REM Generated by Xilinx GTX Transceiver Wizard
REM

REM Set XST as default synthesizer

REM Read command line arguments

REM Change CWD to results

REM Clean results directory
REM Create results directory
REM Change current directory to results
ECHO WARNING: Removing existing results directory
RMDIR /S /Q results
MKDIR results
COPY xst.prj      .\results\
COPY xst.scr      .\results\
COPY *.ngc        .\results\

REM Run Synthesis

ECHO "### Running Xst - "
xst -ifn xst.scr

COPY gtxf_top.ngc .\results
cd .\results

REM Run ngdbuild

ngdbuild -uc ..\..\example_design\gtxf_top.ucf -p xc5vfx70t-ff1136-1 gtxf_top.ngc gtxf_top.ngd

REM end run ngdbuild section

REM Run map

ECHO 'Running NGD'
map -p xc5vfx70t-ff1136-1 -o mapped.ncd gtxf_top.ngd

REM Run par

ECHO 'Running par'
par mapped.ncd routed.ncd

REM Report par results

ECHO 'Running design through bitgen'
bitgen -w routed.ncd

REM Trace Report

ECHO 'Running trce'
trce -e 10 routed.ncd mapped.pcf -o routed 

REM Run netgen

ECHO 'Running netgen to create gate level Verilog model'
netgen -ofmt verilog -sim -dir . -tm gtxf_top -w routed.ncd routed.v

REM Change directory to implement

CD ..

