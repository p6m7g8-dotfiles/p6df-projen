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
#  Environment:	 P6_DFZ_SRC_P6M7G8_DIR
#>
######################################################################
p6df::modules::projen::aliases::init() {

  alias pjp="$P6_DFZ_SRC_P6M7G8_DIR/pgollucci/projen/bin/projen"
}
