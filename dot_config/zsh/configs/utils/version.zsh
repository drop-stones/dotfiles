# Get the latest version file from given directory
# Usage: LATEST_FILE=$(get_latest_version_file <directory> <file> <delimeter>)
function get_latest_version_file {
  DIR=$1
  FILE=$2
  DELIMETER=$3

  LATEST_FILE=$(ls ${DIR} | grep ${FILE} | /bin/sort -t $3 | tail -1)
  echo "${LATEST_FILE}"
}
