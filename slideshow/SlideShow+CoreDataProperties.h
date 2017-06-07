//
//  SlideShow+CoreDataProperties.h
//  SlideShow
//
//  Created by Mandeep on 2017-06-02.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "SlideShow+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SlideShow (CoreDataProperties)

+ (NSFetchRequest<SlideShow *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *creationDate;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;
@property (nullable, nonatomic, retain) User *user;

@end

@interface SlideShow (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

@end

NS_ASSUME_NONNULL_END
