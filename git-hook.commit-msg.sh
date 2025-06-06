#!/bin/sh
#
# An example hook script to check the commit log message.
# Called by "git commit" with one argument, the name of the file
# that has the commit message.  The hook should exit with non-zero
# status after issuing an appropriate message if it wants to stop the
# commit.  The hook is allowed to edit the commit message file.
#
# To enable this hook, rename this file to "commit-msg".

# Uncomment the below to add a Signed-off-by line to the message.
# Doing this in a hook is a bad idea in general, but the prepare-commit-msg
# hook is more suited to it.
#
# SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"

# This grabs the message and tests it against the grep regex (starts with "UTPRDT-" and followed by a number)
check=$(head -1 $1 | grep -e '^UTPRDT-[0-9]\+' -e '^Merge' -i)
if [ "" = "$check" ]; then
        echo "Commit message should have jira ticket id or be a merge." 1>&2
        echo "Required format:" 1>&2
        echo "    UTPRDT-[ticketid] <description>" 1>&2
        echo "    OR" 1>&2
        echo "    Merge<description>" 1>&2
        exit 1
fi