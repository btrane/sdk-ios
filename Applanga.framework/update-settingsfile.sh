################################################################################
#
# Copyright (c) 2017 Mbaas Development GmbH. All rights reserved.
#
################################################################################

APPLANGA_FRAMEWORK_DIR=$0

get_script_dir () {

     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          APPLANGA_FRAMEWORK_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     APPLANGA_FRAMEWORK_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
}

get_script_dir

APPLANGA_FRAMEWORK_BUNDLEID=$(defaults read $APPLANGA_FRAMEWORK_DIR/Info CFBundleShortVersionString)

APPLANGA_DOWNLOAD_SCRIPTPATH=/tmp/Applanga-Scripts/${APPLANGA_FRAMEWORK_BUNDLEID}/settingsfile_update.py
if [ ! -f "${APPLANGA_DOWNLOAD_SCRIPTPATH}" ]; then
     mkdir -p /tmp/Applanga-Scripts/${APPLANGA_FRAMEWORK_BUNDLEID}
     curl -o "${APPLANGA_DOWNLOAD_SCRIPTPATH}" "https://raw.githubusercontent.com/applanga/sdk-ios/${APPLANGA_FRAMEWORK_BUNDLEID}/settingsfile_update.py"
fi

python "${APPLANGA_DOWNLOAD_SCRIPTPATH}" "$1"