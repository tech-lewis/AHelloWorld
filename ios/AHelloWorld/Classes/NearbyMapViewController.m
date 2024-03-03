//
//  NearbyMapViewController.m
//  AHelloWorld
//
//  Created by Mark Lewis on 2024/3/3.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "NearbyMapViewController.h"
#import "MacroUtils.h"
#import "AiPlacemarkModel.h"
#import "UIColor+Extension.h"
#import "ProgressHUD.h"
#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "DiscoverMapRouteListViewController.h"
@interface NearbyMapViewController () <MKMapViewDelegate, AVSpeechSynthesizerDelegate>
@property (nonatomic, assign) int speechIndex;
@property (nonatomic, weak) MKMapView *myMap;
@property (nonatomic, copy) NSArray *routeSteps;
@property (nonatomic, copy) NSArray *currentRouteList;
@property (nonatomic, strong) AVSpeechSynthesizer *speecher;
@property (nonatomic, assign) BOOL isAssignedValue;
@end

@implementation NearbyMapViewController
- (void)dismiss
{
  [self dismissViewControllerAnimated:true completion:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  self.speecher = nil;
  [ProgressHUD dismiss];
}
- (void)viewDidLoad
{
  self.title = @"当前位置";
  self.navigationItem.leftBarButtonItem
  /*
   步骤：

   导入MapKit框架。
   创建一个MKMapView并将其添加到视图。
   定义起点和终点的CLLocationCoordinate2D坐标。
   使用MKDirectionsRequest来发起路线规划请求。
   使用MKDirections来计算路线。
   将计算结果中的MKRoute添加到地图上。
   计算并展示距离。
   */
  [super viewDidLoad];
  [self setupUI];
  [self textToAudioWithContent:@"正在为您导航"];
}

- (void)setupUI
{
  self.title = @"地图详情";
  [self setupMapViewWithStartLocation:NULL endLocation:NULL];
}

- (void)setupMapViewWithStartLocation:(AiPlacemarkModel *)start endLocation:(AiPlacemarkModel *)end
{
  // 创建MapView
  MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
  self.myMap = mapView;
  self.myMap.delegate = self;
  self.myMap.showsUserLocation = true;
  [self.view addSubview:mapView];

  // 2. 定义深圳北站和深圳宝安国际机场的坐标
  CLLocationCoordinate2D shenzhenNorthStationCoordinate = CLLocationCoordinate2DMake(0, 0);
  CLLocationCoordinate2D shenzhenAirportCoordinate = CLLocationCoordinate2DMake(0, 0);;
  
  MKPointAnnotation *startAnnotation = [[MKPointAnnotation alloc] init];
  MKPointAnnotation *endAnnotation = [[MKPointAnnotation alloc] init];
  if (self.startPoint != nil && self.endPoint != nil) {
    shenzhenNorthStationCoordinate = CLLocationCoordinate2DMake(start.latitude, start.longitude);
    startAnnotation.coordinate = CLLocationCoordinate2DMake(start.latitude, start.longitude);
    startAnnotation.title = start.name? start.name: @"起点"; // 标注的标题
    startAnnotation.subtitle = startAnnotation.subtitle? startAnnotation.subtitle: @"这里是起点"; // 标注的副标题
    
    shenzhenAirportCoordinate = CLLocationCoordinate2DMake(end.latitude, end.longitude);
    endAnnotation.coordinate = CLLocationCoordinate2DMake(end.latitude, end.longitude);
    endAnnotation.title = end.name? end.name: @"终点"; // 标注的标题
    endAnnotation.subtitle = startAnnotation.subtitle? startAnnotation.subtitle: @"这里是终点"; // 标注的副标题
    [self.myMap addAnnotations:@[startAnnotation, endAnnotation]];

  }
  else {
    self.myMap.showsUserLocation = true;
  }
  self.myMap.showsUserLocation = true;
  // 3. 创建起点和终点的 MKPlacemark 对象
  MKPlacemark *startPlacemark = [[MKPlacemark alloc] initWithCoordinate:shenzhenNorthStationCoordinate addressDictionary:NULL];
  MKPlacemark *endPlacemark = [[MKPlacemark alloc] initWithCoordinate:shenzhenAirportCoordinate addressDictionary:nil];

  MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startPlacemark];
  MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endPlacemark];

  // 4. 创建路线请求对象
  MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
  directionsRequest.source = startItem;
  directionsRequest.destination = endItem;
  directionsRequest.transportType = self.selectTransportType; // 选择汽车作为交通工具

  // 5. 计算路线
  MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
  [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
      if (error) {
          // 处理错误
          NSLog(@"Error calculating directions: %@", error);
      } else {
        // 获取路线并显示到地图上
        MKRoute *route = [response.routes firstObject];
        self.currentRouteList = route.steps;
        if (!_isAssignedValue) self.routeSteps = self.currentRouteList;
        self.isAssignedValue = true;
        
        [self.myMap addOverlay:route.polyline level:MKOverlayLevelAboveRoads];

        // 6. 设置可见区域
        [self.myMap setVisibleMapRect:route.polyline.boundingMapRect edgePadding:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0) animated:YES];

        // 7. 输出距离
        NSLog(@"Distance: %f meters", route.distance);
        float minutes = route.expectedTravelTime/60/60;
        // minutes = minutes/60/60;
        endAnnotation.subtitle = [NSString stringWithFormat:@"全程共%.2f 千米 | 驾车行驶时间:%.2f小时", route.distance/1000, minutes];
        NSInteger stepIndex = 0;
        // 遍历每条路线的步骤
        for (MKRouteStep *step in route.steps) {
          // 将路线步骤的多边形添加到 mapView
          MKPolyline *polyline = step.polyline;
          // 为每个 polyline 设置一个标识
          polyline.title = [NSString stringWithFormat:@"Step-%ld", (long)stepIndex];
          [self.myMap addOverlay:polyline];
          // 创建并添加标注
          MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
          // 使用多边形的中心点作为标注的坐标
          MKMapPoint middlePoint = polyline.points[polyline.pointCount / 2];
          annotation.coordinate = MKCoordinateForMapPoint(middlePoint);
          // 将距离设置为标注的副标题
          annotation.title = [NSString stringWithFormat:@"Step %ld %@", (long)stepIndex, step.instructions];
          annotation.subtitle = [NSString stringWithFormat:@"Distance: %.0f meters | %@", step.distance, step.notice];
          [self.myMap addAnnotation:annotation];
    
          stepIndex++;
        }
      }
  }];
  // 设置 mapView 的 delegate 并实现上面的 delegate 方法
  self.myMap.delegate = self;
}

