//
//  User+CoreDataProperties.h
//  SlideShow
//
//  Created by Mandeep on 2017-06-02.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *fName;
@property (nullable, nonatomic, copy) NSString *lName;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, retain) NSData *profilePicture;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, retain) NSSet<SlideShow *> *slideShows;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addSlideShowsObject:(SlideShow *)value;
- (void)removeSlideShowsObject:(SlideShow *)value;
- (void)addSlideShows:(NSSet<SlideShow *> *)values;
- (void)removeSlideShows:(NSSet<SlideShow *> *)values;

@end

NS_ASSUME_NONNULL_END
