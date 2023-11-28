#!/bin/sh

# uncomment if you're using a bound package.json to install packages
# rm -f composer.lock
# composer install --no-interaction

# install packages from a text file
sh ./install/packages.sh install/packages.txt

apache2-foreground