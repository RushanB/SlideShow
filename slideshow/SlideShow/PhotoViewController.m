//
//  PhotoViewController.m
//  Camera
//
//  Created by Rushan on 2017-05-28.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//
#import "PhotoViewController.h"
#import "PhotoCollectionViewCell.h"
#import "ImageViewController.h"
#import "AppDelegate.h"
#import "Photo+CoreDataClass.h"
#import "Photo+CoreDataProperties.h"
#import <QuartzCore/QuartzCore.h>

#import "SearchViewController.h"
#import "FlickrViewController.h"

@interface PhotoViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSIndexPath *currentIndexPath;

@property (strong, nonatomic) NSArray *images; //array for the photo images

@end

@implementation PhotoViewController

@synthesize images;

static NSString *const reuseIdentifier = @"Cell";

#pragma mark COLLECTIONVIEW

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.images count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Photo *photo = [images objectAtIndex:indexPath.row];
    NSData *loadedData = [photo valueForKey:@"savedImage"];
    
    cell.imageView.image = [UIImage imageWithData:loadedData];
    //SET IMAGE BORDER
    [[cell.imageView layer] setBorderWidth:2.0f];
    //25/255 and 188/255 and 156/255 = Aqua
    [[cell.imageView layer] setBorderColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:200/255.0f alpha:1.0f].CGColor];
    
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath{
    return YES;
}


-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    // change order numbers of appropriate cells
    Photo *sourceImage = [images objectAtIndex:sourceIndexPath.item];
    Photo *destImage =  [images objectAtIndex:destinationIndexPath.item];
    int tmp = sourceImage.order;
    sourceImage.order = destImage.order;
    destImage.order = tmp;
    [[self managerofObjects]save:nil];
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.currentIndexPath = indexPath;
    Photo *currPhoto = [images objectAtIndex:indexPath.item];
    //    [self performSegueWithIdentifier:@"Detail" sender:self];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ImageViewController *imageController = [storyboard instantiateViewControllerWithIdentifier:@"imageController"];
    //    imageController.delegate
    
    imageController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [imageController setDetailItem:currPhoto];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:imageController]; //navigation controller
    
    [self presentViewController:nav animated:NO completion:nil]; //
}

#pragma mark SEGUE

//CONTROLLER IS PRESENTED MODALY OR SEGUE
//    if([segue.identifier isEqualToString:@"Detail"]){
//        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
//        NSManagedObject *object = [images objectAtIndex: indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
//    }


#pragma mark CORE DATA

-(NSManagedObjectContext *)managerofObjects{
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return delegate.persistentContainer.viewContext;
}

#pragma mark GET-PHOTO-FROM-LIBRARY

- (IBAction)openPhotoLibrary:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary; //gets image from photo library
    
    [self presentViewController:imagePickerController animated:NO completion:nil];
}

#pragma mark CAMERA

- (IBAction)openCameraView:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){  //gets camera
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        pickerController.allowsEditing = YES;
        [self presentViewController:pickerController animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"OOPS!" message:@"Your device does not have a camera." preferredStyle:UIAlertControllerStyleAlert]; //no camera
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark IMAGEPICKER

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil]; //dissmiss after cancel
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSManagedObjectContext *context = [self managerofObjects];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];

    Photo *newImage = [[Photo alloc] initWithContext:context];

    NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
    newImage.savedImage = data;
    newImage.order = self.images.count;
    newImage.slideShow = self.slideShow;
    
    NSError *err;
    [context save:&err];
    if (err) {
        NSLog(@"Error: %@", err.localizedDescription);
        abort();
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
    //Storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ImageViewController *imageController = [storyboard instantiateViewControllerWithIdentifier:@"imageController"];
    //    imageController.delegate
    
    imageController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [imageController setDetailItem:newImage];
    
    //    imageController = nav.viewControllers[0];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:imageController]; //navigation controller

    
    [self presentViewController:nav animated:NO completion:nil]; //presents the view controller
}


#pragma mark GESTURES

- (void)moveLongpressMethod:(UILongPressGestureRecognizer *)gestureRecognizer{
    switch(gestureRecognizer.state){  //began, changed, update, end, cancel
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:[gestureRecognizer locationInView:self.collectionView]];
            if(selectedIndexPath == nil) break;
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [self.collectionView updateInteractiveMovementTargetPosition:[gestureRecognizer locationInView:gestureRecognizer.view]]; //
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [self.collectionView endInteractiveMovement];
            break;
        }
        default:
        {
            [self.collectionView cancelInteractiveMovement];
            break;
        }
    }
}

#pragma mark BUTTONS

- (IBAction)searchTapped:(id)sender {
    //    [self performSegueWithIdentifier:@"Flick" sender:self];
    
}

- (IBAction)backTapped:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark VIEW

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NSManagedObjectContext *context = [self managerofObjects];
    
    //eventually will fetch slideshow and images will be slideshow.photo
    NSFetchRequest *fetch = [Photo fetchRequest]; //fetch with entity name
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES] ];
    images = [context executeFetchRequest:fetch error:nil];  //sets images into collectionvi
    
    
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //COLOR SCHEME - start
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = YES;
    //COLOR SCHEME - end
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UILongPressGestureRecognizer *moveImage
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(moveLongpressMethod:)]; //allows you to rearrange the cells
    moveImage.minimumPressDuration = 0.2; //seconds
    [self.collectionView addGestureRecognizer: moveImage];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
