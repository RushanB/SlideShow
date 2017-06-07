//
//  PhotoCollectionViewCell.m
//  SlideShow
//
//  Created by Rushan on 2017-05-30.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

-(void)setPhoto:(Photo *)photo{
    
    self.imageView.image = [UIImage imageWithData:photo.savedImage];
    
    _photo = photo;
}

@end
