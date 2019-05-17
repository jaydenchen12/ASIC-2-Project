#!/bin/bash
#########################################################################################
#                                                                                       #
# ASIC Design II                                                                        #
# This script generates all TCL files required for the FPU development project          #
# DO NOT MODIFY THIS SCRIPT                                                             #
#                                                                                       #
# Script authored by Matthew D'Angeli                                                   #
#                                                                                       #
#########################################################################################

source project.config

# OpenSPARC Verilog file location
OPENSPARC_VERILOG=$(find "$OPENSPARC_LOCATION"/T1-FPU "$OPENSPARC_LOCATION"/T1-common  \
   -iname *.v -printf "%f ")

OPENSPARC_COMMON_DIRS=$(find "$OPENSPARC_LOCATION"/T1-common -mindepth 1 \
   -type d -printf "$OPENSPARC_LOCATION/T1-common/%f ")

CELL_LIB_PREFIX="$PDK_LOCATION"'/lib/stdcell_'"$VOLTAGE_THRESHOLD"'/db_ccs/saed32'"$VOLTAGE_THRESHOLD"
SRAM_PREFIX="$PDK_LOCATION"'/lib/sram/db_ccs/saed32sram'

LINK_LIB_LIST=$(ls -p "$CELL_LIB_PREFIX"_"${TARGET_CORNER%v*}"*.db | tr '\n' ' ')
SRAM_LIB_LIST=$(ls -p "$SRAM_PREFIX"_"${TARGET_CORNER%v*}"*.db | tr '\n' ' ')

LINK_LIB='[ list '"$LINK_LIB_LIST""$SRAM_LIB_LIST"']'
TARGET_LIB='[ list '"$CELL_LIB_PREFIX"'_'"$TARGET_CORNER"'.db '"$SRAM_PREFIX"'_'"$TARGET_CORNER"'.db ]'

cd syn && source generate.sh && cd ..

cd pt_pre && source generate.sh && cd ..

cd icc_pnr/scripts && source generate_init_design.sh && cd ../..
