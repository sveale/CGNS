#!/bin/sh

# sh script to launch CGNS File viewer/editor

dir=`dirname $0`

# source the setup script

if test -f $dir/cgconfig ; then
  . $dir/cgconfig
elif test -f $dir/../cgconfig ; then
  . $dir/../cgconfig
else
  if test -z "$CG_SYSTEM" && test -x $dir/cgsystem ; then
    CG_SYSTEM=`$dir/cgsystem`; export CG_SYSTEM
  fi
  if test -f $dir/$CG_SYSTEM/cgconfig ; then
    . $dir/$CG_SYSTEM/cgconfig
  fi
fi

# The normal wish will work here, but cgiowish should
# be available, and may also be used

cgiowish=""
for d in $dir $dir/$CG_SYSTEM $dir/cgnsview \
  $CG_BIN_DIR $CG_BIN_DIR/$CG_SYSTEM ; do
  if test -x $d/cgiowish ; then
    cgiowish=$d/cgiowish
    break
  fi
  if test -x $d/cgnswish/cgiowish ; then
    cgiowish=$d/cgnswish/cgiowish
    break
  fi
done
if test -z "$cgiowish" ; then
  echo "Error: cgiowish executable not found"
  exit 1
fi

# find the cgnsnodes tcl script

cgnsnodes=""
for d in $dir $dir/$CG_SYSTEM $dir/cgnsview \
  $CG_LIB_DIR $CG_LIB_DIR/$CG_SYSTEM ; do
  if test -f $d/cgnsnodes.tcl ; then
    cgnsnodes=$d/cgnsnodes.tcl
    break
  fi
  if test -f $d/cgnstools/cgnsnodes.tcl ; then
    cgnsnodes=$d/cgnstools/cgnsnodes.tcl
    break
  fi
done
if test -z "$cgnsnodes" ; then
  echo "Error: cgnsnodes.tcl script not found"
  exit 1
fi

# check that display is set

#if test -z "$DISPLAY" ; then
#  echo "Error: DISPLAY environment variable not set"
#  exit 1
#fi

# execute

exec $cgiowish $cgnsnodes