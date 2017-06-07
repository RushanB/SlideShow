//
//  ProjectsTableViewCell.h
//  SlideShow
//
//  Created by Mandeep on 2017-05-31.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideShow+CoreDataClass.h"

@interface ProjectsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *creationDate;
@property (weak, nonatomic) IBOutlet UIImageView *firstSlideImage;
@property (nonatomic) SlideShow *project;


@end
