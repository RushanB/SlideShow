//  FlickrCollectionViewCell.m
//  SlideShow
//
//  Created by Rushan on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrCollectionViewCell.h"
#import "APIManager.h"

@interface FlickrCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation FlickrCollectionViewCell

-(void)setAPhoto:(FlickrPhoto *)aPhoto{
    _aPhoto = aPhoto;
    [self configureCell];
    
}

-(void)configureCell{
    self.titleLabel.text = self.aPhoto.title;
    [APIManager downloadPhotos:self.aPhoto.imageURL completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

@end
