//
//  SlideShowViewController.m
//  SlideShow
//
//  Created by Mandeep on 2017-06-02.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "SlideShowViewController.h"
#import "ZoomViewController.h"

@interface SlideShowViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTV;

@end

@implementation SlideShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = [UIImage imageWithData:self.photo.savedImage];
    self.titleLabel.text = self.photo.titleText;
    self.detailTV.text=self.photo.detailsText;
}
- (IBAction)zoom:(id)sender {
    
    [self performSegueWithIdentifier:@"zoomIn" sender:sender];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"zoomIn"]) {
        
        UINavigationController *navController = segue.destinationViewController;
        ZoomViewController *zoom = navController.viewControllers[0];
        zoom.photo = self.photo;
        
    }

    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
