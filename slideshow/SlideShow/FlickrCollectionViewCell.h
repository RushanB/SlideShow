//
//  FlickrCollectionViewCell.h
//  SlideShow
//
//  Created by Rushan on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"

@interface FlickrCollectionViewCell : UICollectionViewCell

@property (nonatomic) FlickrPhoto *aPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
