//
//  PageViewController.m
//  SlideShow
//
//  Created by Mandeep on 2017-05-28.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "PageViewController.h"
#import "GalleryViewController.h"
#import "ProfileViewController.h"

@interface PageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) NSArray *pages;
@property (nonatomic)NSUInteger index;
//@property (nonatomic) NSArray *pages;
@end

@implementation PageViewController

- (void)setIndex:(NSUInteger)index {
    
    _index = index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = self;
    self.delegate = self;
    
    //    self.pages =@[,];
    self.index = 0;
    ProfileViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    pvc.user = self.user;
    
    
    GalleryViewController *gvc = [self.storyboard instantiateViewControllerWithIdentifier:@"GalleryViewController"];
    
    
    gvc.user = self.user;
    
    self.pages = @[pvc, gvc];
    
    [self setViewControllers:@[pvc]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    if (self.index == 0) {
        return nil;
    }
//    self.index = 0;
    return self.pages[0];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    if (self.index == 1) {
        return nil;
    }
    
//    self.index = 1;
    return self.pages[1];
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        
        if ([previousViewControllers[0] isMemberOfClass:[ProfileViewController class]]) {
            self.index = 1;
        } else {
            self.index = 0;
        }
    }
}


@end
