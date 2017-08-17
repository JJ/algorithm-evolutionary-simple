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

echo "Running with $2 for $ITERATIONS";

for (( i=0; i < ITERATIONS; i++ ))
do
    echo "Iteration $i in dir $DIR/$i with $PAR"
    mkdir "$DIR/$i"
    touch "$DIR/$i/START"
    rsh jjmerelo@192.168.56.10 "cd progs/SimplEA/Algorithm-Evolutionary-Simple/apps; perl p-peaks-dr.pl $DIR/$i"  &
    time perl p-peaks-dr.pl "$DIR/$i" 512 1024
    touch "$DIR/$i/END"
done
