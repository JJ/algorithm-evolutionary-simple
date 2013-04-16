#!/bin/bash

if [ -z "$1" ]
then 
    ITERATIONS=10
else
    ITERATIONS=$1
fi

if [ -z "$2" ]
then 
    DIR=/home/jmerelo/Dropbox
else
    DIR=$2
fi

if [ -z "$3" ]
then 
    PAR= 1
else
    PAR=$3
fi

echo "Running with $2 for $ITERATIONS";

for (( i=0; i < $ITERATIONS; i++ ))
do
    echo "Iteration $i in dir $DIR/$i with $PAR"
    mkdir $DIR/$i
    touch $DIR/$i/START
    for (( j=0; j < $PAR-1; j++ ))
    do
	echo "Starting $j"
	perl p-peaks-dr-best.pl $DIR/$i 512 128 &
    done
    time perl p-peaks-dr-best.pl $DIR/$i 512 128
     touch $DIR/$i/END
done