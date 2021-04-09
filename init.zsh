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
    # projen/projen # (segfault???)
    # pgollucci/projen
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
#  Environment:	 P6_DFZ_SRC_P6M7G8_DIR
#>
######################################################################
p6df::modules::projen::init() {

  alias pjp="$P6_DFZ_SRC_P6M7G8_DIR/pgollucci/projen/bin/projen"
}

######################################################################
#<
#
# Function: p6df::modules::projen::awesome::clones()
#
#>
######################################################################
p6df::modules::projen::awesome::clones() {

  local projects
  projects=$(p6_projen_awesome_projects_collect)

  p6_projen_util_foreach "$projects" "clone"
}

######################################################################
#<
#
# Function: p6df::modules::projen::awesome::versions()
#
#>
######################################################################
p6df::modules::projen::awesome::versions() {

  local projects
  projects=$(p6_projen_awesome_projects_collect)

  p6_projen_util_foreach "$projects" "p6_projen_util_version"
}

######################################################################
#<
#
# Function: p6df::modules::projen::awesome::deltas()
#
#>
######################################################################
p6df::modules::projen::awesome::deltas() {

  local projects
  projects=$(p6_projen_awesome_projects_collect)

  p6_projen_util_foreach "$projects" "p6_projen_util_diff"
}

######################################################################
#<
#
# Function: p6df::modules::projen::awesome::synthesize()
#
#>
######################################################################
p6df::modules::projen::awesome::synthesize() {

  local projects
  projects=$(p6_projen_awesome_projects_collect)

  p6_projen_util_foreach "$projects" "p6_projen_util_synthesize"
}

######################################################################
#<
#
# Function: p6df::modules::projen::awesome::build()
#
#>
######################################################################
p6df::modules::projen::awesome::build() {

  local projects
  projects=$(p6_projen_awesome_projects_collect)

  p6_projen_util_foreach "$projects" "p6_projen_util_build"
}

######################################################################
#<
#
# Function: p6df::modules::projen::awesome::upgrade()
#
#>
######################################################################
p6df::modules::projen::awesome::upgrade() {

  local projects
  projects=$(p6_projen_awesome_projects_collect)

  # p6_projen_util_foreach "$projects" "p6_projen_util_upgrade"
  # p6_projen_util_foreach "$projects" "p6_projen_util_submit"
  p6_projen_util_foreach "$projects" "p6_node_yarn_upgrade"
  p6_projen_util_foreach "$projects" "p6_node_yarn_submit"
}

######################################################################
#<
#
# Function: p6df::modules::projen::awesome::submit()
#
#>
######################################################################
p6df::modules::projen::awesome::submit() {

  local projects
  projects=$(p6_projen_awesome_projects_collect)

  p6_projen_util_foreach "$projects" "p6_projen_util_submit"
}
