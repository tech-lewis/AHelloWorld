//
//  MLTemplateModel.h
//  AImageDemo
//
//  Created by Mark Lewis on 2024/2/3.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreML/MLModel.h>
NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(11.0))
@interface MLTemplateModel : NSObject
@property (readonly, nonatomic, nullable) MLModel * model;
@end

NS_ASSUME_NONNULL_END
