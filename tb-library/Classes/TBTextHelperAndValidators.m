//
//  TextHelperAndValidators.m
//  uniApp
//
//  Created by Techband on 3/11/14.
//  Copyright (c) 2016 Techband. All rights reserved.
//

#import "TBTextHelperAndValidators.h"

@implementation TBTextHelperAndValidators

+(NSMutableAttributedString *) attributedStringWithBody:(NSString *) body
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithData:[body dataUsingEncoding:NSUnicodeStringEncoding]
                                                   options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                   documentAttributes:nil
                                                   error:nil];
    
    NSString* fontName = [NSString stringWithFormat:@"%@-%@", @"", @""];
    UIFont* font = [UIFont fontWithName:fontName size:14.0];
    [attributedString addAttribute:NSFontAttributeName
                             value:font range:NSMakeRange(0, [attributedString length]-1)];
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle range:NSMakeRange(0, [attributedString length]-1)];
    
    return attributedString;
}

+(NSString*) correctTimeStamp:(NSString*)ts
{
    NSArray *arrSep = [ts componentsSeparatedByString:@","];
    if (arrSep.count > 1)
    {
        NSString *day = [arrSep objectAtIndex:0];
        arrSep = [[arrSep objectAtIndex:1] componentsSeparatedByString:@" "];
        NSMutableString *finalTs = [NSMutableString new];
        for (int counter = 0; counter < arrSep.count; counter++) {
            NSString *component = [arrSep objectAtIndex:counter];
            if (counter == 0)
            {
                NSArray *sep = [component componentsSeparatedByString:@"."];
                if (sep.count > 1)
                {
                    component = [sep objectAtIndex:0];
                }
            }
            
            [finalTs appendString:component];
            [finalTs appendString:@" "];
        }

        ts = [NSString stringWithFormat:@"%@ %@", day,finalTs];
    }
    return ts;
}

+(NSString*) decodeFromPercentEscapeString:(NSString *) string
{
    return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding (NULL, (__bridge CFStringRef) string, CFSTR(""), kCFStringEncodingUTF8);
}

+(BOOL) passwordValidation :(NSString *) passwordStr
{
    /*
     (/^
     (?=.*\d)                //should contain at least one digit
     (?=.*[a-z])             //should contain at least one lower case
     (?=.*[A-Z])             //should contain at least one upper case
     [a-zA-Z0-9]{8,}         //should contain at least 8 from the mentioned characters
     $/)
     */
    NSString *regex = @"/^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:passwordStr];
}

+(BOOL) validateTextFields:(NSArray*) fieldsArray
{
    BOOL isValid = NO;
    for (int i=0; i < [fieldsArray count]; i++) {
        UITextField *tf = (UITextField *) [fieldsArray objectAtIndex:i];
        
        NSString *validateText = [tf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![validateText isEqualToString:@""]) {
            isValid = YES;
        }
        
        else
        {
            isValid = NO;
            break;
        }
    }
    
    return isValid;
}

+(void) hideForTextFields:(NSArray*) fieldsArray
{
    for (int i=0; i < [fieldsArray count]; i++) {
        UITextField *tf = (UITextField *) [fieldsArray objectAtIndex:i];
        [tf resignFirstResponder];
    }
}

