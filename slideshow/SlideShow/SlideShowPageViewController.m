//
//  SlideShowPageViewController.m
//  SlideShow
//
//  Created by Mandeep on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "SlideShowPageViewController.h"
#import "SlideShowViewController.h"
#import "Photo+CoreDataClass.h"

@interface SlideShowPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic)NSArray *slideDeck;
@property(nonatomic)NSArray *slideViewControllers;

@end

@implementation SlideShowPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    
    
    NSArray *deck = [self.slideShow.photos allObjects];
    
    NSSortDescriptor *slideOrder = [[NSSortDescriptor alloc]initWithKey:@"order" ascending:YES];
    
    self.slideDeck = [deck sortedArrayUsingDescriptors:[NSArray arrayWithObject:slideOrder]];
    
    NSMutableArray *presentation = [NSMutableArray new];
    
    for (Photo *photo in self.slideDeck) {
        [presentation addObject:[self viewControllerAtIndex:photo]];
    }
    [self setViewControllers:@[presentation[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.slideViewControllers = presentation;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(SlideShowViewController *)viewControllerAtIndex:(Photo *)photo{
    
    SlideShowViewController *newSlide= (SlideShowViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"slideShower"];
    newSlide.photo = photo;
    
    return newSlide;
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger currentIndex = [self.slideViewControllers indexOfObject:viewController];
    
    if (currentIndex == 0) {
        return nil;
    }
    
    return self.slideViewControllers[currentIndex - 1];
}
    


-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger currentIndex = [self.slideViewControllers indexOfObject:viewController];
    
    if (currentIndex == self.slideViewControllers.count -1) {
        return nil;
    }
    
    return self.slideViewControllers[currentIndex + 1];
    
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
