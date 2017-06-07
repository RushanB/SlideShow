//
//  ZoomViewController.h
//  SlideShow
//
//  Created by Mandeep on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo+CoreDataClass.h"

@interface ZoomViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic)Photo *photo;
@end
