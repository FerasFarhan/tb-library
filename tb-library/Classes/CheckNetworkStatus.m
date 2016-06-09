//
//  CheckNetworkStatus.m
//  AAG_Event
//
//  Created by Techband on 10/29/11.
//  Copyright 2011 Springfield. All rights reserved.
//

#import "CheckNetworkStatus.h"
#import "Reachability.h"

@implementation CheckNetworkStatus

+(BOOL)checkIfNetworkAvailable
{
	BOOL available=NO;
   Reachability *reach = [Reachability reachabilityForInternetConnection];
   NetworkStatus internetStatus = [reach currentReachabilityStatus];
   switch (internetStatus) {
	    case NotReachable:
		      available=NO;
			break;
		
	default:
		available=YES;
		break;
   }	

	return available;
} 

+(NSString*)checkConnectionType
{
    NSString *connection;
	
	Reachability *reach = [Reachability reachabilityForInternetConnection];
	NetworkStatus internetStatus = [reach currentReachabilityStatus];
	switch (internetStatus) {
		case NotReachable:
			connection = @"NotReachable";
			break;
		case    ReachableViaWiFi:
			connection = @"ReachableViaWiFi";
			break;
			
		case    ReachableViaWWAN:
			connection = @"ReachableViaWWAN";
			
			break;
			
		default:
			break;
	}    
	
	return connection;
}


@end
