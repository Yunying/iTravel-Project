//
//  NewSightViewController.h
//  iTravel
//
//  Created by YUNYING TU on 12/5/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TripDay.h"
#import "TripDayTableViewController.h"

@interface NewSightViewController : UIViewController

@property(strong, nonatomic) TripDay* tripDay;
@property(weak, nonatomic) TripDayTableViewController* parentView;

@end
