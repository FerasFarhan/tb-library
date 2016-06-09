//
//  UIFont+FontAwesome.m
//  FontAwesome-iOS Demo
//
//  Created by Alex Usbergo on 1/16/13.
//  Copyright (c) 2013 Alex Usbergo. All rights reserved.
//

#import "UIFont+FontAwesome.h"
#import "NSString+FontAwesome.h"

@implementation UIFont (FontAwesome)

#pragma mark - Public API
+ (UIFont*)fontAwesomeFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:kFontAwesomeFamilyName size:size];
}

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net