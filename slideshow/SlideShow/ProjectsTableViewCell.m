//
//  ProjectsTableViewCell.m
//  SlideShow
//
//  Created by Mandeep on 2017-05-31.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "ProjectsTableViewCell.h"

@implementation ProjectsTableViewCell

- (void)setProject:(SlideShow *)project {
    self.title.text= project.name;
    NSString *dateString = [NSDateFormatter dateFormatFromTemplate:@"MM-dd-yy" options:0 locale: [NSLocale currentLocale] ];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocalizedDateFormatFromTemplate:dateString];
    self.creationDate.text = [formatter stringFromDate:project.creationDate];
    NSLog(@"%@", self.creationDate.text);

    _project = project;
}

@end
