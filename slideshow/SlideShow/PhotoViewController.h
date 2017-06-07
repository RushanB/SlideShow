//  Camera
//
//  Created by Rushan on 2017-05-28.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideShow+CoreDataClass.h"


@interface PhotoViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property(nonatomic)SlideShow *slideShow;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
