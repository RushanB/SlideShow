//
//  Photo+CoreDataProperties.m
//  SlideShow
//
//  Created by Mandeep on 2017-06-02.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "Photo+CoreDataProperties.h"

@implementation Photo (CoreDataProperties)

+ (NSFetchRequest<Photo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
}

@dynamic detailsText;
@dynamic order;
@dynamic savedImage;
@dynamic titleText;
@dynamic slideShow;

@end
