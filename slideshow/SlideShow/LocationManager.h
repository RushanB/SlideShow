//  LocationManager.h
//  SlideShow
//
//  Created by Rushan on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrPhoto.h"

@interface LocationManager : NSObject

+ (void)getPictureLocationData:(FlickrPhoto*)picture completion:(void (^)(CLLocationCoordinate2D))completion;

@end
