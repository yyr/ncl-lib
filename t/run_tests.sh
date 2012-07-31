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

function initialize_report()
{
    printf "\n\nReport: Tests started at %s\n" "`date`" > $report_file
    line=$(printf '%0.1s' "-"{1..70})
    printf "%s\n" $line >> $report_file
    printf "| %-30s| %-10s | %-10s| %-10s| %-10s\n" \
        "Test Name" "passed" "Warnings" "Fatal" >> $report_file
    printf "%s\n" $line >> $report_file
}

function print_report()
{
    printf "| %-30s| %-10s | %-10s| %-10d|\n" \
        "$test_name" "$passed" "$no_warn" "$no_fatal" >> $report_file

}

function run_test()
{
    test_name=${1##*/}
    test_name=${test_name%\.*}
    no_warn=0
    no_fatal=0
    log_file="/tmp/$test_name".log
    passed="no"

    printf "\n\n\nStarted running test: %s\n\n" "$test_name"
    ncl $@ |tee $log_file
    test_exit_status=$?

    echo "DONE test: $test_name , exit status is: $test_exit_status"

    no_fatal=`grep -i "fatal" $log_file | wc -l`
    no_warn=`grep -i "Warn" $log_file | wc -l`

    if [[ $test_exit_status != 0 || $$no_fatal != 0 || $no_warn != 0 ]]; then
        print_report
    else
        passed="yes"
        print_report
    fi
}

report_file="/tmp/$$.log"
initialize_report

if [ $# -lt 1 ]
then

    for file in `ls $t_dir/*.ncl`; do
        run_test $file
    done
else
    run_test $@
fi

cat $report_file

# run_tests.sh ends here
