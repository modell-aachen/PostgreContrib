# ---+ Extensions
# ---++ PostgreContrib

# ---+++ Connection
# **BOOLEAN**
# Enable support for VirtualHostingContrib.
$Foswiki::cfg{Extensions}{PostgreContrib}{UseVHC} = 0;

# **STRING**
$Foswiki::cfg{Extensions}{PostgreContrib}{Hostname} = '';

# **NUMBER EXPERT**
$Foswiki::cfg{Extensions}{PostgreContrib}{Port} = '';

# **STRING**
$Foswiki::cfg{Extensions}{PostgreContrib}{Username} = '';

# **PASSWORD**
$Foswiki::cfg{Extensions}{PostgreContrib}{Password} = '';

# **STRING EXPERT**
$Foswiki::cfg{Extensions}{PostgreContrib}{Database} = 'foswiki_store';
