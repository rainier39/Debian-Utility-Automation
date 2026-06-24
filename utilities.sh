#!/bin/bash

# The script needs to run as root, so stop if we aren't.
if [[ "$EUID" -ne 0 ]]; then
  echo "Error: script must be run with root privileges."
  exit 1
fi

# Function to make sure the user has explicitly chosen y or n, otherwise stop.
function validateChoice {
  if [[ ($1 != "y") && ($1 != "n") ]]; then
    echo "Error: invalid choice."
    exit 1
  fi
}

# Display banner.
echo "##########################################################"
echo "#                                                        #"
echo "#               Debian Utility Automation                #"
echo "# https://github.com/rainier39/Debian-Utility-Automation #"
echo "#                                                        #"
echo "##########################################################"

# Whether or not to install all of the packages without prompting for each one.
echo -n "Yes to all? (highly recommended to at least look through script beforehand) [y/n]: "
read -r all

validateChoice "$all"

# -- Install network enumeration utilities. --
# netdiscover is a tool that uses ARP requests to scan a network for devices.
# dnsutils contains nslookup, a very handy tool.
# nmap is a good tool for scanning a host for services.
if [[ $all != "y" ]]; then
  echo -n "Install network enumeration utilities? [y/n]: "
  read -r netenum
  validateChoice "$netenum"
fi

if [[ ($all == "y") || ($netenum == "y") ]]; then
  sudo apt install -y netdiscover dnsutils nmap
fi

# -- Install hex editor. --
if [[ $all != "y" ]]; then
  echo -n "Install a hex editor? [y/n]: "
  read -r hex
  validateChoice "$hex"
fi

if [[ ($all == "y") || ($hex == "y") ]]; then
  sudo apt install -y ghex
fi

echo "Done installing utilities!"
