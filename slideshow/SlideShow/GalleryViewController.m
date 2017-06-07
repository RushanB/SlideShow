//
//  GalleryViewController.m
//  SlideShow
//
//  Created by Rushan on 2017-05-27.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "GalleryViewController.h"
#import "SlideShow+CoreDataClass.h"
#import "ProjectsTableViewCell.h"
#import "AppDelegate.h"
#import "NewSlideShowViewController.h"
#import "PhotoViewController.h"
#import "SlideShowPageViewController.h"

@interface GalleryViewController () <fetchSlideShowDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray <SlideShow *> *slideShows;
@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
//    [self fetchSlideShows];
    self.nameLabel.text = [NSString stringWithFormat:@"%@'s Projects",self.user.fName];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.slideShows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"Cell";
    
    ProjectsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.project = self.slideShows[indexPath.row];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchSlideShows];
}

//- (void)fetchDate {
//    // TODO fetch data
//    [self fetchSlideShows];
//    [self.tableView reloadData];
//}

- (void)fetchSlideShows {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SlideShow"];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES];
    request.sortDescriptors = @[sort];
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"user.userName = %@",self.user.userName];
    request.predicate = predicate;
    
    NSArray <SlideShow*>*slideShows = [self.context executeFetchRequest:request error:nil];

    self.slideShows = slideShows;
    [self.tableView reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"newProject"]) {
        NewSlideShowViewController *newSSVC =segue.destinationViewController;
        newSSVC.delegate = self;
        newSSVC.user = self.user;
    }
    if ([segue.identifier isEqualToString:@"editProject"]) {
        UINavigationController* nav =segue.destinationViewController;
        PhotoViewController *photoVC = (PhotoViewController*)nav.topViewController;
        UIButton *button = (UIButton*)sender;
        ProjectsTableViewCell *cell = (ProjectsTableViewCell*)button.superview.superview;
        photoVC.slideShow = cell.project;
    }
    if ([segue.identifier isEqualToString:@"playShow"]) {
        
        SlideShowPageViewController *slideShowPVC =segue.destinationViewController;
        
        ProjectsTableViewCell *cell = sender;
        
        slideShowPVC.slideShow = cell.project;
    
    }

    
}





@end
