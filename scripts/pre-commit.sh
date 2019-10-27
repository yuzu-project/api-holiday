#!/bin/sh
COLOR_NONE="\033[0m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[1;33m"
COLOR_GREEN="\033[1;32m"

# Check which commit we are checking for changes against
if git rev-parse --verify HEAD >/dev/null 2>&1
then
  # OK, HEAD shorthand points to a valid commit, so we are 
  # working on a non-empty working tree 
	commitedHead=HEAD
else
	# It' s an empty tree -- use git magic internal hash
	commitedHead=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Avoid making cppcheck analyse the whole source tree, this might be
# too much time consuming in large projects. Let's check only what
# has been changed on added
changedSourceFiles=$(git diff-index --cached ${commitedHead} | \
	grep -E '[MA]	.*\.(c|cpp|cc|cxx)$' | cut -f 2)

if [ -n "${changedSourceFiles}" ]; then
  echo "${COLOR_YELLOW}Start static analysis in changed source files...${COLOR_NONE}"
	cppcheck --error-exitcode=1 ${changedSourceFiles}
  exitStatus=$?
  if [ "${exitStatus}" = "0" ]; then
    echo "${COLOR_GREEN}Ok, all green! :)${COLOR_NONE}"
  else
    echo "${COLOR_RED}Pre-commit failed: please check for errors in your source code as pointed above.${COLOR_NONE}"
  fi
	exit ${exitStatus}
fi

exit 0
