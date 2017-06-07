//
//  NewSlideShowViewController.h
//  SlideShow
//
//  Created by Mandeep on 2017-05-31.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideShow+CoreDataClass.h"
#import "User+CoreDataClass.h"


@protocol fetchSlideShowDelegate <NSObject>

- (void)fetchSlideShows;


@end

@interface NewSlideShowViewController : UIViewController

@property (nonatomic)id <fetchSlideShowDelegate> delegate;

@property(nonatomic)User *user;


@end
