//
//  MMQreki.h
//  appme
//
//  Created by MasashiMizuno on 2014/11/30.
//  Copyright (c) 2014年 水野 真史. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMQreki : NSObject

- (NSString *)getOldToNewCalender:(NSString *)oldDate;
- (NSString *)getNewToOldCalender:(NSString *)newDate;
- (NSString *)getRokuyo:(NSString *)newYear;

@end