+(NSString*)trimEnd:(NSString*)string
{
    NSString *stringTrimmed = string;
    if (![string isKindOfClass:[NSNull class]]) {
        NSString *stringTrimmed = [string stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        stringTrimmed = [stringTrimmed stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    
    return stringTrimmed;
}

+(NSString *) stringByStrippingHTML:(NSString*) _string
{
    NSRange range;
    
    while ((range = [_string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        _string = [_string stringByReplacingCharactersInRange:range withString:@""];
    return _string;
}

+(NSString *) stringByRemoveUneededSpaces:(NSString*) _string
{
    _string = [_string stringByReplacingOccurrencesOfString:@"\\s+"
                                                 withString: @" "
                                                    options:NSRegularExpressionSearch
                                                      range: NSMakeRange(0, _string.length)];
    _string = [_string stringByReplacingOccurrencesOfString:@"\r\n"
                                                 withString: @" "
                                                    options:NSRegularExpressionSearch
                                                      range: NSMakeRange(0, _string.length)];
    return _string;
}

+(NSString *) stringByDecodingXMLEntities:(NSString *) stringToDecode
{
    NSUInteger myLength = [stringToDecode length];
    NSUInteger ampIndex = [stringToDecode rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return stringToDecode;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:stringToDecode];
    
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%C", (unichar)charCode];
                
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                
                //[scanner scanUpToString:@";" intoString:&unknownEntity];
                //[result appendFormat:@"&#%@%@;", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
            }
            
        }
        else {
            NSString *amp;
            [scanner scanString:@"&" intoString:&amp];  //an isolated & symbol
            [result appendString:amp];
            
            /*
             NSString *unknownEntity = @"";
             [scanner scanUpToString:@";" intoString:&unknownEntity];
             NSString *semicolon = @"";
             [scanner scanString:@";" intoString:&semicolon];
             [result appendFormat:@"%@%@", unknownEntity, semicolon];
             NSLog(@"Unsupported XML character entity %@%@", unknownEntity, semicolon);
             */
        }
    }
    while (![scanner isAtEnd]);
    
finish:
    return result;
}

+(CGFloat) measureHeightOfUITextView:(UITextView *)textView
{
    if ([textView respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
    {
        // This is the code for iOS 7. contentSize no longer returns the correct value, so
        // we have to calculate it.
        //
        // This is partly borrowed from HPGrowingTextView, but I've replaced the
        // magic fudge factors with the calculated values (having worked out where
        // they came from)
        
        CGRect frame = textView.bounds;
        
        // Take account of the padding added around the text.
        
        UIEdgeInsets textContainerInsets = textView.textContainerInset;
        UIEdgeInsets contentInsets = textView.contentInset;
        
        CGFloat leftRightPadding = textContainerInsets.left + textContainerInsets.right + textView.textContainer.lineFragmentPadding * 2 + contentInsets.left + contentInsets.right;
        CGFloat topBottomPadding = textContainerInsets.top + textContainerInsets.bottom + contentInsets.top + contentInsets.bottom;
        
        frame.size.width -= leftRightPadding;
        frame.size.height -= topBottomPadding;
        
        NSString *textToMeasure = textView.text;
        if ([textToMeasure hasSuffix:@"\n"])
        {
            textToMeasure = [NSString stringWithFormat:@"%@-", textView.text];
        }
        
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName: textView.font, NSParagraphStyleAttributeName : paragraphStyle };
        
        CGRect size = [textToMeasure boundingRectWithSize:CGSizeMake(CGRectGetWidth(frame), MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:nil];
        
        CGFloat measuredHeight = ceilf(CGRectGetHeight(size) + topBottomPadding);
        return measuredHeight;
    }
    else
    {
        return textView.contentSize.height;
    }
}

+(CGFloat)textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:text];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

+(BOOL) emailValidation :(NSString *) emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL valid=[emailTest evaluateWithObject:emailStr];
    return valid;
}


+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGFloat result = font.pointSize ;
 //   CGFloat width = widthValue;
    if (text) {
      //  CGSize textSize = { width, CGFLOAT_MAX };       //Width and height of text area
        CGSize size;
            CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:font}
                                              context:nil];
            size = CGSizeMake(frame.size.width, frame.size.height+1);
     
        result = MAX(size.height, result); //At least one row
}
    return result;

}

+(NSString *) stringByClearingEverything:(NSString *) string
{
    string = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    string = [string stringByReplacingOccurrencesOfString:@"]" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"[" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" />" withString:@"/>"];
    string = [string stringByReplacingOccurrencesOfString:@"</ " withString:@"</"];
    string = [string stringByReplacingOccurrencesOfString:@"&#8211;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&#8220;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&#8212;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&#8221;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&#8217;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&laquo;" withString:@""];
    
    for (int counter = 0; counter < 20; counter++) {
        string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        string = [string stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    
    string = [self stringByRemoveUneededSpaces:string];
    string = [self stringByStrippingHTML:string];
    return string;
}

//+(NSString *) freeTextTemplate:(NSString *) templateName withExtention:(NSString *) extention
//{
//    NSString *path = [[THFileManager sharedInstance] filePathInBundle:templateName withExtention:extention];
//    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    return content;
//}

+(id) jsonFromString:(NSString *) string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return json;
}

//+ (NSString *) deviceIdentifier {
//    // load unique device ID or generate new one
//    return [MCSMApplicationUUIDKeychainItem applicationUUID];
//}

@end

@interface UIPlaceHolderTextView ()

@property (nonatomic, retain) UILabel *placeHolderLabel;

@end

@implementation UIPlaceHolderTextView

CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.1;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if __has_feature(objc_arc)
#else
    [_placeHolderLabel release]; _placeHolderLabel = nil;
    [_placeholderColor release]; _placeholderColor = nil;
    [_placeholder release]; _placeholder = nil;
    [super dealloc];
#endif
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if([[self text] length] == 0)
        {
            [[self viewWithTag:999] setAlpha:1];
        }
        else
        {
            [[self viewWithTag:999] setAlpha:0];
        }
    }];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if (_placeHolderLabel == nil )
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

+ (NSString *) stringFromHex:(NSString *)str
{
    NSMutableData *stringData = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [str length] / 2; i++) {
        byte_chars[0] = [str characterAtIndex:i*2];
        byte_chars[1] = [str characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1];
    }
    
    return [[NSString alloc] initWithData:stringData encoding:NSASCIIStringEncoding];
}

+ (NSString *) stringToHex:(NSString *)str
{
    NSUInteger len = [str length];
    unichar *chars = malloc(len * sizeof(unichar));
    [str getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    
    return hexString;
}

@end



