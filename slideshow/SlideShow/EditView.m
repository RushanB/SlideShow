//
//
//  Created by Rushan on 2017-05-30.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "EditView.h"
#import <Foundation/Foundation.h>


static EditView *lastTouchedView;

@interface EditView() <UITextFieldDelegate, UIGestureRecognizerDelegate>

@end


@implementation EditView{
    CGFloat globalInset;
    CGRect initialBounds;
    
    CGPoint beginningPoint;
    CGPoint beginningCenter;
    CGPoint touchLocation;
    
    CGRect beginBounds;
    
    UITextField *labelTextField;
    //    UITextView *labelTextField;
    UIImageView *closeView;
    
    BOOL isShowingEditingHandles;
}

@synthesize textColor;
@synthesize fontName, fontSize;
@synthesize enableClose, enableMoveRestriction;
@synthesize delegate;
@synthesize closeImage;

#pragma VIEW

CGSize CGAffineTransformGetScale(CGAffineTransform t){  //returns a scale
    return CGSizeMake(sqrt(t.a * t.a + t.c * t.c), sqrt(t.b * t.b + t.d * t.d)) ;
}

- (void)refresh{
    if (self.superview) {
        CGSize scale = CGAffineTransformGetScale(self.superview.transform);
        CGAffineTransform t = CGAffineTransformMakeScale(scale.width, scale.height);
        [closeView setTransform:CGAffineTransformInvert(t)];
        
    }
}

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self refresh];
}


- (void)setFrame:(CGRect)newFrame{
    [super setFrame:newFrame];
    [self refresh];
}

- (id)initWithFrame:(CGRect)frame
{
    if (frame.size.width < 25)     frame.size.width = 25;
    if (frame.size.height < 25)    frame.size.height = 25;
    
    self = [super initWithFrame:frame];
    if (self) {
        globalInset = 12;
        
        self.backgroundColor = [UIColor clearColor];
        [self setAutoresizingMask:(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)];
        
        labelTextField = [[UITextField alloc] initWithFrame:CGRectInset(self.bounds, globalInset, globalInset)];
        [labelTextField setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
        [labelTextField setClipsToBounds:YES];
        labelTextField.delegate = self;
        labelTextField.backgroundColor = [UIColor clearColor];
        labelTextField.tintColor = [UIColor redColor];
        labelTextField.textColor = [UIColor whiteColor];
        labelTextField.text = @"";
        
        
        [self insertSubview:labelTextField atIndex:0];
        
        closeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, globalInset * 2, globalInset * 2)];
        [closeView setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin)];
        closeView.backgroundColor = [UIColor whiteColor];
        closeView.layer.cornerRadius = globalInset - 5;
        closeView.userInteractionEnabled = YES;
        [self addSubview:closeView];
        
        UIPanGestureRecognizer *moveGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveGesture:)];
        [self addGestureRecognizer:moveGesture];
        
        UITapGestureRecognizer *singleTapShowHide = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapped:)];
        [self addGestureRecognizer:singleTapShowHide];
        
        UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTap:)];
        [closeView addGestureRecognizer:closeTap];
        
        [moveGesture requireGestureRecognizerToFail:closeTap];
        
        [self setEnableMoveRestriction:NO];
        [self setEnableClose:YES];
        [self setCloseImage:[UIImage imageNamed:@"closeIMG.jpg"]];
        
        [self showEditingHandles];
        [labelTextField becomeFirstResponder];
    }
    return self;
}

#pragma BUTTONS

- (void)setEnableClose:(BOOL)value
{
    enableClose = value;
    [closeView setHidden:!enableClose];
    [closeView setUserInteractionEnabled:enableClose];
}

- (void)setCloseImage:(UIImage *)image
{
    closeImage = image;
    [closeView setImage:closeImage];
}


#pragma TEXT

- (void)setFontName:(NSString *)name
{
    fontName = name;
    labelTextField.font = [UIFont fontWithName:fontName size:fontSize];
}

- (void)setFontSize:(CGFloat)size
{
    fontSize = size;
    labelTextField.font = [UIFont fontWithName:fontName size:fontSize];
}

- (void)setTextColor:(UIColor *)color
{
    textColor = color;
    labelTextField.textColor = textColor;
}

