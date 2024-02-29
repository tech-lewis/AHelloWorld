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
@implementation NativeModule

RCT_EXPORT_METHOD(RNOpenWebView:(NSString *)msg)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [delegate.navController pushViewController: gameController
//                                      animated:true];
    WebBrowserViewController *webController = [WebBrowserViewController new];
    [webController loadRequestWithUrlString:@"https://www.baidu.com/s?wd=当地时间"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:webController];
    [delegate.window.rootViewController presentViewController:navController animated:true completion:NULL];
  });
}

@end
