//
//  ProfileViewController.m
//  SlideShow
//
//  Created by Rushan on 2017-05-27.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailAddress;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (nonatomic) AppDelegate *appDelegate;
@property (nonatomic) NSManagedObjectContext *context;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",self.user.fName,self.user.lName];
    self.emailAddress.text = [NSString stringWithFormat:@"%@",self.user.email];
    self.userNameLabel.text = [NSString stringWithFormat:@"%@",self.user.userName];
    self.profileImageView.image = [UIImage imageWithData:self.user.profilePicture]; 
}



@end
