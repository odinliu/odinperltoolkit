##########################################################################
# Copyright 2013 Liu Yiding(Odin) odinushuaia@gmail.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

##########################################################################
# A package with time process method
##########################################################################
package opt::Time;

use strict;
use Time::Local;
use POSIX qw/strftime/;

##########################################################################
# change yyyyMMddhhmmss format into unix timestamp
# @param time yyyyMMddhhmms
# @return unix timestamp
##########################################################################
sub GetTimestamp {
    my ($time) = @_;
    if ($time =~ m/(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/) {
        my ($year, $month, $day, $hour, $minute, $second) = ($1, $2, $3, $4, $5,
            $6);
        my $stamp = timelocal($second, $minute, $hour, $day, $month-1, $year);
        return $stamp;
    }
    return 0;
}

##########################################################################
# get yyyyMMddhhmmss format date
# @param[option] timestamp, if not pass, use current time
# @return yyyyMMddhhmmss format string
##########################################################################
sub GetPlainTime {
    my ($timestamp) = @_;
    unless (defined $timestamp) {
        $timestamp = time;
    }
    my ($tmps, $tmpm, $tmph, $tmpd, $tmpn, $tmpy) = localtime($timestamp);
    $tmpy += 1900;
    my $ts = sprintf("%.4d%.2d%.2d%.2d%.2d%.2d", $tmpy, $tmpn+1, $tmpd, $tmph,
        $tmpm, $tmps);
    return $ts;
}

##########################################################################
# get yyyy-MM-dd hh:mm:ss format date
# @param[option] timestamp, if not pass, use current time
# @return yyyy-MM-dd hh:mm:ss format string
##########################################################################
sub GetReadableTime {
    my ($timestamp) = @_;
    unless (defined $timestamp) {
        $timestamp = time;
    }
    return strftime "%Y-%m-%d %H:%M:%S", localtime($timestamp);
}

1;
