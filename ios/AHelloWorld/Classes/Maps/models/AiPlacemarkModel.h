//
//  AiPlacemarkModel.h
//  AImageDemo
//
//  Created by Mark on 2024/1/12.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN
@interface AiPlacemarkModel : NSObject
@property (nonatomic, copy, nullable) NSString *queryKeyword; 
@property (nonatomic, copy, nullable) NSString *name; // eg. Apple Inc.
@property (nonatomic, copy, nullable) NSString *thoroughfare; // street name, eg. Infinite Loop
@property (nonatomic, copy, nullable) NSString *subThoroughfare; // eg. 1
@property (nonatomic, copy, nullable) NSString *locality; // city, eg. Cupertino
@property (nonatomic, copy, nullable) NSString *subLocality; // neighborhood, common name, eg. Mission District
@property (nonatomic, copy, nullable) NSString *administrativeArea; // state, eg. CA
@property (nonatomic, copy, nullable) NSString *subAdministrativeArea; // county, eg. Santa Clara
@property (nonatomic, copy, nullable) NSString *postalCode; // zip code, eg. 95014
@property (nonatomic, copy, nullable) NSString *ISOcountryCode; // eg. US
@property (nonatomic, copy, nullable) NSString *country; // eg. United States
@property (nonatomic, copy, nullable) NSString *inlandWater; // eg. Lake Tahoe
@property (nonatomic, copy, nullable) NSString *ocean; // eg. Pacific Ocean
@property (nonatomic, copy, nullable) NSArray<NSString *> *areasOfInterest; // eg. Golden Gate Park
@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longitude;
@property (nonatomic, copy) NSString *speed; // m/s
@property (nonatomic, copy) NSString *timeString; // 当前日期
@property (nonatomic) MKDirectionsTransportType transportType; // Default is MKDirectionsTransportTypeAny
@end

NS_ASSUME_NONNULL_END
