//
//  CommonMode.h
//  Foscam
//
//  Created by software2
//  Copyright (c) 2016年 Foscam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    systemFont =0,
}FontName;

@interface CommonMode : NSObject


+ (NSString *)XmlParse:(NSString *)dataString;


+ (CGFloat)getStringWidthSize:(NSString *)text andFontOfSize:(CGFloat)sizeFont;


+ (int)getLineNumber:(NSString *)text andFontOfSize:(CGFloat)sizeFont andWidth:(CGFloat)widthSize;

+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
    
@end
