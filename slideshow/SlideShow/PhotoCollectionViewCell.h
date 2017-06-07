//
//  Camera
//
//  Created by Rushan on 2017-05-29.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo+CoreDataClass.h"

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic)Photo *photo;


@end
