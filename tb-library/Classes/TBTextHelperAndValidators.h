//
//  TextHelperAndValidators.h
//  uniApp
//
//  Created by Techband on 3/11/14.
//  Copyright (c) 2016 Techband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end

@interface TBTextHelperAndValidators : NSObject

+(void) hideForTextFields:(NSArray*) fieldsArray;

+(NSString *) decodeFromPercentEscapeString:(NSString *) string;
+(NSString *) stringByStrippingHTML:(NSString*) _string;
+(NSString *) stringByRemoveUneededSpaces:(NSString*) _string;
+(NSString *) correctTimeStamp:(NSString*)ts;
+(NSString *) stringByDecodingXMLEntities:(NSString *) stringToDecode;
+(NSString *) stringByClearingEverything:(NSString *) string;
+(NSString *) trimEnd:(NSString*)string;

+(CGFloat) measureHeightOfUITextView:(UITextView *)textView;
+(CGFloat) findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;
+(CGFloat) textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width;

+(NSMutableAttributedString *) attributedStringWithBody:(NSString *) body;

+(BOOL) emailValidation:(NSString *) emailStr;
+(BOOL) validateTextFields:(NSArray*) fieldsArray;

//+(NSString *) freeTextTemplate:(NSString *) templateName withExtention:(NSString *) extention;

+(id) jsonFromString:(NSString *) string;

//+ (NSString *) deviceIdentifier;

//+ (NSString *) stringFromHex:(NSString *)str;
//+ (NSString *) stringToHex:(NSString *)str;

@end
