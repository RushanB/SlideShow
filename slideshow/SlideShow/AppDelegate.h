//
//  AppDelegate.h
//  SlideShow
//
//  Created by Rushan on 2017-05-26.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

-(NSURL *)applicationDocumentDirectory;

@end

