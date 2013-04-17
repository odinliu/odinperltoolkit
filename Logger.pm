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
package opt::Logger;

use strict;
use Term::ANSIColor;
use opt::Time;

my $DEBUG = (1<<1);
my $TRACE = (1<<2);
my $NOTICE = (1<<3);
my $WARNING = (1<<4);
my $FATAL = (1<<5);

sub Debug {
    my ($str) = @_;
    &_PrintLog("DEBUG", $str, 1);
}

sub cDebug {
    my ($str) = @_;
    &_PrintLogColor("DEBUG", $str, $DEBUG);
}

sub Trace {
    my ($str) = @_;
    &_PrintLog("TRACE", $str);
}

sub cTrace {
    my ($str) = @_;
    &_PrintLogColor("TRACE", $str, $TRACE);
}

sub Notice {
    my ($str) = @_;
    &_PrintLog("NOTICE", $str);
}

sub cNotice {
    my ($str) = @_;
    &_PrintLogColor("NOTICE", $str, $NOTICE);
}

sub Warning {
    my ($str) = @_;
    &_PrintLog("WARNING", $str, 2);
}

sub cWarning {
    my ($str) = @_;
    &_PrintLogColor("WARNING", $str, $WARNING);
}

sub Fatal {
    my ($str) = @_;
    &_PrintLog("FATAL", $str, 2);
}

sub cFatal {
    my ($str) = @_;
    &_PrintLogColor("FATAL", $str, $FATAL);
}

sub _PrintLog {
    my ($level, $str, $type) = @_;
    my $date = &opt::Time::GetReadableTime();
    if (defined $type) {
        print STDERR "[$level] $date $str\n";
    } else {
        print STDOUT "[$level] $date $str\n";
    }
}

sub _PrintLogColor {
    my ($level, $str, $type) = @_;
    my $date = &opt::Time::GetReadableTime();
    my $color = "bold ";
    print STDOUT "[";
    if ($type eq $TRACE) {
        $color .= "cyan";
    } elsif ($type eq $NOTICE) {
        $color .= "green";
    } elsif ($type eq $WARNING) {
        $color .= "magenta";
    } elsif ($type eq $FATAL) {
        $color .= "red";
    } else {
        $color .= "white";
    }
    print color "$color";
    print STDOUT $level;
    print color "reset";
    print STDOUT "] $date $str\n";
}

1;
