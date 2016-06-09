//
//  TwitterRegistrationView.m
//  manoushe
//
//  Created by Feras Farhan on 9/6/15.
//  Copyright (c) 2015 Feras Farhan. All rights reserved.
//

#import "TwitterRegistrationView.h"

@implementation TwitterRegistrationView

@synthesize delegate;

- (IBAction)cancelButtonPressed:(id)sender {
    [delegate twitterRegistrationViewCancelButtonPressed:self];
}
- (IBAction)registerButtonPressed:(id)sender {
    [delegate twitterRegistrationViewRegisterButtonPressed:self];
}

@end
