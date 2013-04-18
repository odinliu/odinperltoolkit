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
package opt::DB;

use strict;
use DBI;

##########################################################################
# $confRef should be a hash reference, provide db connection info
# host, port, username, passwd, db, charset must be given
##########################################################################
sub InitMySQL {
    my ($confRef) = @_;
    unless (exists $confRef->{"host"} and exists $confRef->{"port"} and exists $confRef->{"db"} and
        exists $confRef->{"username"} and exists $confRef->{"password"} and 
        exists $confRef->{"charset"}) {
        return undef;
    }
    my $dbh = DBI->connect("dbi::mysql::$db:$host:$port;mysql_local_infile=1", $username,
        $password);
    unless ($dbh) {
        return undef;
    }

    my @configure_array = qw/character_set_client character_set_connection character_set_database character_set_results character_set_server/;
    foreach my $conf (@configure_array) {
        my $config = "set $conf=$charset";
        my $stmt = $dbh->prepare($config);
        $stmt->execute;
        $stmt->finish;
    }

    $dbh->{mysql_auto_reconnect} = 1;

    return $dbh;
}

1;
