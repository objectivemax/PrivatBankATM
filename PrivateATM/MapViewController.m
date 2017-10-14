//
//  MapViewController.m
//  PrivateATM
//
//  Created by Maxim Ohrimenko on 10/13/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "MapViewController.h"

#define getCity @"https://api.privatbank.ua/p24api/infrastructure?json&atm&address=&city="

@interface MapViewController ()

@end

@implementation MapViewController {
    NSDictionary *paramDic;
    CLLocationManager *locationManager;
    NSString *workTime;
    float latitude;
    float longitude;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self cityCoordinate];
    [self getMap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) getMap {
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@", getCity, _nameCity];
    NSString *encoded =
    [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *weatherURL = [NSURL URLWithString:encoded];
    NSURLRequest *request = [NSURLRequest requestWithURL:weatherURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
             NSLog(@"Error: %@", error);
        } else {
            _jsonCity = [responseObject objectForKey:@"devices"];
            NSLog(@"DEVICES: %@", _jsonCity);
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self googleMaps];
                NSLog(@"otpavivli update table");
            });
        }
    }];
    [dataTask resume];
}


- (void) googleMaps {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:14];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.delegate = self;
    mapView.settings.consumesGesturesInView = NO;
    
    for (NSDictionary* dict in _jsonCity) {
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = [[[CLLocation alloc]initWithLatitude:[dict[@"latitude"]floatValue] longitude:[dict[@"longitude"]floatValue]] coordinate];
        marker.title = @"PrivatBank ATM";
        
        NSArray *TW = dict[@"tw"];
        NSString *monday = [TW valueForKey:@"mon"];
        NSString *tuesday = [TW valueForKey:@"tue"];
        NSString *wednesday = [TW valueForKey:@"wed"];
        NSString *thursday = [TW valueForKey:@"thu"];
        NSString *friday = [TW valueForKey:@"fri"];
        NSString *saturday = [TW valueForKey:@"sat"];
        NSString *sunday = [TW valueForKey:@"sun"];
        
        workTime = [NSString stringWithFormat:@"Место: %@\n\nАдресс: %@\n\nВремя Работы:\nПонедельник: %@\nВторник: %@\nСреда: %@\nЧетверг: %@\nПятница: %@\nСуббота: %@\nВоскресенье: %@\n", dict[@"placeRu"], dict[@"fullAddressRu"], monday, tuesday, wednesday, thursday, friday, saturday, sunday];
        

        marker.snippet = workTime;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView;
    }
    self.view = mapView;
}


- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(nonnull GMSMarker *)marker
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:marker.snippet
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)cityCoordinate {
    if ([_nameCity isEqualToString:@"Винница"]) {
        latitude = 49.237222,
        longitude = 28.467222;
        
    } else if ([_nameCity isEqualToString:@"Днепропетровск"]) {
        latitude = 48.466111;
        longitude = 35.025278;
        
    } else if ([_nameCity isEqualToString:@"Донецк"]) {
        latitude = 48.008889;
        longitude = 37.804167;
        
    } else if ([_nameCity isEqualToString:@"Житомир"]) {
        latitude = 50.254444;
        longitude = 28.657778;
        
    } else if ([_nameCity isEqualToString:@"Запорожье"]) {
        latitude = 47.837778;
        longitude = 35.138333;
        
    } else if ([_nameCity isEqualToString:@"Ивано-Франковск"]) {
        latitude = 48.922778;
        longitude = 24.710556;
        
    } else if ([_nameCity isEqualToString:@"Киев"]) {
        latitude = 50.45;
        longitude = 30.523611;
        
    } else if ([_nameCity isEqualToString:@"Кировоград"]) {
        latitude = 48.51;
        longitude = 32.266667;
    
    } else if ([_nameCity isEqualToString:@"Луганск"]) {
        latitude = 48.568333;
        longitude = 39.308611;
        
    } else if ([_nameCity isEqualToString:@"Луцк"]) {
        latitude = 50.747778;
        longitude = 25.324444;
        
    } else if ([_nameCity isEqualToString:@"Львов"]) {
        latitude = 49.83;
        longitude = 24.014167;
        
    } else if ([_nameCity isEqualToString:@"Николаев"]) {
        latitude = 46.975278;
        longitude = 31.993611;
        
    } else if ([_nameCity isEqualToString:@"Одесса"]) {
        latitude = 46.485639;
        longitude = 30.7435;
        
    } else if ([_nameCity isEqualToString:@"Полтава"]) {
        latitude = 49.589444;
        longitude = 34.551111;
        
    } else if ([_nameCity isEqualToString:@"Ровно"]) {
        latitude = 50.619722;
        longitude = 26.251389;
        
    } else if ([_nameCity isEqualToString:@"Сумы"]) {
        latitude = 50.911944;
        longitude = 34.803333;
        
    } else if ([_nameCity isEqualToString:@"Тернополь"]) {
        latitude = 49.553333;
        longitude = 25.594722;
        
    } else if ([_nameCity isEqualToString:@"Ужгород"]) {
        latitude = 48.623889;
        longitude = 22.295;
        
    } else if ([_nameCity isEqualToString:@"Харьков"]) {
        latitude = 50.005833;
        longitude = 36.229167;
        
    } else if ([_nameCity isEqualToString:@"Херсон"]) {
        latitude = 46.64;
        longitude = 32.614444;
        
    } else if ([_nameCity isEqualToString:@"Хмельницкий"]) {
        latitude = 49.419444;
        longitude = 26.979444;
        
    } else if ([_nameCity isEqualToString:@"Черкассы"]) {
        latitude = 49.444444;
        longitude = 32.059722;
        
    } else if ([_nameCity isEqualToString:@"Чернигов"]) {
        latitude = 51.491111;
        longitude = 31.298611;
        
    } else if ([_nameCity isEqualToString:@"Черновцы"]) {
        latitude = 48.321944;
        longitude = 25.921667;
    }
}
@end
