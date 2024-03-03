//
//  AlertViewRecorder.h
//  AImageDemo
//
//  Created by Mark on 2023/7/25.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface AlertViewRecorder : NSObject
@property (nonatomic, strong)NSMutableArray * alertViewArray;
+ (instancetype)shareAlertViewRecorder;
@end

NS_ASSUME_NONNULL_END
