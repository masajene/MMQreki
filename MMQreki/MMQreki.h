//
//  MMQreki.h
//
//  Created by MasashiMizuno on 2014/11/30.
//  Copyright (c) 2014年 水野 真史. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMQreki : NSObject

/**
 *  Conversion from the old lunar calendar to the Gregorian calendar
 *
 *  @param oldDate old lunar calendar
 *
 *  @return Gregorian calendar
 */
- (NSString *)getOldToNewCalender:(NSDate *)oldDate;

/**
 *  Conversion from Gregorian calendar to the old lunar calendar
 *
 *  @param newDate Gregorian calendar
 *
 *  @return old lunar calendar
 */
- (NSString *)getNewToOldCalender:(NSDate *)newDate;

/**
 *  Get Rokuyo
 *
 *  @param newDate Gregorian calendar
 *
 *  @return Rokuyo
 */
- (NSString *)getRokuyo:(NSDate *)newDate;

@end
