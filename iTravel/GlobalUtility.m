//
//  GlobalUtility.m
//  iTravel
//
//  Created by YUNYING TU on 12/3/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "GlobalUtility.h"


@implementation GlobalUtility

+ (instancetype) sharedModel {
    static GlobalUtility *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (void) styleTextField: (UITextField*) field {
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    field.layer.borderWidth = 1.0f;
    field.layer.cornerRadius = 10.0f;
    field.layer.masksToBounds = YES;
    field.leftView = leftView;
    field.leftViewMode = UITextFieldViewModeAlways;
}

- (BOOL) checkDateInRange: (NSString*) inDate forStartDate: (NSString*) startDate forEndDate: (NSString*) endDate {
    if ([inDate compare:startDate] == NSOrderedAscending){
        return false;
    }
    
    if ([inDate compare:endDate] == NSOrderedDescending || [inDate compare:endDate] == NSOrderedSame){
        return false;
    }
    
    
    return true;
}

- (NSString*) formatDateStringWithSlash: (NSString*) inDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSDate* date = [dateFormatter dateFromString:inDate];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;

}

- (NSString*) formatDateStringWithoutYear: (NSString*) inDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSDate* date = [dateFormatter dateFromString:inDate];
    [dateFormatter setDateFormat:@"MM/dd"];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

@end
