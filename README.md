# git-hook-sample
An example of commit git hooks.

## commit-msg
In order to restrict commit messages in a repository, add a file named `commit-msg` into the `./.git/hooks/` folder. 

For the UniTrac project, an example of something that could work is below. Two case insensitive regex checks are done here. `^UTPRDT-[0-9]+` and `^Merge`. Others could be added, as well. This could be a tool to remind you to add the ticket number.
```bash
#!/bin/sh

check=$(head -1 $1 | grep -e '^UTPRDT-[0-9]\+' -e '^Merge' -i)
if [ "" = "$check" ]; then
        echo "Commit message should have jira ticket id or be a merge." 1>&2
        echo "Required format:" 1>&2
        echo "    UTPRDT-[ticketid] <description>" 1>&2
        echo "    OR" 1>&2
        echo "    Merge<description>" 1>&2
        exit 1
fi
```

I this repository, run the `install-git-hook.ps1` script to install the hook.
