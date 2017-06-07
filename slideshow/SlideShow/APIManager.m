//
//  APIManager.m
//  SlideShow
//
//  Created by Rushan on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "APIManager.h"
#import "FlickrPhoto.h"
#import "flickrKey.h"

@implementation APIManager

+ (void)getPhotos:(NSString *)taggedItems andLatitude:(double)photoLatitude andLongitude:(double)photoLongitude withBlock:(void (^)(NSArray *))completion{
    
    NSString *urlString = [[NSString alloc] init];
    
    if (photoLatitude == 0 && photoLongitude == 0) {
        
        urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&has_geo=1&extras=url_m&format=json&nojsoncallback=1",
                     FLICKR_APIKEY, taggedItems];
    }else{
        urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&has_geo=1&lat=%f&lon=%f&extras=url_m&format=json&nojsoncallback=1", FLICKR_APIKEY, taggedItems, photoLatitude, photoLongitude];
        
    }
    
    NSURL *aURL = [NSURL URLWithString:urlString];
    
    
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:aURL];
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *configureSession = [NSURLSession sessionWithConfiguration:configure];
    
    NSURLSessionDataTask *dataTask = [configureSession
                                      dataTaskWithRequest:requestURL
                                      completionHandler:^
                                      (NSData * _Nullable data,
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
                                          
                                          NSArray *pictures = getThatJSON[@"photos"][@"photo"];
                                          
                                          NSArray *photosArray = [FlickrPhoto makePhotoArray:pictures];
                                          
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                              completion(photosArray);
                                          }];
                                          
                                          
                                      }];
    
    
    [dataTask resume];
}

+ (void)downloadPhotos:(NSURL *)url completion:(void (^)(UIImage * image))completion{
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *configureSession = [NSURLSession sessionWithConfiguration:configure];
    
    
    NSURLSessionDownloadTask *downloadPhotos = [configureSession
                                                downloadTaskWithURL:url
                                                completionHandler:^(NSURL * _Nullable location,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error) {
                                                    
                                                    if (error) {
                                                        
                                                        NSLog(@"%@", error.localizedDescription);
                                                        return;
                                                        
                                                    }
                                                    
                                                    NSData *pictureData = [NSData dataWithContentsOfURL:url];
                                                    UIImage *picture = [UIImage imageWithData:pictureData];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                        
                                                        completion(picture);
                                                        
                                                    }];
                                                    
                                                }];
    
    [downloadPhotos resume];
}


@end
