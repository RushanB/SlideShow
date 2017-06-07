//
//  ZoomViewController.m
//  SlideShow
//
//  Created by Mandeep on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "ZoomViewController.h"

@interface ZoomViewController ()


@end

@implementation ZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = [UIImage imageWithData:self.photo.savedImage];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)backTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
