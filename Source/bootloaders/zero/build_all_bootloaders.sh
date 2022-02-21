#!/bin/bash -ex

BOARD_ID=arduino_zero NAME=samd21_sam_ba make clean all

BOARD_ID=pwfusion_r3aktor NAME=samd21_sam_ba_pwfusion_r3aktor make clean all
mv -v samd21_sam_ba_pwfusion_r3aktor.* ../r3aktor/


echo Done building bootloaders!

