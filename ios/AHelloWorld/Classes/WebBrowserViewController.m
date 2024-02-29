//
//  WebBrowserViewController.m
//  AHelloWorld
//
//  Created by Mark Lewis on 2024/3/1.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "WebBrowserViewController.h"
#import <WebKit/WebKit.h>
@interface WebBrowserViewController ()

@end

@implementation WebBrowserViewController

- (void)dismiss
{
  [self dismissViewControllerAnimated:true completion:NULL];
}

#pragma mark - Lifecycle
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
  self.title = @"Web Browser";
  self.edgesForExtendedLayout = false;
//  if ([[UIDevice currentDevice].systemVersion doubleValue] >= 11) self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  self.webView.frame = self.view.bounds;
  [self.view addSubview:self.webView];

}
// 防止WebView崩溃的方法
- (void)webViewAddMethods{
//预防报错:WebActionDisablingCALayerDelegate    willBeRemoved//  Class class = NSClassFromString(@"WebActionDisablingCALayerDelegate");//  class_addMethod(class, NSSelectorFromString(@"setBeingRemoved"), setBeingRemoved, "v@:");//  class_addMethod(class, NSSelectorFromString(@"willBeRemoved"), willBeRemoved, "v@:");//  class_addMethod(class, NSSelectorFromString(@"removeFromSuperview"), willBeRemoved, "v@:");
}


- (NSString *)url
{
  return self.webView.URL.absoluteString;
  // return [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)sender {}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    // 判断是否在边缘滑动
//    CGFloat edgeOffset = 50;
//    CGFloat contentOffset = scrollView.contentOffset.y;
//    CGFloat contentHeight = scrollView.contentSize.height;
//    CGFloat scrollViewHeight = scrollView.bounds.size.height;
//    if (contentOffset < edgeOffset && contentHeight > scrollViewHeight) {
//        // 在顶部边缘滑动
//        CGFloat factor = (edgeOffset - contentOffset) / edgeOffset;
//        CGFloat offset = -scrollViewHeight * factor;
//        [scrollView setContentOffset:CGPointMake(0, offset) animated:NO];
//    } else if (contentOffset + scrollViewHeight > contentHeight - edgeOffset && contentHeight > scrollViewHeight) {
//        // 在底部边缘滑动
//        CGFloat factor = (contentOffset + scrollViewHeight - contentHeight + edgeOffset) / edgeOffset;
//        CGFloat offset = scrollViewHeight * factor;
//        [scrollView setContentOffset:CGPointMake(0, contentHeight - scrollViewHeight + offset) animated:NO];
//    }
//}

- (WKWebView *)webView
{
  if (_webView == nil) {
    _webView = [[WKWebView alloc] init];
    [_webView setAllowsBackForwardNavigationGestures:true];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
  }
  return _webView;
}

- (void)loadRequest:(NSURLRequest *)urlRequest
{
  [self.webView loadRequest:urlRequest];
}

- (void)loadRequestWithURL:(NSURL *)url
{
  [self loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)loadRequestWithUrlString:(NSString *)url
{
  [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
- (void)goBack
{
  [self.webView goBack];
}

- (void)goForward
{
  [self.webView goForward];
}

- (BOOL)canGoBack
{
  return [self.webView canGoBack];
}

- (BOOL)canGoForward
{
  return [self.webView canGoForward];
}
#pragma mark 加载进度条
- (UIProgressView *)progress
{
  if (_progress == nil)
  {
    _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2)];
    _progress.tintColor = [UIColor colorWithRed:255/255.0 green:136/255.0 blue:0.0 alpha:1];//[UIColor blueColor];
    _progress.backgroundColor = [UIColor lightGrayColor];
    [_webView addSubview:_progress];
  }
  return _progress;
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if (object == _webView)
        {
            [self.progress setAlpha:1.0f];
            [self.progress setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.5f
                                      delay:0.3f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.progress setAlpha:0.0f];
                                 }
                                 completion:^(BOOL finished) {
                                     [self.progress setProgress:0.0f animated:NO];
                                 }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    //网页title
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == _webView)
        {
          self.title = _webView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark 移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (NSArray <WKBackForwardListItem *> *)backList
{
  return self.webView.backForwardList.backList;
}

- (NSArray <WKBackForwardListItem *> *)forwardList
{
  return self.webView.backForwardList.forwardList;
}

- (void)goToBackForwardListItem:(WKBackForwardListItem *)item
{
  [self.webView goToBackForwardListItem:item];
}
@end
