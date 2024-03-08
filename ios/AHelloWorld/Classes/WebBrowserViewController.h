//
//  WebBrowserViewController.h
//  AHelloWorld
//
//  Created by Mark Lewis on 2024/3/1.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WKWebView, WKBackForwardListItem;
@interface WebBrowserViewController : UIViewController
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign, readonly) BOOL canGoBack;
@property (nonatomic, assign, readonly) BOOL canGoForward;
@property (nonatomic, strong) UIProgressView *progress;
// JS获取当前浏览器地址
- (NSString *)url;
- (void)goBack;
- (void)goForward;
- (void)loadRequestWithUrlString:(NSString *)url;
- (NSArray <WKBackForwardListItem *> *)forwardList;

@end

NS_ASSUME_NONNULL_END
