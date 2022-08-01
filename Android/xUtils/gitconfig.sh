#!/bin/sh

# Copyright (C) 2012 Mikhail Malakhov <malakhv@live.ru>
#
# Confidential and Proprietary. All Rights Reserved.
# Unauthorized copying of this file, via any medium is strictly prohibited.

#---------------------------------------------------------------------------------------------------
# Script for configure local git repository (user name and email).
# Dependency: git
#
# Author: Mikhail.Malakhov
#---------------------------------------------------------------------------------------------------

USER="malakhv"
EMAIL="malakhv@gmail.com"

# Set user name and email
`git config --local user.name "${USER}"`
`git config --local user.email "${EMAIL}"`

# Show user name and email

echo `git config --local --get user.name`
echo `git config --local --get user.email`

#---------------------------------------------------------------------------------------------------