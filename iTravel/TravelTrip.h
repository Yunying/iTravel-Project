//
//  TravelTrip.h
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "TripDay.h"

@interface TravelTrip : NSObject

@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* startDate;
@property(strong, nonatomic) NSString* endDate;
@property(strong, nonatomic) NSString* budget;
@property(nonatomic) float currentCost;
@property(nonatomic) float lodgingCost;
@property(strong, nonatomic) PFObject* parseObj;

- (instancetype) constructFromPFObject: (PFObject*) input;
- (NSString*) getDateRange;
- (void) generateTripDays;
- (NSInteger) numberOfTripDays;
- (NSMutableArray*) tripDays;
- (void) setTripDays: (NSMutableArray*) inDays;
- (TripDay*) tripDayAtIndex: (NSInteger) inIndex;
- (float) getCurrentCost;

@end
