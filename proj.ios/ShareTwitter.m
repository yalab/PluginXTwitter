/****************************************************************************
 Copyright (c) 2013 cocos2d-x.org
 
 http://www.cocos2d-x.org
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

#import "ShareTwitter.h"
#import "ShareWrapper.h"
#import <Social/Social.h>
#import <Twitter/Twitter.h>

#define OUTPUT_LOG(...)     if (self.debug) NSLog(__VA_ARGS__);

@implementation ShareTwitter

@synthesize mShareInfo;
@synthesize debug = __debug;

- (void) configDeveloperInfo : (NSMutableDictionary*) cpInfo
{
}

- (void) share: (NSMutableDictionary*) shareInfo
{
    self.mShareInfo = shareInfo;
    if (nil == mShareInfo) {
        [ShareWrapper onShareResult:self withRet:kShareFail withMsg:@"Shared info error"];
        return;
    }

    NSString* strText = [mShareInfo objectForKey:@"SharedText"];
    NSString* strImagePath = [mShareInfo objectForKey:@"SharedImagePath"];

    UIViewController* controller = [self getCurrentRootViewController];

    SLComposeViewController *vc = [SLComposeViewController
                                    composeViewControllerForServiceType:SLServiceTypeTwitter];
    [vc setInitialText:strText];
    [vc addImage:[UIImage imageNamed:strImagePath]];
    vc.completionHandler =^(SLComposeViewControllerResult res){
        if (res == TWTweetComposeViewControllerResultDone){
            [ShareWrapper onShareResult:self withRet:kShareFail withMsg:@"Share Canceled"];
        } else if (res == TWTweetComposeViewControllerResultCancelled){
            [ShareWrapper onShareResult:self withRet:kShareSuccess withMsg:@"Share Succeed"];
        }
    };
    [controller presentViewController:vc animated:YES completion:nil];
}

- (void) setDebugMode: (BOOL) debug
{
    self.debug = debug;
}

- (NSString*) getSDKVersion
{
    return @"20130607";
}

- (NSString*) getPluginVersion
{
    return @"0.2.0";
}

- (UIViewController *)getCurrentRootViewController {

    UIViewController *result = nil;

    // Try to find the root view controller programmically

    // Find the top window (that is not an alert view or other window)
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }

    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];

    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        NSAssert(NO, @"Could not find a root view controller.");

    return result;
}

@end
