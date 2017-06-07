//
//  APIManager.h
//  SlideShow
//
//  Created by Mandeep on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APIManager : NSObject

+ (void)getPhotos:(NSString *)taggedItems andLatitude:(double)photoLatitude andLongitude:(double)photoLongitude withBlock:(void (^)(NSArray *))completion;

+ (void)downloadPhotos:(NSURL *)url completion:(void (^)(UIImage *image))completion;

@end
