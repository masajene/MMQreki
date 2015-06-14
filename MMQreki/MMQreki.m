//
//  MMQreki.m
//
//  Created by MasashiMizuno on 2014/11/30.
//  Copyright (c) 2014年 水野 真史. All rights reserved.
//

#import "MMQreki.h"

static const NSInteger minDate = 1999;

@interface MMQreki ()

@property (strong, nonatomic) NSMutableArray *replaceTable; // o2ntbl
@property (strong, nonatomic) NSMutableArray *maxDays; // nmdays
@property (strong, nonatomic) NSMutableArray *oldTable; // otbl

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation MMQreki

#pragma mark -------------------------------------------------------
#pragma mark - initialize
#pragma mark -------------------------------------------------------

- (void)initializeTable {
    
    self.replaceTable = [@[@[@611,@2350],
                       @[@468,@3222],
                       @[@316,@7317],
                       @[@559,@3402],
                       @[@416,@3493],
                       @[@288,@2901],
                       @[@520,@1388],
                       @[@384,@5467],
                       @[@637,@605],
                       @[@494,@2349],
                       @[@343,@6443],
                       @[@585,@2709],
                       @[@442,@2890],
                       @[@302,@5962],
                       @[@533,@2901],
                       @[@412,@2741],
                       @[@650,@1210],
                       @[@507,@2651],
                       @[@369,@2647],
                       @[@611,@1323],
                       @[@468,@2709],
                       @[@329,@5781],
                       @[@559,@1706],
                       @[@416,@2773],
                       @[@288,@2741],
                       @[@533,@1206],
                       @[@383,@5294],
                       @[@624,@2647],
                       @[@494,@1319],
                       @[@356,@3366],
                       @[@572,@3475],
                       @[@442,@1450]] mutableCopy];
    
    self.maxDays = [@[@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31] mutableCopy];
    self.oldTable = [@[@14] mutableCopy];
    
    if (!self.dateFormatter) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy/MM/dd";
    }
}

#pragma mark -------------------------------------------------------
#pragma mark - Public Methods
#pragma mark -------------------------------------------------------

- (NSString *)getOldToNewCalender:(NSDate *)oldDate {
    
    [self initializeTable];
    
    NSString *oldDateString = [self.dateFormatter stringFromDate:oldDate];
    
    NSNumber *newYear, *newMonth, *newDay, *tmp, *dofNewYear;
    NSNumber *oyy = @([[oldDateString substringToIndex:4] intValue]);
    NSNumber *omm = @([[oldDateString substringWithRange:NSMakeRange(5, 2)] intValue]);
    NSNumber *odd = @([[oldDateString substringFromIndex:8] intValue]);

    [self tableExpand:oyy];

    dofNewYear = @-1;
    for (int i = 0; i <= 13; i++) {
        if ([self.oldTable[i][1] isEqualToNumber:omm]) {
            dofNewYear = @([self.oldTable[i][0] integerValue] + [odd intValue] - 1);
            break;
        }
    }

    if ([dofNewYear intValue] < 0) {
        return nil;
    }

    newYear = oyy;
    tmp = @(365 + [[self leapYear:newYear] intValue]);
    if ([dofNewYear intValue] > [tmp intValue]) {
        dofNewYear = @([dofNewYear intValue] - [tmp intValue]);
        newYear = @([newYear intValue]+1);
    }

    newDay = @-1;
    for (int nmm = 12; nmm >= 1; nmm--) {
        tmp = [self numberDays:newMonth month:newMonth day:@1];
        if ([dofNewYear intValue] >= [tmp intValue]) {
            newDay = @([dofNewYear intValue] - [tmp intValue] + 1);
            break;
        }
    }

    if ([newDay intValue] < 0) {
        return nil;
    }
    return [NSString stringWithFormat:@"%@/%@/%@", newYear, newMonth, newDay];
}

