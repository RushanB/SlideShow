//
//  GalleryViewController.h
//  SlideShow
//
//  Created by Rushan on 2017-05-27.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User+CoreDataClass.h"
#import "NewSlideShowViewController.h"



@interface GalleryViewController : UIViewController <fetchSlideShowDelegate>

@property (nonatomic)User *user;


@end
