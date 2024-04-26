#!/bin/bash -ex

BOARD_ID=arduino_zero NAME=samd21_sam_ba make clean all

BOARD_ID=pwfusion_r3aktor NAME=samd21_sam_ba_pwfusion_r3aktor make clean all
mv -v samd21_sam_ba_pwfusion_r3aktor.* ../r3aktor/

BOARD_ID=pwfusion_r3aktor_tc NAME=samd21_sam_ba_pwfusion_r3aktor_tc make clean all
mv -v samd21_sam_ba_pwfusion_r3aktor_tc.* ../r3aktor_tc/

echo Done building bootloaders!

