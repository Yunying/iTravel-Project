//
//  TravelTrip.m
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "TravelTrip.h"
#import "Constants.h"
#import "TripDay.h"

@interface TravelTrip()

@property(strong, nonatomic, getter=tripDays) NSMutableArray* tripDays;

@end

@implementation TravelTrip

- (instancetype)init
{
    self = [super init];
    if (self){
        _tripDays = [[NSMutableArray alloc]init];
        _currentCost = 0.0f;
    }
    return self;
}

- (NSString*) getDateRange {
    NSString* result = [NSString stringWithFormat:@"%@ - %@", _startDate, _endDate];
    
    return result;
}

- (instancetype) constructFromPFObject: (PFObject*) input {
    TravelTrip* trip = [[TravelTrip alloc]init];
    trip.name = input[kTripName];
    trip.startDate = input[kTripStartDate];
    trip.endDate = input[kTripEndDate];
    trip.budget = input[kTripBudget];
    
    return trip;
}

- (void) generateTripDays{
    if (![_startDate isEqual:@""] && ![_startDate isEqual:@""]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        NSDate* start = [dateFormatter dateFromString:_startDate];
        NSDate* end = [dateFormatter dateFromString: _endDate];
        NSTimeInterval secondsBetween = [end timeIntervalSinceDate:start];
        
        int numberOfDays = secondsBetween / 86400 + 1;
        
        if (numberOfDays < kGenerateDaysThreshold){
            for (int i=0; i<numberOfDays; i++){
                TripDay* newTripDay = [TripDay alloc];
                NSDate *newDate = [start dateByAddingTimeInterval:86400*i];
                newTripDay.tripDate = [dateFormatter stringFromDate:newDate];
                newTripDay.currentCost = 0.0f;
                [_tripDays addObject:newTripDay];
            }
        }
        
        NSLog(@"Generated Trip Days: %lu", _tripDays.count);
        
    }
}

- (NSInteger) numberOfTripDays{
    return [_tripDays count];
}

- (void) setTripDays: (NSMutableArray*) inDays {
    _tripDays = inDays;
}

- (TripDay*) tripDayAtIndex: (NSInteger) inIndex {
    return (TripDay*)(_tripDays[inIndex]);
}

- (float) getCurrentCost {
    float result = 0.0f;
    for (int i=0; i<_tripDays.count; i++){
        TripDay* day = (TripDay*)_tripDays[i];
        result += day.currentCost;
    }
    return result;
}



@end
