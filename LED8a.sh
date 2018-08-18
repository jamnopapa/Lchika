#!/bin/sh

dir="none"
value=-1
gpio=-1

set_dir() {
for i in 0 1 2 3 4 5 6 7
do
echo 33$i > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio33$i/direction
done
}

set_value() {
while [ true ];
do
for i in 0 1 2 3 4 5 6 7
do
echo  1  > /sys/class/gpio/gpio33$i/value
sleep 0.01
done
sleep 0.5
for i in 7 6 5 4 3 2 1 0
do
echo  0  > /sys/class/gpio/gpio33$i/value
sleep 0.01
done
sleep 0.5
done
}

