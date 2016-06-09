//
//  TwitterRegistrationView.h
//  manoushe
//
//  Created by Feras Farhan on 9/6/15.
//  Copyright (c) 2015 Feras Farhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterRegistrationView;

@protocol TwitterRegistrationViewDelegate <NSObject>

- (void) twitterRegistrationViewCancelButtonPressed:(TwitterRegistrationView *)sender;
- (void) twitterRegistrationViewRegisterButtonPressed:(TwitterRegistrationView *)sender;

@end

@interface TwitterRegistrationView : UIView

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) NSObject <TwitterRegistrationViewDelegate> *delegate;

@end
