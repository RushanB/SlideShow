//
//  SlideShow+CoreDataProperties.m
//  SlideShow
//
//  Created by Mandeep on 2017-06-02.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "SlideShow+CoreDataProperties.h"

@implementation SlideShow (CoreDataProperties)

+ (NSFetchRequest<SlideShow *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SlideShow"];
}

@dynamic creationDate;
@dynamic name;
@dynamic photos;
@dynamic user;

@end