// 实现 MKMapViewDelegate 的方法来渲染路线
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:(MKPolyline *)overlay];
        renderer.strokeColor = [UIColor randomColor];
        renderer.lineWidth = 4.0;
        return renderer;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
  if (self.currentRouteList == nil) return;
  if (is_ios8) {
    // 9.0之前的老系统不执行操作
    return;
  }
  // 开始和终点route都一样
//  DiscoverMapRouteListViewController *routeListController = [[DiscoverMapRouteListViewController alloc] init];
//  routeListController.routeSteps = self.currentRouteList;
//  [self.navigationController pushViewController:routeListController animated:true];
  
}
// 实现MKMapViewDelegate协议中的方法，以提供自定义标注视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        static NSString *PinIdentifier = @"PinAnnotation";
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:PinIdentifier];
        if (!pinView) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PinIdentifier];
            pinView.canShowCallout = YES;
            pinView.animatesDrop = YES;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//  if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
//      static NSString *identifier = @"StartAnnotation";
//      MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//      if (!annotationView) {
//          annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//          annotationView.canShowCallout = YES; // 允许显示弹出信息窗
//          annotationView.animatesDrop = YES; // 标注出现时的动画
//          // 设置标注视图的颜色（仅iOS 9+支持，对于iOS 6，这一行代码不适用）
//          // annotationView.pinTintColor = [UIColor redColor];
//      } else {
//          annotationView.annotation = annotation;
//      }
//      return annotationView;
//  }
//  return nil;
//}


/** 文本转语音*/
- (void)textToAudioWithContent:(NSString *)text {
  
  // 语音播报
  AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.speecher speakUtterance:utterance];
  });
}


- (AVSpeechSynthesizer *)speecher
{
  if (_speecher == nil) {
    _speecher = [[AVSpeechSynthesizer alloc]init];
    _speecher.delegate = self;
  }
  return _speecher;
}

#pragma mark - AVSpeechSynthesizerDelegate
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
  [ProgressHUD dismiss];
  // 朗读完毕 继续下一条
  if (_speechIndex < self.routeSteps.count) {
    MKRouteStep *mapStepItem = self.routeSteps[self.speechIndex];
    [self textToAudioWithContent:mapStepItem.instructions];
    [ProgressHUD show:[NSString stringWithFormat:@"朗读第%d条导航信息", self.speechIndex++]];
  } else {
    self.speechIndex = 0;
  }
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
  [self speechRoutes];
}
- (void)speechRoutes
{
  if (self.routeSteps.firstObject != nil) {
    MKRouteStep *mapStepItem = self.routeSteps[self.speechIndex];
    [self textToAudioWithContent:mapStepItem.instructions];
    self.speechIndex = 1;
  }
}
#pragma mark - 懒加载更新线路
- (void)setEndPoint:(AiPlacemarkModel *)endPoint
{
  _endPoint = endPoint;
  [self setupMapViewWithStartLocation:_startPoint endLocation:_endPoint];
}

@end
