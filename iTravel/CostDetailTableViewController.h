//
//  CostDetailTableViewController.h
//  
//
//  Created by YUNYING TU on 12/6/15.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TripDayTableViewController.h"

@interface CostDetailTableViewController : UITableViewController

@property (nonatomic) bool dayType;

@property (strong, nonatomic) PFObject* tripDay;

@property (strong, nonatomic) PFObject* trip;

@property (strong, nonatomic) NSArray* sights;

@property (strong, nonatomic) NSArray* others;

@property (strong, nonatomic) TripDayTableViewController* parentView;

@end
