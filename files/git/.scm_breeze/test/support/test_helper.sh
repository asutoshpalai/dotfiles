orig_cwd="$PWD"

# Load SCM Breeze helpers
source "$scmbDir/lib/git/helpers.sh"

# Set up demo git user if not configured
if [ -z "$(git config user.email)" ]; then
  git config user.email "testuser@example.com"
  git config user.name  "Test User"
fi

#
# Test helpers
#-----------------------------------------------------------------------------

# Strip color codes from a string
strip_colors() {
  # Updated with info from: https://superuser.com/a/380778
  perl -pe 's/\x1b\[[0-9;]*[mG]//g'
}

# Print space separated tab completion options
tab_completions(){ echo "${COMPREPLY[@]}"; }

# Silence git commands
silentGitCommands() {
  git() { /usr/bin/env git "$@" > /dev/null 2>&1; }
}

# Cancel silent git commands
verboseGitCommands() {
  unset -f git
}


# Asserts
#-----------------------------------------------------------------------------

# Return 0 (shell's true) if "$1" contains string "$2"
_includes() {
  if [ -n "$3" ]; then regex="$3"; else regex=''; fi
  echo "$1" | grep -q"$regex" "$2"  # exit status of quiet grep is returned
}

# assert $1 contains $2
assertIncludes() {
  _includes "$@"
  local grep_exit=$?
  assertTrue "'$1' should have contained '$2'" '[[ $grep_exit == 0 ]]'
}

# assert $1 does not contain $2
assertNotIncludes() {
  _includes "$@"
  local grep_return=$?
  assertTrue "'$1' should not have contained '$2'" '[[ ! $grep_exit = 0 ]]'
}
