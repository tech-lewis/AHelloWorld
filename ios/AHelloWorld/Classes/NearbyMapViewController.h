//
//  NearbyMapViewController.h
//  AHelloWorld
//
//  Created by Mark Lewis on 2024/3/3.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN
@class AiPlacemarkModel;

@interface NearbyMapViewController : UIViewController
// 开始地点和结束地点
@property (nonatomic, strong) AiPlacemarkModel *startPoint;
@property (nonatomic, strong) AiPlacemarkModel *endPoint;
@property (nonatomic, assign) BOOL isFavoritePlace;
@property (nonatomic) MKDirectionsTransportType selectTransportType;

@end

NS_ASSUME_NONNULL_END
