//
//  NativeModule.m
//  AHelloWorld
//
//  Created by Mark Lewis on 2024/3/1.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "NativeModule.h"
#import "RCTBridgeModule.h"
#import "AppDelegate.h"
#import "WebBrowserViewController.h"
#import "DiscoverDetailViewController.h"
//#import "RCTBridgeModule.h"
@interface NativeModule()<RCTBridgeModule>
@end
@implementation NativeModule
// 这句代码是必须的 用来导出 module, 这样才能在 RN 中访问 nativeModule这个 module
RCT_EXPORT_MODULE(NativeModule);
RCT_EXPORT_METHOD(RNOpenWebView:(NSString *)msg)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [delegate.navController pushViewController: gameController
//                                      animated:true];
    WebBrowserViewController *webController = [WebBrowserViewController new];
    if (msg.length && [msg hasPrefix:@"http"]) {
      [webController loadRequestWithUrlString:msg];
    } else {
      [webController loadRequestWithUrlString:@"https://so.toutiao.com/"];
    }
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:webController];
    [delegate.window.rootViewController presentViewController:navController animated:true completion:NULL];
  });
}

@end
