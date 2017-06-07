//
//  LocationManager.m
//  SlideShow
//
//  Created by Rushan on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "LocationManager.h"
#import "flickrKey.h"

@implementation LocationManager

+ (void)getPictureLocationData:(FlickrPhoto*)picture completion:(void (^)(CLLocationCoordinate2D))completion
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=%@&photo_id=%@&format=json&nojsoncallback=1", FLICKR_APIKEY, picture.photoID];
    
    NSURL *locationURL = [NSURL URLWithString:urlString];
    
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:locationURL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sessionConfiguration = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [sessionConfiguration
                                      dataTaskWithRequest:requestURL
                                      completionHandler:^ (NSData * _Nullable data,
                                                           NSURLResponse * _Nullable response,
                                                           NSError * _Nullable error) {
                                          
                                          if (error) {
                                              
                                              NSLog(@"error: %@", error.localizedDescription);
                                              return;
                                              
                                          }
                                          
                                          NSError *jsonError = nil;
                                          
                                          NSDictionary *getThatJSON = [NSJSONSerialization
                                                                       JSONObjectWithData:data
                                                                       options:0
                                                                       error:&jsonError];
                                          
                                          if (jsonError) {
                                              
                                              NSLog(@"error: %@", jsonError.localizedDescription);
                                              return;
                                              
                                          }
                                          
                                          NSDictionary *photoDictionary = getThatJSON[@"photo"];
                                          NSDictionary *locationDictionary = photoDictionary[@"location"];
                                          
                                          double latitude = [[locationDictionary valueForKey:@"latitude"]doubleValue];
                                          double longitude = [[locationDictionary valueForKey:@"longitude"]doubleValue];
                                          
                                          CLLocationCoordinate2D newLocation = CLLocationCoordinate2DMake(latitude, longitude);
                                          
                                          [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                              completion(newLocation);
                                              
                                          }];
                                          
                                      }];
    
    [dataTask resume];
}

@end
