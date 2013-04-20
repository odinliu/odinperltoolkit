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
package opt::String;

use strict;
use Encode;

sub JsonEncode {
    my ($str, $code) = @_;
    unless (defined $code) {
        $code = "utf8";
    }
    $str = &Encode::decode($code, $str);
    $str =~ s/\\/\\\\/g;
    $str =~ s/[\r|\n|\t| ]+/ /g;
    $str =~ s/"/\\"/g;
    return &Encode::encode($code, $str);
}

sub JsonFilter {
    my ($str) = @_;
    $str =~ s/'|"|\(|\)|{|}|\[|\]|:|\\|,| //g;
    return $str;
}

sub SQLEncode {
    my ($str, $code) = @_;
    unless (defined $code) {
        $code = "utf8";
    }
    $str = &Encode::decode($code, $str);
    $str =~ s/\\/\\\\/g;
    $str =~ s/'/\\'/g;
    return &Encode::encode($code, $str);
}

sub Trim {
    my ($str) = @_;
    $str =~ s/(?:^\s*)|(?:\s*$)//g;
    return $str;
}

sub _BasicCutter {
    my ($str) = @_;
    my $left = "(:?\\(|\\[|\\{|（|【|『|《|〔)";
    my $right = "(:?\\)|\\]|\\}|）|】|』|》|〕)";
    my $ret = '';
    my @terms = split /[- _,]+/, $str;
    $ret .= shift @terms;
    while (@terms > 0) {
        my $term = shift @terms;
        if ($term =~ m/^[a-z]+$/i or $term =~ m/$left/ or $term =~ m/$right/) {
            $ret .= $term;
        }
    }
    return $ret;
}

sub _FiltVersion {
    my ($str) = @_;
    if ($str =~ m/v\d/i) {
        $str =~ s/v\d//ig;
    }
    if ($str =~ m/s[46]0/i) {
        $sname =~ s/s[46]0//gi;
    }
    if ($sname =~ m/[23]d/i) {
        $sname =~ s/[23]d//ig;
    }
    if ($sname =~ m/ext?/i) {
        $sname =~ s/ext?//ig;
    }
    return $sname;
}

sub _FiltDesc {
    my ($sname) = @_;
    my $left = "(:?\\(|\\[|\\{|（|【|『|《|〔)";
    my $right = "(:?\\)|\\]|\\}|）|】|』|》|〕)";
    if ($sname =~ m/$left.*$right/) {
        $sname =~ s/$left.*$right//g;
    }
    return $sname;
}

sub _KeepCharacter {
    my ($str) = @_;
    my $retstr = '';
    my $i = 0;
    while($i < length($str)) {
        my $ch = substr($str, $i, 1);
        if($ch =~ m/[a-zA-Z]/) {
            $retstr .= $ch;
        } elsif($ch =~ m/[\xB0-\xF7]/) {
            my $ch1 = substr($str, $i+1, 1);
            if($ch1 =~ m/[\xA1-\xFE]/) {
                $retstr = $retstr . $ch . $ch1;
            }
            $i++;
        } elsif($ch =~ m/[\x81-\xA0]/) {
            my $ch1 = substr($str, $i+1, 1);
            if($ch1 =~ m/[\x40-\xFE]/) {
                $retstr = $retstr . $ch . $ch1;
            }
            $i++;
        } elsif($ch =~ m/[\xAA-\xFE]/) {
            my $ch1 = substr($str, $i+1, 1);
            if($ch1 =~ m/[\x40-\xA0]/) {
                $retstr = $retstr . $ch . $ch1;
            }
            $i++;
        } elsif($ch =~ m/[\x81-\xFE]/) {
            $i++;
        }
        $i++;
    }
    return $retstr;
}

sub _BadWordFilter {
    my ($sname, $badword) = @_;
    if ($sname =~ m/$badword/i) {
        $sname =~ s/$badword//gi;
    }
    return $sname;
}

sub AppNameFilter {
    my ($appName, $badword) = @_;
    $sname = &_BasicCutter($sname);
    $sname = &_FiltVersion($sname);
    $sname = &_FiltDesc($sname);
    $sname = &_KeepCharacter($sname);
    if ($badword) {
        $sname = &_BadWordFilter($sname, $badword);
    }
    return $sname;
}

1;
