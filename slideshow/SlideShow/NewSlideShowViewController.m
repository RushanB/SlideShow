//
//  NewSlideShowViewController.m
//  SlideShow
//
//  Created by Mandeep on 2017-05-31.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "NewSlideShowViewController.h"
#import "AppDelegate.h"


@interface NewSlideShowViewController ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UITextField *slideShowNameTF;

@end

@implementation NewSlideShowViewController

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
    [self.slideShowNameTF resignFirstResponder];
}

- (void)createSlideShow {
    SlideShow *slideShow = [[SlideShow alloc] initWithContext:self.context];
//    SlideShow *slideShow = [NSEntityDescription insertNewObjectForEntityForName:@"SlideShow" inManagedObjectContext:self.context];
    
    slideShow.name = self.slideShowNameTF.text;
    slideShow.creationDate = [NSDate date];
    slideShow.user = self.user;
    
    [self.appDelegate saveContext];
    [self.delegate fetchSlideShows];

    
}

- (IBAction)cancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)createTap:(id)sender {
    [self createSlideShow];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
