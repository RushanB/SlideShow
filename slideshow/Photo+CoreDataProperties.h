//
//  Photo+CoreDataProperties.h
//  SlideShow
//
//  Created by Mandeep on 2017-06-02.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "Photo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

+ (NSFetchRequest<Photo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *detailsText;
@property (nonatomic) int16_t order;
@property (nullable, nonatomic, retain) NSData *savedImage;
@property (nullable, nonatomic, copy) NSString *titleText;
@property (nullable, nonatomic, retain) SlideShow *slideShow;

@end

NS_ASSUME_NONNULL_END
