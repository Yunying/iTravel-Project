//
//  TravelDatabase.h
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelTrip.h"

@interface TravelDatabase : NSObject

+ (instancetype) sharedModel;

- (NSArray*) getAllTripsFromDatabase;
- (PFObject*) getTripForName: (NSString*) inName;
- (NSMutableArray*) getAllTripDaysForTrip: (NSString*) inTrip;
- (void) saveNewTrip: (TravelTrip*) inTrip;
- (void) saveNewTripDays: (NSMutableArray*) inDays forTrip: (PFObject*) inTrip;

@end
