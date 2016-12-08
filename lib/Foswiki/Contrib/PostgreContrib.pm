# See bottom of file for default license and copyright information
package Foswiki::Contrib::PostgreContrib;

use strict;
use warnings;

our $VERSION = '1.0';
our $RELEASE = '1.0';
our $SHORTDESCRIPTION = 'PostgreSQL based store implementation for Foswiki';

use Foswiki::Contrib::PostgreContrib::ConnectionCache;
use Foswiki::Func;

our $cache = undef;

sub getConnection {
  my $db = shift;
  my $caller = caller(0) || 'common';

  unless ($cache) {
    $cache = new Foswiki::Contrib::PostgreContrib::ConnectionCache();
  }

  return $cache->getConnection($db, $caller);
}

sub finish {
  $cache->finish if $cache;
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