- (NSString *)getNewToOldCalender:(NSDate *)newDate {
    
    [self initializeTable];
    
    NSString *newDateString = [self.dateFormatter stringFromDate:newDate];
    
    NSNumber *oyy, *omm, *odd, *uruu, *DofNyy;
    NSNumber *nyy = @([[newDateString substringToIndex:4] intValue]);
    NSNumber *nmm = @([[newDateString substringWithRange:NSMakeRange(5, 2)] intValue]);
    NSNumber *ndd = @([[newDateString substringFromIndex:8] intValue]);
    
    DofNyy = [self numberDays:nyy month:nmm day:ndd];
    oyy = nyy;
    [self tableExpand:oyy];
    
    if ([DofNyy intValue] < [self.oldTable[0][0] intValue]) {
        oyy = @([oyy intValue] -1);
        DofNyy = @([DofNyy intValue] + 365 + [[self leapYear:oyy] intValue]);
        [self tableExpand:oyy];
    }
    
    for (int i = 12; i >= 0; i--) {
        if (![self.oldTable[i][1] isEqualToNumber:@0]) {
            if ([self.oldTable[i][0] intValue] <= [DofNyy intValue]) {
                omm = self.oldTable[i][1];
                odd = @([DofNyy intValue] - [self.oldTable[i][0] intValue] + 1);
                break;
            }
        }
    }
    
    if ([omm intValue] < 0) {
        uruu = @1;
        omm = @([omm intValue] - [omm intValue]);
    } else {
        uruu = @0;
    }
#pragma unused(uruu)
    return [NSString stringWithFormat:@"%@/%@/%@", oyy, omm, odd];
}

- (NSString *)getRokuyo:(NSDate *)newDate {
    
    NSArray *rokuyo = @[@"大安",@"赤口",@"先勝",@"友引",@"先負",@"仏滅"];
    
    NSString *oldCal = [self getNewToOldCalender:newDate];
    NSArray *sepCal = [oldCal componentsSeparatedByString:@"/"];
    NSInteger oldMonth = [sepCal[1] intValue];
    NSInteger oldDay = [sepCal[2] intValue];
    
    NSInteger md = oldMonth + oldDay;
    float index = md % 6;
    
    NSString *roku = rokuyo[(int)index];
    
    return roku;
}

#pragma mark -------------------------------------------------------
#pragma mark - Private Methods
#pragma mark -------------------------------------------------------

- (NSNumber *)leapYear:(NSNumber *)year {
    NSInteger ans = 0;
    if (([year intValue] % 4) == 0) ans = 1;
    if (([year intValue] % 100) == 0) ans = 0;
    if (([year intValue] % 400) == 0) ans = 1;
    return @(ans);
}

- (NSNumber *)numberDays:(NSNumber *)year month:(NSNumber *)month day:(NSNumber *)day {

    self.maxDays[1] = @(28 + [[self leapYear:year] intValue]);
    
    NSNumber *days = day;
    for (int i = 1; i < [month intValue]; i++) {
        days = @([days intValue] + [self.maxDays[i-1] intValue]);
    }
    return days;
}

- (void)tableExpand:(NSNumber *)year {

    NSNumber *ommax, *days, *uruu, *bit;
    
    days = self.replaceTable[[year intValue] - minDate][0];
    bit = self.replaceTable[[year intValue] - minDate][1];
    uruu = @([days intValue] % 13);
    days = @(floor([days intValue] / 13 + 0.001));
    
    self.oldTable[0] = @[days, @1];
    if ([uruu isEqualToNumber:@0]) {
        bit = @([bit intValue] * 2);
        ommax = @12;
    } else {
        ommax = @13;
    }
    for (int i = 1; i <= [ommax intValue]; i++) {
        self.oldTable[i] = [@[@([self.oldTable[i-1][0] intValue]+29), @(i+1)] mutableCopy];
        if ([bit intValue] >= 4096) {
            NSInteger _tmp = [self.oldTable[i][0] intValue];
            self.oldTable[i][0] = @(_tmp+1);
        }
        bit = @(([bit intValue] % 4096) * 2);
    }
    self.oldTable[[ommax intValue]][1] = @1;
    if ([ommax intValue] > 12) {
        for (int i = [uruu intValue] + 1; i < 13; i++) {
            self.oldTable[i][1] = @(i);
        }
        self.oldTable[[uruu intValue]][1] = @([self.oldTable[[uruu intValue]][1] intValue] - [uruu intValue]);
    } else {
        self.oldTable[13] = @[@0,@0];
    }
}

@end
