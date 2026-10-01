# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="System user: victorialogs"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( victorialogs )
ACCT_USER_HOME="/var/lib/victorialogs"
ACCT_USER_HOME_OWNER="victorialogs:victorialogs"

acct-user_add_deps
