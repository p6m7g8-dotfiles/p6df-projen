######################################################################
#<
#
# Function: p6df::modules::projen::deps()
#
#>
######################################################################
p6df::modules::projen::deps() {
  ModuleDeps=(
    p6m7g8/p6projen
    p6m7g8/p6df-node
    ohmyzsh/ohmyzsh:plugins/projen
  )
}

######################################################################
#<
#
# Function: p6df::modules::projen::langs()
#
#>
######################################################################
p6df::modules::projen::langs() {

  npm uninstall -g projen
  npm install -g projen
}

######################################################################
#<
#
# Function: p6df::modules::projen::init()
#
#>
######################################################################
p6df::modules::projen::init() {

  p6df::modules::projen::aliases::init
}

######################################################################
#<
#
# Function: p6df::modules::projen::aliases::init()
#
#  Depends:	 p6_h1
#  Environment:	 P6_DFZ_SRC_P6M7G8_DIR
#>
######################################################################
p6df::modules::projen::aliases::init() {

  alias pjp="$P6_DFZ_SRC_P6M7G8_DIR/pgollucci/projen/bin/projen"
}

######################################################################
#<
#
# Function: p6df::modules::projen::find(orgs_or_users, repository, owner, name, count)
#
#  Args:
#	orgs_or_users -
#	repository -
#	owner -
#	name -
#	count -
#
#  Depends:	 p6_h1 p6_run
#  Environment:	 API HEAD
#>
######################################################################
p6df::modules::projen::find() {
  local orgs_or_users="$1"

  for org_or_user in $(echo "$orgs_or_users"); do
    p6_h1 "$org_or_user"

    local repositories
    local i=1
    while [ 1 ]; do
      repositories=$(gh repo list "$org_or_user" --source --limit 1000 2>&1 | awk '{print $1}' | sort)
      if [ x"API" = x"$repositories" ]; then
        while [ 1 ]; do
          sleep $(echo $(gh api /rate_limit -q ".resources.graphql.reset")-$(perl -e 'print time()') | bc -lq)
        done
      else
        break
      fi
    done
    p6_run_parallel "0" "8" "$repositories" find_projen_repositories
  done 2>&1 | grep ": 1" | sed -e 's,:.*,,'
}

find_projen_repositories() {
  local repository="$1"

  local owner=$(echo "$repository" | cut -d / -f 1)
  local name=$(echo "$repository" | cut -d / -f 2)

  local count=$(gh api graphql -F owner=$owner -F name=$name -q ".data.repository.object.entries[].name" -f query='
  query($name: String!, $owner: String!) {
    repository(owner: $owner, name: $name) {
    object(expression: "HEAD:") {
      ... on Tree {
        entries {
          name
        }
      }
    }
  }
}' | grep -c projenrc)

  echo >&2 "$owner/$name: $count"

  p6_return_void
}
