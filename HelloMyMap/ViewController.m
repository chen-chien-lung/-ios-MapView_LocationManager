//
//  ViewController.m
//  HelloMyMap
//
//  Created by Joe Chen on 2016/5/18.
//  Copyright © 2016年 Joe Chen. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"

@interface ViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet MKMapView *mainMapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [CLLocationManager new]; // =[[CLLocationManager alloc]init];
    //判斷ios版本有無支援使用者位置授權,ios8以後才支援
    //respondsToSelector 檢查locationManager 有無支援,這方法常用
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    
    //prepare locationManager
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeAutomotiveNavigation; //什麼類型的運用（運動 汽車...)
    locationManager.delegate =self; //locationManager回報時回報到self
    [locationManager startUpdatingLocation]; //開始回報位置
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mspTypeChange:(UISegmentedControl*)sender {
    
    NSInteger targetIndex = sender.selectedSegmentIndex;
    
    switch (targetIndex) {
        case 0:
            _mainMapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            _mainMapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            _mainMapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
    
}
- (IBAction)trackingModeChange:(id)sender {
    
    NSInteger targetIndex = [sender selectedSegmentIndex];
    
    switch (targetIndex) {
        case 0:
            _mainMapView.userTrackingMode = MKUserTrackingModeNone;
            break;
        case 1:
            _mainMapView.userTrackingMode = MKUserTrackingModeFollow;
            break;
        case 2:
            _mainMapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
            break;
            
        default:
            break;
    }

    
}

#pragma mark - CLLcationManagerDelegate Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currentLocation = locations.lastObject;
    NSLog(@"Current Location:%.6f,%.6f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    
    //make the region change just once
    
    static dispatch_once_t changeRegionOnceToken;
    
    //下面{}裡面的程式碼只會執行一次 不管整個方法跑幾次
    dispatch_once(&changeRegionOnceToken, ^{
        
        MKCoordinateRegion region = _mainMapView.region; //region代表地圖的中心和縮放大小
        region.center = currentLocation.coordinate;
        region.span.latitudeDelta = 0.01; //地圖上看最上緣跟最下緣相差0.01緯度
        region.span.longitudeDelta = 0.01;//...
        [_mainMapView setRegion:region animated:true];
        
        //Add a annotation
        CLLocationCoordinate2D annotationCoordinate =currentLocation.coordinate;
        annotationCoordinate.latitude += 0.0005;
        annotationCoordinate.longitude += 0.0005;
        
        MKPointAnnotation * annotation = [MKPointAnnotation new];
        annotation.coordinate = annotationCoordinate;
        annotation.title = @"肯德基";
        annotation.subtitle = @"真好吃";
        
        [_mainMapView addAnnotation:annotation];
        
    });
}

#pragma mark -MKMapViewDelegate Methods
//偵測地圖有無移動或縮放
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    MKCoordinateRegion region = mapView.region;
    NSLog(@"Center changed to: %.6f,%.6f",region.center.latitude,region.center.longitude);
}


@end
