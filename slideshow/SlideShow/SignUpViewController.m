//
//  SignUpViewController.m
//  SlideShow
//
//  Created by Mandeep on 2017-05-29.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "SignUpViewController.h"
#import "User+CoreDataClass.h"
#import "AppDelegate.h"
@import CoreData;

@interface SignUpViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic) AppDelegate *appDelegate;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
}

-(void)hideKeyBoard {
    [self.firstName resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self.emailAddress resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
}


- (void)createUser {
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];  //[[User alloc] initWithContext:self.context];
    
    NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
    user.profilePicture = imageData;
    user.fName = self.firstName.text;
    user.lName = self.lastName.text;
    user.email = self.emailAddress.text;
    user.userName = self.userName.text;
    user.password = self.password.text;
    
    [self.appDelegate saveContext];
    // save the object
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectProfileImage:(id)sender {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    // is the camera available?
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // if so, use that
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        // no camera, just use photo library
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // what types of media can we ask for?
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:ipc.sourceType];
    NSLog(@"Media types are %@", availableMediaTypes);
    ipc.mediaTypes = availableMediaTypes;
    // if we wanted, we could limit to just images or just videos
    //ipc.mediaTypes = @[ kUTTypeImage];
    
    // we need to make ourselves the delegate of the image picker so we can see the picked image & do something with it
    ipc.delegate = self;
    
    [self presentViewController:ipc animated:YES completion:^{
        NSLog(@"Picker is showing");
    }];
}
- (IBAction)photoLib:(id)sender {
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;


// what types of media can we ask for?
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:ipc.sourceType];
    NSLog(@"Media types are %@", availableMediaTypes);
    ipc.mediaTypes = availableMediaTypes;
// if we wanted, we could limit to just images or just videos
//ipc.mediaTypes = @[ kUTTypeImage];

// we need to make ourselves the delegate of the image picker so we can see the picked image & do something with it
    ipc.delegate = self;

    [self presentViewController:ipc animated:YES completion:^{
    NSLog(@"Picker is showing");
    }];


}

#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"Finished picking %@", info);
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"done");
    }];
}

#pragma mark - create/cancel User
- (IBAction)cancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createTap:(id)sender {
    
    [self createUser];
    [self dismissViewControllerAnimated:YES completion:nil];

    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
