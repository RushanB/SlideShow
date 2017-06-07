//  EditView.h
//  Camera
//
//  Created by Rushan on 2017-05-30.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@protocol EditViewDelegate;

@interface EditView : UIView

@property (nonatomic, strong) UIColor *textColor;  //text properties
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, copy) NSAttributedString *attributedPlaceholder;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIImage *closeImage;

@property (nonatomic, weak) id <EditViewDelegate> delegate; //delegate method

@property (nonatomic, getter=isEnableClose) BOOL enableClose;  //text interaction
@property (nonatomic, getter=isEnableRotate) BOOL enableRotate;
@property (nonatomic, getter=isEnableMoveRestriction) BOOL enableMoveRestriction;
- (void)hideEditingHandles;
- (void)showEditingHandles;

@end

@protocol EditViewDelegate <NSObject>  //delegate methods

@optional

- (void)labelViewDidClose:(EditView *)label;

- (void)labelViewDidShowEditingHandles:(EditView *)label;

- (void)labelViewDidHideEditingHandles:(EditView *)label;

- (void)labelViewDidStartEditing:(EditView *)label;

- (void)labelViewDidBeginEditing:(EditView *)label;

- (void)labelViewDidChangeEditing:(EditView *)label;

- (void)labelViewDidEndEditing:(EditView *)label;

@end
