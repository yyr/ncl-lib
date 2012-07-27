#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: run_tests.sh
# Created: Friday, July 27 2012
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:
## runs test in this folder

t_dir=$(cd `dirname $BASH_SOURCE`; pwd)

for file in `ls $t_dir/*.ncl`; do
    ncl $file
done



# run_tests.sh ends here
