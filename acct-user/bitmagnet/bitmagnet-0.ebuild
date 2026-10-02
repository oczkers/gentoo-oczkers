# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="System user: bitmagnet"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( bitmagnet )
ACCT_USER_HOME="/var/lib/bitmagnet"
ACCT_USER_HOME_OWNER="bitmagnet:bitmagnet"

acct-user_add_deps
