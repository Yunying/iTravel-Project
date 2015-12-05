//
//  TripDay.h
//  iTravel
//
//  Created by YUNYING TU on 12/3/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface TripDay : NSObject

@property(strong, nonatomic) NSString* tripDate;
@property(nonatomic) float currentCost;
@property(strong, nonatomic) PFObject* parseObj;


- (instancetype) constructFromPFObject: (PFObject*) input;

@end
