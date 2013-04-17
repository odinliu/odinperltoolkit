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
#!/usr/bin/env perl

use strict;
use warnings;
use opt::Time;
use opt::Logger;

# Test logs
my $i = 0;
&opt::Logger::Debug("this is a debug log[$i]");
$i++;
&opt::Logger::Trace("this is a trace log[$i]");
$i++;
&opt::Logger::Notice("this is a notice log[$i]");
$i++;
&opt::Logger::Warning("this is a warning log[$i]");
$i++;
&opt::Logger::Fatal("this is a fatal log[$i]");
$i++;
&opt::Logger::cDebug("this is a color debug log[$i]");
$i++;
&opt::Logger::cTrace("this is a color trace log[$i]");
$i++;
&opt::Logger::cNotice("this is a color notice log[$i]");
$i++;
&opt::Logger::cWarning("this is a color warning log[$i]");
$i++;
&opt::Logger::cFatal("this is a color fatal log[$i]");

my $passed = 0;
my $tested = 0;

# Test GetPlainTime & GetTimestamp
$tested++;
my $timestamp = time();
my $plainTime = &opt::Time::GetPlainTime($timestamp);
print STDOUT "timestamp[$timestamp] plainTime[$plainTime]\n";
my $result = &opt::Time::GetTimestamp($plainTime);
print STDOUT "origin timestamp[$timestamp] return[$result]\n";
if ($timestamp eq $result) {
    $passed++;
    print STDOUT "Test GetPlainTime & GetTimestamp passed!\n";
} else {
    die "Test GetPlainTime & GetTimestamp failed, pass[$passed/$tested]!\n";
}

# Test GetReadableTime
$tested++;
my $readableTime = &opt::Time::GetReadableTime($timestamp);
if ($plainTime =~ m/(\d{4})(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)/) {
    print STDOUT "Readable[$readableTime]\n";
    if ($readableTime eq "$1-$2-$3 $4:$5:$6") {
        $passed++;
        print STDOUT "Test GetReadableTime passed!\n";
    } else {
        die "Test GetReadableTime failed, pass[$passed/$tested]!\n";
    }
} else {
    # should never execute
    die "Test GetReadableTime failed, pass[$passed/$tested]!\n";
}
