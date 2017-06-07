//  ImageViewController.m
//  Camera
//
//  Created by Rushan on 2017-05-29.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "ImageViewController.h"
#import "PhotoViewController.h"
#import "EditView.h"
#import "AppDelegate.h"
#import "SlideShow+CoreDataProperties.h"
#import "TextAndTitleViewController.h"

@interface ImageViewController () <EditViewDelegate>{
    EditView *currentLabel;
    NSMutableArray *labels;
}

@property (strong, nonatomic) NSArray *colors;

@end

@implementation ImageViewController

#pragma mark ITEMS

-(void)configureCell{  //sets image
    if (self.detailItem)
    {
        self.detailImage.image = [UIImage imageWithData:self.detailItem.savedImage];
        
    }
    
}

- (void)setDetailItem:(Photo*)newDetailItem{
    if (_detailItem != newDetailItem){
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureCell];
    }
}

#pragma mark BUTTONS
-(void)addContent{
    UIImage *image = [self visibleImage];
    
    NSManagedObjectContext *context = [self managerofObjects];

    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
    self.detailItem.savedImage = imageData;
    // need to set photo.slideShow to the appropriate slideshow
    self.detailItem.slideShow = self.slideShow;

    NSError *err;
    [context save:&err];
    if (err) {
        NSLog(@"Error: %@", err.localizedDescription);
        abort();
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TextAndTitleViewController *textAndTitle = [storyboard instantiateViewControllerWithIdentifier:@"textAndTitle"];
    //    imageController.delegate
    
    textAndTitle.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    textAndTitle.photo = self.detailItem;
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:textAndTitle]; //navigation controller
    
    [self presentViewController:nav animated:NO completion:nil];
}

- (void)addLabel{
    [currentLabel hideEditingHandles];
    //adds label to random areas by the mid section
    CGRect labelFrame = CGRectMake(CGRectGetMidX(self.detailImage.frame) - arc4random() % 40,
                                   CGRectGetMinY(self.detailImage.frame) - arc4random() % 40,
                                   200,80); //size of the frame that holds the label
    
    EditView *labelView = [[EditView alloc] initWithFrame:labelFrame];
    //each label has these qualities
    [labelView setDelegate:self];
    [labelView setEnableMoveRestriction:YES];
    [labelView setFontName:@"Quora-Bold"];
    [labelView setFontSize:30.0];
    
    [self.detailImage addSubview:labelView];
    [self.detailImage setUserInteractionEnabled:YES];
    
    if (arc4random() % 2 == 0) {
        [labelView setAttributedPlaceholder:[[NSAttributedString alloc]
                                             initWithString:NSLocalizedString(@"Placeholder", nil)
                                             attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.75] }]];
    }
    currentLabel = labelView;
    [labels addObject:labelView];
}

-(NSManagedObjectContext *)managerofObjects{
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return delegate.persistentContainer.viewContext;
}


- (void)saveImage{
    // SAVE TO PHOTOS ARRAY
    UIImage *image = [self visibleImage];
    
    NSManagedObjectContext *context = [self managerofObjects];
    //    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
    self.detailItem.savedImage = imageData;
    // need to set photo.slideShow to the appropriate slideshow
    self.detailItem.slideShow = self.slideShow;

    NSError *err;
    [context save:&err];
    if (err) {
        NSLog(@"Error: %@", err.localizedDescription);
        abort();
    }
    //    [newImage setValue:data forKey:@"savedImage"];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    //    [object setValue:imageData forKey:@"savedImage"];
    //    SAVE TO CAMERA ROLL
    //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    //            UIImageWriteToSavedPhotosAlbum([self visibleImage], nil, nil, nil);
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                NSLog(@"Saved to Photo Roll");
    //            });
    //        });
    //}
}

//SAVE TO CAMERA ROLL HELPER METHOD
-(UIImage *)visibleImage{
    
    UIGraphicsBeginImageContextWithOptions(self.detailImage.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), CGRectGetMinX(self.detailImage.frame), -CGRectGetMinY(self.detailImage.frame));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *visibleViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return visibleViewImage;
}

-(void)backButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)delButton{
    NSManagedObjectContext *context = [self managerofObjects];
    
    [context deleteObject:self.detailItem];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Error deleting image, %@", [error userInfo]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeColor{
    //changes text color randomly
    [currentLabel setTextColor:[self.colors objectAtIndex:arc4random() % 5]];
}

#pragma mark GESTURES

- (void)touchOutside:(UITapGestureRecognizer *)touchGesture{
    //hides the label
    [currentLabel hideEditingHandles];
}


#pragma mark DELEGATE

- (void)labelViewDidClose:(EditView *)label{
    // some actions after delete label
    [labels removeObject:label];
}

- (void)labelViewDidBeginEditing:(EditView *)label{
    // move or rotate begin
}

- (void)labelViewDidShowEditingHandles:(EditView *)label{
    // showing border and control buttons
    currentLabel = label;
}

- (void)labelViewDidHideEditingHandles:(EditView *)label{
    // hiding border and control buttons
    currentLabel = nil;
}

- (void)labelViewDidStartEditing:(EditView *)label{
    // tap in text field and keyboard showing
    currentLabel = label;
}

#pragma mark VIEW

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self configureCell];
    
    
    self.colors = [NSArray arrayWithObjects:[UIColor whiteColor], [UIColor redColor], [UIColor blueColor], [UIColor greenColor], [UIColor blackColor], nil];
    
    //NAVIGATION BAR START
    //COLOR SCHEME - start
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = YES;
    //COLOR SCHEME - end
    
    //NAV BAR - left
    UIBarButtonItem *addBackButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backButton)];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delButton)];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: addBackButton, deleteButton, nil];
    
    //NAV BAR - right
    UIBarButtonItem *addLabelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addLabel)];
    
    UIBarButtonItem *refreshColorButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(changeColor)];
    
    UIBarButtonItem *contentButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(addContent)];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(saveImage)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:saveButton, contentButton, refreshColorButton, addLabelButton, nil];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchOutside:)]];
    //NAVIGATION BAR END
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
