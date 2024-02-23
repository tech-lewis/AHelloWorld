/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import "RCTRootView.h"

@implementation AppDelegate
- (NSString *)sandboxFilePath {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];//Documents目录
  return documentsDirectory;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSURL *jsCodeLocation;
  jsCodeLocation = [NSURL URLWithString:@"http://192.168.0.101:8081/index.ios.bundle"];
  
  // OPTION 2
  // Load from pre-bundled file on disk. To re-generate the static bundle, run
  //
  // $ curl http://localhost:8081/Examples/SampleApp/index.ios.bundle -o main.jsbundle
  //
  // and uncomment the next following line
//   jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  NSString *path = [[self sandboxFilePath] stringByAppendingPathComponent:@"main.bundle"];
  jsCodeLocation = [NSURL URLWithString:path];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"AHelloWorld"
                                                   launchOptions:launchOptions];
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [[UIViewController alloc] init];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
