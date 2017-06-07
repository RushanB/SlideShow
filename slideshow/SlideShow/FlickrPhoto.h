//
//  FlickrPhoto.h
//  SlideShow
//
//  Created by Mandeep on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;
@import CoreData;


@interface FlickrPhoto : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *photoID;

@property (nonatomic) CLLocationCoordinate2D coordinate;

-(instancetype)initWithInfo:(NSDictionary *)info;

+ (NSArray *)makePhotoArray:(NSArray *)aPhotoArray;

@end
