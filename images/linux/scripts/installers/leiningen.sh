#!/bin/bash
################################################################################
##  File:  leiningen.sh
##  Team:  CI-Platform
##  Desc:  Installs Leiningen
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

set -e

LEIN_HOME=/usr/local/lib/lein
LEIN_BIN=/usr/local/bin/lein

echo "LEIN_HOME=$LEIN_HOME" | tee -a /etc/environment
curl -s https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > $LEIN_BIN
chmod 0755 $LEIN_BIN

# Run lein to trigger self-install
lein

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v lein; then
    echo "lein was not installed"
    exit 1
else
    lein new app testapp && rm -rf testapp
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Leiningen ($(lein -v))"
