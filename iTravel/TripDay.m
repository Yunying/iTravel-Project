//
//  TripDay.m
//  iTravel
//
//  Created by YUNYING TU on 12/3/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "TripDay.h"
#import "Constants.h"

@implementation TripDay

- (instancetype) constructFromPFObject: (PFObject*) input {
    TripDay* trip = [[TripDay alloc]init];
    trip.tripDate = input[kDate];
    if (input[kTripDayCost]){
        trip.currentCost = [input[kTripDayCost] floatValue];
    } else {
        trip.currentCost = 0.0f;
    }
    trip.parseObj = input;
    return trip;
}

@end
