//
//  GlobalUtility.h
//  iTravel
//
//  Created by YUNYING TU on 12/3/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalUtility : NSObject

+ (instancetype) sharedModel;

- (void) styleTextField: (UITextField*) field;
- (NSString*) formatDateStringWithSlash: (NSString*) inDate;
- (NSString*) formatDateStringWithoutYear: (NSString*) inDate;
- (BOOL) checkDateInRange: (NSDate*) inDate forStartDate: (NSDate*) startDate
               forEndDate: (NSDate*) endDate;

@end
