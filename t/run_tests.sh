#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: run_tests.sh
# Created: Friday, July 27 2012
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:
# runs test in this folder

export lib_dir=$(cd `dirname $BASH_SOURCE`/..; pwd)
export t_dir=$(cd `dirname $BASH_SOURCE`; pwd)

## lets have some wrf data
export wrfout="~/DATA/wrfout.nc"

function usage()
{
    echo "pass"
}

function run_test()
{
    test_name=${1%\.*}
    log_file="/tmp/$test_name".log
    echo "running test: $test_name"
    ncl $@ |tee $log_file
    no_fatal=`grep -e "fatal" $log_file | wc -l`
    no_warn=`grep -e "Warn" $log_file | wc -l`
    if [ $? -ne 0 ]; then
        echo "$no_warn warnings, $no_fatal Fatal errors"
        echo "test: $test_name failed!"
    else
        echo "$no_warn warnings, $no_fatal Fatal errors"
        echo "test $test_name pass"
    fi
}


if [ $# -lt 1 ]
then

    for file in `ls $t_dir/*.ncl`; do
        run_test $file
    done
else
    run_test $@
fi

# run_tests.sh ends here
