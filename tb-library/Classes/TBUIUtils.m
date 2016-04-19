//
//  UIUtils.m
//  YAAB Library
//
//  Created by Techband on 9/21/12.
//  Copyright (c) 2014 YAAB. All rights reserved.
//

#import "TBUIUtils.h"

#define BTN_CLOSE @"Close"

@implementation TBUIUtils

// This is the singelton instance method
+ (TBUIUtils*)sharedInstance {
    static TBUIUtils* instance = nil;
    if (instance == nil) {
        instance = [[TBUIUtils alloc] init];
    }
    
    return instance;
}

- (UIImage*)imageFromView:(UIView*)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

- (void)customTitleForNavigationController:(UIViewController*)parentController
                                  withFont:(UIFont*)font {
    UINavigationController* controller = parentController.navigationController;
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, controller.navigationBar.bounds.size.height);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [[VLThemeManager sharedInstance] youtubeBarTheme].textColour;
    label.text = parentController.navigationItem.title;
    parentController.navigationItem.titleView = label;
}

- (void)setImage:(UIImage*)imageObject andImageTag:(int)tag withTitle:(NSString*)title andTitleTag:(int)titleTag forBarInController:(UIViewController*)controller {
    [controller.navigationController.navigationBar setBackgroundImage:imageObject forBarMetrics:UIBarMetricsDefault];
    
//    // Set the title view
//    UIView* oldTitleView = [controller.navigationController.navigationBar viewWithTag:titleTag];
//    if ((oldTitleView != nil) && ([oldTitleView isKindOfClass:[UILabel class]])) {
//        [oldTitleView removeFromSuperview];
//    }
//    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, controller.navigationController.navigationBar.frame.size.height)];
//    titleLabel.text = title;
//    titleLabel.tag = titleTag;
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = [UIFont systemFontOfSize:20.0f];
//    [controller.navigationController.navigationBar addSubview:titleLabel];
//    
//    // Bring the left and right buttons to front
//    UIView* subView = [controller.navigationItem.rightBarButtonItem valueForKey:@"view"];
//    [controller.navigationController.navigationBar bringSubviewToFront:subView];
//    
//    subView = [controller.navigationItem.leftBarButtonItem valueForKey:@"view"];
//    [controller.navigationController.navigationBar bringSubviewToFront:subView];
    
}

#pragma mark -
#pragma mark Alerts Methods

- (void)showSimpleAlertWithTitle:(NSString*)title text:(NSString*)text {
    dispatch_async( dispatch_get_main_queue(), ^{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:text
                                                       delegate:nil
                                              cancelButtonTitle:BTN_CLOSE
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
}

#pragma mark -
#pragma mark WebView Methods

- (float)navigationBarHeight {
    UIWindow* window = [UIApplication sharedApplication].windows[0];
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* rootItem = (UINavigationController*)window.rootViewController;
        return rootItem.navigationBar.frame.size.height;
    }
    
    return 0.0f;
}

- (float)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (float)navigationAndStatusHeight {
    return [self navigationBarHeight] + [self statusBarHeight];
}


static inline double radians (double degrees) {return degrees * M_PI/90;}
- (UIImage *)rotateImage:(UIImage*) src andUIImageOrientation:(UIImageOrientation)orientation
{
    UIGraphicsBeginImageContext(src.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, radians(90));
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, radians(-90));
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, radians(90));
    }
    
    [src drawAtPoint:CGPointMake(0, 0)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat completion:(Handler)handler
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations  ];
    rotationAnimation.duration = 1.5f;
    rotationAnimation.cumulative = NO;
    rotationAnimation.repeatCount = repeat;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
 
    
    // Delay execution of my block for 10 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
         handler();
    });
}

-(UIViewController*) getViewControllerFromMainStoryboardWithId:(NSString*) storyboardId {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [mainStoryboard instantiateViewControllerWithIdentifier:storyboardId];
}

@end
