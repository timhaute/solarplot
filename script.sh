#! /bin/bash
rmmod cdc_acm
rmmod ftdi_sio
rmmod usbserial
modprobe usbserial vendor=0x1fef product=0x2018
modprobe ftdi_sio
/bin/stty -F /dev/ttyUSB0 1:0:bd:0:0:0:0:0:0:0:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
exit 0
