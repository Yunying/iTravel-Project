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
#import <Parse/Parse.h>

@interface TravelDatabase : NSObject

@property (strong, nonatomic) PFObject* currentUser;

+ (instancetype) sharedModel;

- (void) reloadTripDay: (TripDay*) inTrip;

- (NSArray*) getAllTripsFromDatabase;
- (NSArray*) getAllTripsFromDatabaseForUser: (PFObject*) inUser;


- (PFObject*) getTripForName: (NSString*) inName;
- (NSMutableArray*) getAllTripDaysForTrip: (NSString*) inTrip;
- (NSArray*) getAllTripDayObjectsForTrip: (PFObject*) inTrip;
- (TripDay*) getTripDayDetail: (TravelTrip*) parentTrip withDate: (NSString*) inDate;
- (PFObject*) getImageObjectForFile: (PFFile*) inFile;
- (PFObject*) getUser: (NSString*)username withPassword: (NSString*) password;

- (NSArray*) getSightsForTripDay: (PFObject*) inDay;
- (NSArray*) getThingsForTripDay: (PFObject*) inDay;
- (NSArray*) getSightsForTrip: (NSArray*) inTrip;
- (NSArray*) getThingsForTrip: (NSArray*) inTrip;

- (NSMutableArray*) getImagesForTripDay: (PFObject*) inTrip;

- (void) updateTripDaySightCost: (PFObject*) inTrip withValue: (float) inCost;


- (void) saveNewTrip: (TravelTrip*) inTrip;
- (void) saveNewTripDays: (NSMutableArray*) inDays forTrip: (PFObject*) inTrip;
- (void) saveImage: (UIImage*) image forTripDay: (PFObject*) inTrip;
- (void) saveNewUser: (NSString*) username withPassword: (NSString*) password;


@end
