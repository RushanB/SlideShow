//
//  User+CoreDataProperties.m
//  SlideShow
//
//  Created by Mandeep on 2017-06-02.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic email;
@dynamic fName;
@dynamic lName;
@dynamic password;
@dynamic profilePicture;
@dynamic userName;
@dynamic slideShows;

@end
