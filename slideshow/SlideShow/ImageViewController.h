//  ImageViewController.h
//  Camera
//
//  Created by Rushan on 2017-05-29.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo+CoreDataProperties.h"
#import "SlideShow+CoreDataClass.h"

@import MapKit;

@interface ImageViewController : UIViewController <UINavigationControllerDelegate>

@property (strong, nonatomic) Photo *detailItem;

@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property(nonatomic)SlideShow *slideShow;

- (void)configureCell;

@end
