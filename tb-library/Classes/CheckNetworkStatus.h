//
//  CheckNetworkStatus.h
//  AAG_Event
//
//  Created by Techband on 10/29/11.
//  Copyright 2011 Springfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface CheckNetworkStatus:NSObject

+(BOOL)checkIfNetworkAvailable;
+(NSString*)checkConnectionType;

@end
