//
//  LogInViewController.m
//  SlideShow
//
//  Created by Rushan on 2017-05-26.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "LogInViewController.h"
#import "User+CoreDataClass.h"
#import "PageViewController.h"
#import "AppDelegate.h"

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (nonatomic) AppDelegate *appDelegate;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UILabel *loginErrorLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.backgroundImageView addGestureRecognizer:tapGesture];
}

-(void)hideKeyBoard {
    [self.userNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"enterApp"]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.predicate = [NSPredicate predicateWithFormat:@"userName = %@",self.userNameTF.text];
        NSError *error =nil;
        NSArray<User *> *users = [self.context executeFetchRequest:request error:&error];
        if (users.count == 0 || error) {
            // TODO: set an error message
            NSLog(@"%@",error);
            return NO;
        } else {
            self.user = users[0];
            return YES;
        }
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"enterApp"]) {
        PageViewController *pageVC =segue.destinationViewController;
        pageVC.user=self.user;
    }
}


- (IBAction)enterTap:(id)sender {
}




@end
