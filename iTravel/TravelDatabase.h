//
//  TravelDatabase.h
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelTrip.h"
#import "TripDay.h"

@interface TravelDatabase : NSObject

+ (instancetype) sharedModel;

- (void) reloadTripDay: (TripDay*) inTrip;

- (NSArray*) getAllTripsFromDatabase;
- (PFObject*) getTripForName: (NSString*) inName;
- (NSMutableArray*) getAllTripDaysForTrip: (NSString*) inTrip;
- (NSArray*) getAllTripDayObjectsForTrip: (PFObject*) inTrip;
- (TripDay*) getTripDayDetail: (TravelTrip*) parentTrip withDate: (NSString*) inDate;

- (NSArray*) getSightsForTripDay: (PFObject*) inDay;
- (NSMutableArray*) getImagesForTripDay: (PFObject*) inTrip;

- (void) updateTripDaySightCost: (PFObject*) inTrip withValue: (float) inCost;


- (void) saveNewTrip: (TravelTrip*) inTrip;
- (void) saveNewTripDays: (NSMutableArray*) inDays forTrip: (PFObject*) inTrip;
- (void) saveImage: (UIImage*) image forTripDay: (PFObject*) inTrip;

@end
