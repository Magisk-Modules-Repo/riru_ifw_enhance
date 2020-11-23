#!/sbin/sh
RIRU_PATH="/data/adb/riru"
RIRU_MODULE_ID="ifw_enhance"
RIRU_MODULE_PATH="$RIRU_PATH/modules/$RIRU_MODULE_ID"
RIRU_MIN_API_VERSION="9"
RIRU_MIN_VERSION_NAME="v22.0"
RIRU_MIN_SDK_VERSION="26"

check_riru_version() {
  if [ ! -f "$RIRU_PATH/api_version" ] && [ ! -f "$RIRU_PATH/api_version.new" ]; then
    ui_print "*********************************************************"
    ui_print "! Riru is not installed"
    ui_print "! Please install Riru from Magisk Manager or https://github.com/RikkaApps/Riru/releases"
    abort    "*********************************************************"
  fi
  RIRU_API_VERSION=$(cat "$RIRU_PATH/api_version.new") || RIRU_API_VERSION=$(cat "$RIRU_PATH/api_version") || RIRU_API_VERSION=0
  [ "$RIRU_API_VERSION" -eq "$RIRU_API_VERSION" ] || RIRU_API_VERSION=0
  ui_print "- Riru API version: $RIRU_API_VERSION"
  if [ "$RIRU_API_VERSION" -lt $RIRU_MIN_API_VERSION ]; then
    ui_print "*********************************************************"
    ui_print "! Riru $RIRU_MIN_VERSION_NAME or above is required"
    ui_print "! Please upgrade Riru from Magisk Manager or https://github.com/RikkaApps/Riru/releases"
    abort    "*********************************************************"
  fi
}

check_architecture() {
  if [ "$ARCH" != "arm" ] && [ "$ARCH" != "arm64" ] && [ "$ARCH" != "x86" ] && [ "$ARCH" != "x64" ]; then
    abort "! Unsupported platform: $ARCH"
  else
    ui_print "- Device platform: $ARCH"
  fi
}

check_sdk_version() {
  if [ "$API" -lt "$RIRU_MIN_SDK_VERSION" ];then
    abort "! Unsupported SDK version: $API < $RIRU_MIN_SDK_VERSION"
  else
    ui_print "- Android API level: $API"
  fi
}
