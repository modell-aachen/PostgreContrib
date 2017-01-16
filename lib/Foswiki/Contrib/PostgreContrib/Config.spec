# ---+ Extensions
# **ENHANCE {Store}{Implementation}**
# <dl><dt>Postgre</dt>
# <dd><strong>Not implemented yet!</strong></dd>
# </dl>

# ---+ Extensions
# ---++ PostgreContrib

# ---+++ Connection

# **STRING EXPERT**
# Configure host for remote DB; usually you will want to leave this empty for local connections.
$Foswiki::cfg{Extensions}{PostgreContrib}{Hostname} = '';

# **STRING EXPERT**
# Port where the DB resides; leave empty for local connections (no Hostname configured).
$Foswiki::cfg{Extensions}{PostgreContrib}{Port} = '';

# **STRING EXPERT**
# Username for authentication; leave empty for local connections (no Hostname configures).
$Foswiki::cfg{Extensions}{PostgreContrib}{Username} = '';

# **PASSWORD EXPERT**
# Password for authentication; leave empty for local connections (no Hostname configures).
$Foswiki::cfg{Extensions}{PostgreContrib}{Password} = '';

# **STRING**
$Foswiki::cfg{Extensions}{PostgreContrib}{Database} = 'foswiki_store';
