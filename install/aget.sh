#!/bin/bash

version=0.5
vdate=2013-10-08

echo
echo "Anezi Get version $version date $vdate."
echo "      Ubuntu applications installer."
echo

if [ $# -eq 0 ]
  then
    echo "No arguments supplied."
    exit
fi

if [ -z "$1" ]
  then
    echo "No argument supplied."
    exit
fi

cd /tmp

# Remove program name from arguments list
shift

programs=""

for i in $*
do
    programs="$programs $i"
done

for prog in $programs
do

  old="$IFS"
  IFS=":"
  set "$prog"
  IFS="$old"
  
  program=$0
  
  echo "Program to install: '$program'"
  exit
  
  
  shift
  
  args=""
   
  for i in $*
  do
      args="$args $i"
  done
  
  echo -n "Trying to download $prog ... "
  
  wget -q sh.anezi.net/$prog -O $prog
  
  if [ ! -f "$prog" ]
  then
      echo "Fails!"
      exit
  fi
  
  echo "OK."
  
  echo "Executing $prog ... "
  
  sh $prog $args
  
  echo -n "Removing $prog ... "
  rm $prog
  echo "OK."
  
done

echo "Finish!"
