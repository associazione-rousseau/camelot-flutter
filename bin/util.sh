RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function echo_colored {
	MESSAGE=$1
	COLOR=$2
	echo "${COLOR}${MESSAGE}${NC}"
}
