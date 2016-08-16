//
//  CommonMode.h
//  Foscam
//
//  Created by software2
//  Copyright (c) 2016年 Foscam. All rights reserved.
//

#import "CommonMode.h"


@implementation CommonMode
//xml 数据解析
+(NSString *)XmlParse:(NSString *)dataString{

    NSRange rangeStart;
    rangeStart = [dataString rangeOfString:@"<result>"];
    if (rangeStart.location != NSNotFound) {
        NSRange rangeEnd;
        rangeEnd = [dataString rangeOfString:@"</result>"];
        if (rangeEnd.location != NSNotFound) {
            NSRange resRange =NSMakeRange(rangeStart.location +rangeStart.length, rangeEnd.location -(rangeStart.location+rangeStart.length));
            NSString *resString =[dataString substringWithRange:resRange];
            if (resString ==nil) {
                return @"error";
            }else
                return resString;
        }else{
            NSLog(@"Not Found2");
            return @"error";
        }
        
    }else{
        NSLog(@"Not Found");
        return @"error";
    }
    return @"error";
}

//字符宽度
+ (CGFloat)getStringWidthSize:(NSString *)text andFontOfSize:(CGFloat)sizeFont{
    
    CGSize sizeText = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:sizeFont]}];
    CGSize statuseStrSize = CGSizeMake(ceilf(sizeText.width), ceilf(sizeText.height));
    
    return statuseStrSize.width;

}
//字符所占行数
+ (int)getLineNumber:(NSString *)text andFontOfSize:(CGFloat)sizeFont andWidth:(CGFloat)widthSize{
    
    CGSize sizeLabel = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:sizeFont]}];
    CGSize statuseStrSize = CGSizeMake(ceilf(sizeLabel.width), ceilf(sizeLabel.height));
    return statuseStrSize.width / widthSize +1;
}

//Unicode encode
+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (NSString *)CFBridgingRelease
    (CFURLCreateStringByAddingPercentEscapes
     (kCFAllocatorDefault,
      (CFStringRef)input,
      NULL,
      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
      kCFStringEncodingUTF8));
    return outputStr;
    
}
//Unicode decode
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end