- (void)setTextAlpha:(CGFloat)alpha
{
    labelTextField.alpha = alpha;
}

- (CGFloat)textAlpha
{
    return labelTextField.alpha;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    _attributedPlaceholder = attributedPlaceholder;
    //    [labelTextField setAttributedText:attributedPlaceholder];
    [labelTextField setAttributedPlaceholder:attributedPlaceholder];
}



#pragma BOUNDS


- (void)hideEditingHandles
{
    lastTouchedView = nil;
    
    isShowingEditingHandles = NO;
    
    if (enableClose)       closeView.hidden = YES;
    
    [labelTextField resignFirstResponder];
    
    [self refresh];
    
    if([delegate respondsToSelector:@selector(labelViewDidHideEditingHandles:)]) {
        [delegate labelViewDidHideEditingHandles:self];
    }
}

- (void)showEditingHandles
{
    [lastTouchedView hideEditingHandles];
    
    isShowingEditingHandles = YES;
    
    lastTouchedView = self;
    
    if (enableClose)       closeView.hidden = NO;
    
    [self refresh];
    
    if([delegate respondsToSelector:@selector(labelViewDidShowEditingHandles:)]) {
        [delegate labelViewDidShowEditingHandles:self];
    }
}

#pragma mark GESTURES

- (void)contentTapped:(UITapGestureRecognizer*)tapGesture
{
    if (isShowingEditingHandles) {
        [self hideEditingHandles];
        [self.superview bringSubviewToFront:self];
    } else {
        [self showEditingHandles];
    }
}

- (void)closeTap:(UITapGestureRecognizer *)recognizer
{
    [self removeFromSuperview];
    
    if([delegate respondsToSelector:@selector(labelViewDidClose:)]) {
        [delegate labelViewDidClose:self];
    }
}

- (CGPoint)estimatedCenter  //get mid point
{
    CGPoint newCenter;
    CGFloat newCenterX = beginningCenter.x + (touchLocation.x - beginningPoint.x);
    CGFloat newCenterY = beginningCenter.y + (touchLocation.y - beginningPoint.y);
    if (enableMoveRestriction) {
        if (!(newCenterX - 0.5 * CGRectGetWidth(self.frame) > 0 &&
              newCenterX + 0.5 * CGRectGetWidth(self.frame) < CGRectGetWidth(self.superview.bounds))) {
            newCenterX = self.center.x;
        }
        if (!(newCenterY - 0.5 * CGRectGetHeight(self.frame) > 0 &&
              newCenterY + 0.5 * CGRectGetHeight(self.frame) < CGRectGetHeight(self.superview.bounds))) {
            newCenterY = self.center.y;
        }
        newCenter = CGPointMake(newCenterX, newCenterY);
    } else {
        newCenter = CGPointMake(newCenterX, newCenterY);
    }
    return newCenter;
}


-(void)moveGesture:(UIPanGestureRecognizer *)recognizer
{
    if (!isShowingEditingHandles) {
        [self showEditingHandles];
    }
    touchLocation = [recognizer locationInView:self.superview];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        beginningPoint = touchLocation;
        beginningCenter = self.center;
        
        [self setCenter:[self estimatedCenter]];
        beginBounds = self.bounds;
        
        if([delegate respondsToSelector:@selector(labelViewDidBeginEditing:)]) {
            [delegate labelViewDidBeginEditing:self];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self setCenter:[self estimatedCenter]];
        
        if([delegate respondsToSelector:@selector(labelViewDidChangeEditing:)]) {
            [delegate labelViewDidChangeEditing:self];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setCenter:[self estimatedCenter]];
        
        if([delegate respondsToSelector:@selector(labelViewDidEndEditing:)]) {
            [delegate labelViewDidEndEditing:self];
        }
    }
}

#pragma mark TEXTFIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (isShowingEditingHandles) {
        return YES;
    }
    [self contentTapped:nil];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([delegate respondsToSelector:@selector(labelViewDidStartEditing:)]) {
        [delegate labelViewDidStartEditing:self];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!isShowingEditingHandles) {
        [self showEditingHandles];
    }
    return YES;
}

@end
