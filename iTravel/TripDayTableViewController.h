//
//  TripDayTableViewController.h
//  iTravel
//
//  Created by YUNYING TU on 12/4/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripDay.h"
#import <Parse/Parse.h>

@interface TripDayTableViewController : UITableViewController

@property(strong, nonatomic) NSString* tripName;
@property(strong, nonatomic) TripDay* tripDay;
@property(strong, nonatomic) PFObject* tripDayObj;
@property(nonatomic) bool endpoint;

@end
