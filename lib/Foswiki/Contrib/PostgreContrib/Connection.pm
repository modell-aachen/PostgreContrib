# See bottom of file for default license and copyright information
package Foswiki::Contrib::PostgreContrib::Connection;

use strict;
use warnings;

sub new {
  my $class = shift;
  my $dbh = shift;

  my $this = {
    connected => 1,
    db => $dbh,
    finished => 0,
  };

  bless $this, $class;
  return $this;
}

sub finish {
  my $this = shift;
  return if $this->{finished};

  $this->{finished} = 1;
  $this->{db}->disconnect if $this->{connected};
  $this->{db} = undef;
  $this->{connected} = 0;
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
