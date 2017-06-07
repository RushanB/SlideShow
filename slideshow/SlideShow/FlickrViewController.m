//
//  FlickrViewController.m
//  SlideShow
//
//  Created by Rushan on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "FlickrViewController.h"
#import "FlickrCollectionViewCell.h"
#import "APIManager.h"
#import "SearchViewController.h"

#import "Photo+CoreDataProperties.h"
#import "ImageViewController.h"
#import "AppDelegate.h"

@interface FlickrViewController () <UICollectionViewDelegate, UICollectionViewDataSource, SearchViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *flickrImages;

@property (nonatomic) NSMutableArray *photoArray;

@property (nonatomic) NSIndexPath *currentIndexPath;

@end

@implementation FlickrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoArray = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TABLEVIEW

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.photoArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FlickrCollectionViewCell *cell = [self.flickrImages dequeueReusableCellWithReuseIdentifier:@"Images" forIndexPath:indexPath];
    cell.aPhoto = self.photoArray[indexPath.row];
    
    return cell;
}


-(NSManagedObjectContext *)managerofObjects{
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return delegate.persistentContainer.viewContext;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.currentIndexPath = indexPath;
    NSManagedObjectContext *context = [self managerofObjects];
    Photo *anImage = [[Photo alloc] initWithContext:context];
    FlickrPhoto *currPhoto = [self.photoArray objectAtIndex:indexPath.item];
    //    [self performSegueWithIdentifier:@"Detail" sender:self];
    
    //Block gets image from url and sets it into imageviewcontroller as core data
    [APIManager downloadPhotos:currPhoto.imageURL completion:^(UIImage *image) {
        anImage.savedImage = UIImagePNGRepresentation(image);
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ImageViewController *imageController = [storyboard instantiateViewControllerWithIdentifier:@"imageController"];
        //    imageController.delegate
        
        imageController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [imageController setDetailItem:anImage];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:imageController]; //navigation controller
        
        [self presentViewController:nav animated:NO completion:nil];
    }];
    
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Search"]){
        SearchViewController *svc = segue.destinationViewController;
        svc.searchViewControllerDelegate = self;
    }
}


-(void)getArrayOfSearchedPhotos:(NSMutableArray *)arrayOfTaggedPhotos{
    self.photoArray = arrayOfTaggedPhotos;
    
    [self.flickrImages reloadData];
    
}

@end
