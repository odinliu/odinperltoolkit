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
