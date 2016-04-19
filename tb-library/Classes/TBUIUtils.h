//
//  UIUtils.h
//  YAAB Library
//
//  Created by Techband on 9/21/12.
//  Copyright (c) 2014 YAAB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Handler)();

@interface TBUIUtils : NSObject

// This is the singelton instance method
+ (TBUIUtils*) sharedInstance;

- (UIImage*)imageFromView:(UIView*)view;

- (void)setImage:(UIImage*)imageObject andImageTag:(int)tag withTitle:(NSString*)title andTitleTag:(int)titleTag forBarInController:(UIViewController*)controller;

- (void)customTitleForNavigationController:(UIViewController*)parentController
                                  withFont:(UIFont*)font;

- (float)navigationBarHeight;
- (float)statusBarHeight;
- (float)navigationAndStatusHeight;

#pragma mark -
#pragma mark Alerts Methods

- (void) showSimpleAlertWithTitle:(NSString*)title text:(NSString*)text;

#pragma mark -
#pragma mark WebView Methods

- (UIImage *)rotateImage:(UIImage*) src andUIImageOrientation:(UIImageOrientation)orientation;

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat completion:(Handler)handler;

-(UIViewController*) getViewControllerFromMainStoryboardWithId:(NSString*) storyboardId;

@end
