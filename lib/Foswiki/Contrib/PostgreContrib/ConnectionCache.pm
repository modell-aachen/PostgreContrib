# See bottom of file for default license and copyright information
package Foswiki::Contrib::PostgreContrib::ConnectionCache;

use strict;
use warnings;

use DBI;
use utf8;
use Foswiki::Contrib::PostgreContrib::Connection;

sub new {
  my ($class, $opts) = @_;

  my $this = {
    connections => undef,
    finished => 0,
    pgopts => {
      AutoCommit => $opts->{AutoCommit} || 1,
      RaiseError => $opts->{RaiseError} || 1,
      PrintError => $opts->{PrintError} || 0
    }
  };

  bless $this, $class;
  return $this;
}

sub getConnection {
  my ($this, $db, $callerID) = @_;

  my $useVHC = $Foswiki::cfg{Extensions}{PostgreContrib}{UseVHC} || 0;
  my $schema = 'public';
  if ($useVHC) {
    $schema = "s_".$Foswiki::Contrib::VirtualHostingContrib::VirtualHost::CURRENT;
    $schema =~ s/([^A-Za-z0-9_])/ord $1/ge;
  }

  $db = $Foswiki::cfg{Extensions}{PostgreContrib}{Database} || 'foswiki_store' unless $db;
  my $c = $this->{connections}->{$schema}->{$db}->{$callerID};
  return $c if $c && $c->{connected} && !$c->{finished};

  my $dbh = $this->createDatebaseHandle($db);
  die "Unable to create Postgre connection to database $db: " . $dbh->errstr if $dbh->err;
  if($Foswiki::cfg{Extensions}{PostgreContrib}{EnableUTF8}){
      $dbh->{pg_enable_utf8} = 1;
  }

  # XXX
  # Possibly unsecure but the DBI driver won't let us bind to an identifier.
  if ($useVHC) {
    my $rows = $dbh->selectall_arrayref("SELECT * FROM information_schema.schemata WHERE schema_name=?", {Slice => {}}, $schema);
    $dbh->do("CREATE SCHEMA IF NOT EXISTS $schema") unless scalar(@$rows);
  }

  $dbh->do("SET search_path TO $schema");
  $c = Foswiki::Contrib::PostgreContrib::Connection->new($dbh);
  $this->{connections}->{$schema}->{$db}->{$callerID} = $c;

  return $c;
}

sub finish {
  my $this = shift;
  return if $this->{finished};

  foreach my $db (keys %{$this->{connections}}) {
    while (my ($callerID, $connection) = each %{$this->{connections}->{$db}}) {
      $connection->finish;
      delete $this->{connections}->{$callerID};
    }
  }

  $this->{connections} = undef;
  $this->{finished} = 1;
}

sub createDatebaseHandle {
  my ($this, $db) = @_;

  my $host = $Foswiki::cfg{Extensions}{PostgreContrib}{Hostname} || '';
  my $port = $Foswiki::cfg{Extensions}{PostgreContrib}{Port} || '';
  unless ($port) {
    $port = 5432 if $host;
  }

  my $addr = "dbi:Pg:dbname=$db";
  $addr .= ";host=$host" if $host;
  $addr .= ";port=$port" if $port;

  DBI->connect(
    $addr,
    $Foswiki::cfg{Extensions}{PostgreContrib}{Username} || '',
    $Foswiki::cfg{Extensions}{PostgreContrib}{Password} || '',
    $this->{pgopts}
  );
}

1;

__END__
Q.Wiki PostgreContrib - Modell Aachen GmbH

Author: %$AUTHOR%

Copyright (C) 2016 Modell Aachen GmbH

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version. For
more details read LICENSE in the root of this distribution.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

As per the GPL, removal of this notice is prohibited.
