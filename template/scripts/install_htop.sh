#!/bin/sh

#
#  Install: htop
#

# Configure debugging
set -eux
set -o pipefail
command -v bc || dnf install -y bc
command -v tput || dnf install -y ncurses
PS4='$(tput setaf 4)$(printf "%-12s\\t%.3fs\\t@line\\t%-10s" $(date +%T) $(echo $(date "+%s.%3N")-'$(date "+%s.%3N")' | bc ) $LINENO)$(tput sgr0)'

printf "Installing command: htop\n"

# htop is packaged in EPEL. Enable EPEL for whatever Enterprise Linux major
# version and architecture we are running on, rather than pinning an RPM URL.
EL_VERSION="$(rpm -E %rhel)"
rpm -q epel-release >/dev/null 2>&1 \
  || dnf install -y epel-release \
  || dnf install -y "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${EL_VERSION}.noarch.rpm"

dnf install -y htop

htop --version
