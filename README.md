Plugin-x
========

This is fork of https://github.com/cocos2d-x/plugin-x twitter.

# USAGE

## iOS

1. Add proj.ios/PluginTwitter.xcodeproj to your xcode project.
2. Project Setting -> General -> Linked Framework and Libraries -> + -> libPluginTwitter.a

## Android


## example

```
#include "ProtocolShare.h"
#include "PluginManager.h"

PluginManager::getInstance()->unloadPlugin("ShareTwitter");
auto twitter =  dynamic_cast<plugin::ProtocolShare*>(plugin::PluginManager::getInstance()->loadPlugin("ShareTwitter"));
  
TShareDeveloperInfo twitterInfo;
twitterInfo["TwitterKey"] = YOUR_TWEET_KEY;
twitterInfo["TwitterSecret"] = YOUR_TWEET_SECRET;
#if defined(COCOS2D_DEBUG)
twitter->setDebugMode(true);
#endif
twitter->configDeveloperInfo(twitterInfo);
TShareInfo shareInfo;
shareInfo["SharedText"] = "TWEET MESSAGE";
shareInfo["SharedImagePath"] = SHARE_IMAGE_PATH;

twitter->setCallback([](int i, std::string& s){
    log("%i, %s", i, s.c_str());
});
twitter->share(shareInfo);
```
