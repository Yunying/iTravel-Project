//
//  TravelDatabase.m
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "TravelDatabase.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "TripDay.h"

@interface TravelDatabase()

@property (strong, nonatomic) NSMutableArray *trips;

@end

@implementation TravelDatabase

+ (instancetype) sharedModel {
    static TravelDatabase *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (NSArray*) getAllTripsFromDatabase {
    PFQuery *query = [PFQuery queryWithClassName:kTripClass];
    NSArray* objects = [query findObjects];
    _trips = [[NSMutableArray alloc] init];
    for (int i=0; i<objects.count; i++){
        TravelTrip* newTrip = [[TravelTrip alloc]constructFromPFObject:objects[i]];
        [_trips addObject:newTrip];
    }
    return _trips;
}

- (PFObject*) getTripForName: (NSString*) inName {
    PFQuery *query = [PFQuery queryWithClassName:kTripClass];
    [query whereKey:kTripName equalTo:inName];
    PFObject* obj = [query getFirstObject];
    return obj;
}

- (NSMutableArray*) getAllTripDaysForTrip: (NSString*) inTrip {
    PFObject* inTripObj = [self getTripForName:inTrip];
    PFQuery *query = [PFQuery queryWithClassName:kTripDayClass];
    [query whereKey:@"parent" equalTo:inTripObj];
    NSArray* result = [query findObjects];
    NSMutableArray* days = [[NSMutableArray alloc]init];
    for (int i=0; i<[result count]; i++){
        TripDay* newTrip = [[TripDay alloc]constructFromPFObject:result[i]];
        newTrip.parentTripObj = inTripObj;
        [days addObject:newTrip];
    }
    return days;
}

- (NSArray*) getAllTripDayObjectsForTrip: (PFObject*) inTrip {
    PFQuery *query = [PFQuery queryWithClassName:kTripDayClass];
    [query whereKey:@"parent" equalTo:inTrip];
    NSArray* result = [query findObjects];
    return result;
}

- (void) saveNewTrip: (TravelTrip*) inTrip{
    PFObject* obj = [PFObject objectWithClassName:kTripClass];
    obj[kTripName] = inTrip.name;
    if (kTripStartDate){
        obj[kTripStartDate] = inTrip.startDate;
    }
    if (kTripEndDate){
        obj[kTripEndDate] = inTrip.endDate;
    }
    if (kTripBudget){
        obj[kTripBudget] = inTrip.budget;

    }
    
    [obj save];
    [self saveNewTripDays:[inTrip tripDays] forTrip:obj];
}

- (void) saveNewTripDays: (NSMutableArray*) inDays forTrip: inTrip{
    
    for (int i=0; i<[inDays count]; i++){
        PFObject* obj = [PFObject objectWithClassName:kTripDayClass];
        obj[kRelatedTrip] = inTrip;
        TripDay* day = (TripDay*)inDays[i];
        obj[kDate] = day.tripDate;
        obj[kTripDayCost] = [NSString stringWithFormat:@"%1.2f", day.currentCost];
        [obj save];
    }
    
}

- (TripDay*) getTripDayDetail: (TravelTrip*) parentTrip withDate: (NSString*) inDate {
    PFQuery *query = [PFQuery queryWithClassName:kTripDayClass];
    [query whereKey:@"parent" equalTo:parentTrip];
    [query whereKey:kDate equalTo:inDate];
    PFObject* obj = [query getFirstObject];
    TripDay* result = [[TripDay alloc]constructFromPFObject:obj];
    return result;
}

- (NSArray*) getSightsForTripDay: (PFObject*) inDay {
    PFQuery *query = [PFQuery queryWithClassName:kSightClass];
    [query whereKey:@"parent" equalTo:inDay];
    NSArray* result = [query findObjects];
    return result;

}

- (void) reloadTripDay: (TripDay*) inTrip {
    PFQuery *query = [PFQuery queryWithClassName:kTripDayClass];
    PFObject* obj = [query getObjectWithId:inTrip.parseObj.objectId];
    inTrip.parseObj = obj;
}

- (void) saveImage: (UIImage*) image forTripDay: (PFObject*) inTrip {
    
    NSData* data = UIImageJPEGRepresentation(image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The image has now been uploaded to Parse. Associate it with a new object
            PFObject* obj = [PFObject objectWithClassName:kImageClass];
            [obj setObject:imageFile forKey:kImageFile];
            obj[kImageParent] = inTrip;
            
            [obj save];
        }
    }];
}

- (NSMutableArray*) getImagesForTripDay: (PFObject*) inTrip {
    PFQuery *query = [PFQuery queryWithClassName:kImageClass];
    [query whereKey:@"parent" equalTo:inTrip];
    NSArray* result = [query findObjects];
    
    NSMutableArray* returnImages = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[result count]; i++){
        PFFile* imageFile = ((PFObject*)result[i])[kImageFile];
        NSData* data = [imageFile getData];
        UIImage *image = [UIImage imageWithData:data];
        [returnImages addObject: image];
    }
    return returnImages;
}

- (void) updateTripDaySightCost: (PFObject*) inTrip withValue: (float) inCost {
    float dayCost = [inTrip[kTripDayCost] floatValue] - inCost;
    float sightCost = [inTrip[kTripDaySightCost] floatValue] - inCost;
    inTrip[kTripDayCost] = [NSString stringWithFormat:@"%1.2f", dayCost];
    inTrip[kTripDaySightCost] = [NSString stringWithFormat:@"%1.2f", sightCost];
    [inTrip save];
}

@end
