#!/bin/bash

set_dir1() {
for i in 0 1 2 3 4 5 6 7
  do
    echo 33$i > /sys/class/gpio/export
    echo out > /sys/class/gpio/gpio33$i/direction
  done
}




dir="none"
value=-1
gpio=-1

set_dir() {
    echo "set gpio $1 to $2 direction"
    echo $2 > /sys/class/gpio/gpio$1/direction
}

set_value() {
	echo "set gpio $1 value to $2"
    echo $2 > /sys/class/gpio/gpio$1/value
}

read_gpio() {
    echo "GPIO pin $1"
	echo -n "  dir:"
	cat /sys/class/gpio/gpio$1/direction

	echo -n "  value:"
	cat /sys/class/gpio/gpio$1/value
}

usage()
{
    cat >&2 << EOF 
Usage: ${0} [OPTION]...
Options:
  -g gpio           The gpio pin to access
  -d direction      Set gpio direction <out|in>
  -v value          Set value of Cloud LED GPIO <0|1>
  -h                Show this help message
EOF
    exit 1

}

OPTIONS=`getopt g:d:v:h "$0" "$@"`

eval set -- "$OPTIONS"

while true; do
    case "$1" in
    -g)
        gpio=$2
        shift 2
        ;;
    -d) 
        dir=$2
        shift 2
        ;;
    -v) 
        value=$2
        shift 2
        ;;
    -h) 
        usage
        exit
        ;;
    --) 
        shift
        break
        ;;
    *)  
        echo "Internal error!" >&2
        exit 1
        ;;
    esac
done

if [ "$gpio" == -1 ];then
    usage
    exit 1
fi
if [ "$dir" == "out" ] || [ "$dir" == "in" ];then
    set_dir $gpio $dir
fi

if [ "$value" == "1" ] || [ "$value" == "0" ];then
    set_value $gpio $value
fi

read_gpio $gpio


