//
//  FlickrPhoto.m
//  SlideShow
//
//  Created by Mandeep on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//
#import "FlickrPhoto.h"


@implementation FlickrPhoto

-(instancetype)initWithInfo:(NSDictionary *)info{
    if(self = [super init]){
        self.title = info[@"title"];
        self.photoID = info[@"id"];
        
        
        NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",info[@"farm"],info[@"server"], info[@"id"],info[@"secret"]];
        
        self.imageURL = [NSURL URLWithString:urlString];
    }
    return self;
}


+ (NSArray *)makePhotoArray:(NSArray *)aPhotoArray{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSDictionary *information in aPhotoArray) {
        
        FlickrPhoto *img = [[FlickrPhoto alloc] initWithInfo:information];
        [array addObject:img];
        
    }
    
    return array;
}


@end
