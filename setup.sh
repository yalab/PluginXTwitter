#!/bin/sh

URL_PREFIX="https://raw.githubusercontent.com/cocos2d-x/plugin-x/v4-develop"

curl ${URL_PREFIX}/protocols/platform/ios/InterfaceShare.h -o proj.ios/InterfaceShare.h
curl ${URL_PREFIX}/protocols/platform/ios/ShareWrapper.h -o proj.ios/ShareWrapper.h
curl ${URL_PREFIX}/tools/android/build_common.xml -o proj.android/build_common.xml

mkdir -p proj.android/protocols/
curl ${URL_PREFIX}/protocols/proj.android/AndroidManifest.xml -o proj.android/protocols/AndroidManifest.xml
curl ${URL_PREFIX}/protocols/proj.android/project.properties -o proj.android/protocols/project.properties
curl ${URL_PREFIX}/protocols/proj.android/build.xml -o proj.android/protocols/build.xml

mkdir -p proj.android/tools/android
curl ${URL_PREFIX}/tools/android/build_common.xml -o proj.android/tools/android/build_common.xml

mkdir -p proj.android/protocols/src/org/cocos2dx/plugin

for f in InterfaceShare.java ShareWrapper.java PluginWrapper.java PluginListener.java
do
    curl "${URL_PREFIX}/protocols/proj.android/src/org/cocos2dx/plugin/${f}" -o proj.android/protocols/src/org/cocos2dx/plugin/$f
done


mkdir -p proj.android/twitter4j
curl -O http://twitter4j.org/archive/twitter4j-4.0.4.zip
unzip -d proj.android/twitter4j twitter4j-4.0.4.zip
