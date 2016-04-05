//
//  LocationService.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/5.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "LocationService.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationService()<CLLocationManagerDelegate>

@end

@implementation LocationService
{
    CLLocationManager * _manage;
    CGPoint _start;
}

static LocationService *_shareInstance=nil;

+(LocationService *) sharedInstance
{
    if(!_shareInstance) {
        _shareInstance=[[LocationService alloc] init];
    }
    
    return _shareInstance;
}

-(id)init
{
    self = [super init];
    if (self) {
        
        if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            debugLog(@"没打开");
        }else{
            debugLog(@"打开");
        }
        
        _manage = [[CLLocationManager alloc] init];
        _manage.delegate = self;
        //后台用
//        [_manage requestAlwaysAuthorization];//ios8
        [_manage requestWhenInUseAuthorization];
//        [_manage setDesiredAccuracy:10];
        //精度不用太高
        [_manage setDistanceFilter:kCLLocationAccuracyBest];
        _manage.pausesLocationUpdatesAutomatically = NO;//ios6
        //同样是后台用
//        if ([DeviceManager getDeviceSystem] > 9) {
//            _manage.allowsBackgroundLocationUpdates = YES; //ios9
//        }
        [_manage startUpdatingLocation];
        
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * location       = locations[0];
    CLLocationCoordinate2D lc2d = location.coordinate;
    CLLocationDegrees lat       = lc2d.latitude;
    CLLocationDegrees lng       = lc2d.longitude;
    _start                      = CGPointMake(lng, lat);
}

- (NSString *)calculateDistanceFrom:(CGPoint)start to:(CGPoint)end
{
    
    CGFloat radLat1 = [self Rad:start.y];
    CGFloat radLat2 = [self Rad:end.y];
    CGFloat a       = radLat1-radLat2;
    CGFloat b       = [self Rad:start.x - end.x];
    CGFloat s       = 2 * asin(sqrt(pow(sin(a/2), 2) + cos(radLat1)*cos(radLat2)*pow(sin(b/2), 2)));
    s               = s * 6378.137;
    s               = round(s*10000)/10000;
    
    return [NSString stringWithFormat:@"%.2f", s];
}

- (CGFloat)Rad:(CGFloat)d
{
    return d * M_PI/180.0;
}

- (NSString *)getDistanceWith:(CGPoint)end
{
    if ([self existLocation:_start]) {
        return nil;
    }
    
    return [self calculateDistanceFrom:_start to:end];
}

- (BOOL)existLocation:(CGPoint)point
{
    if (_start.x == 0 && _start.y == 0) {
        return NO;
    }
    return YES;
}

@end
