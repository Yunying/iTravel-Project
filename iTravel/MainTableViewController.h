//
//  MainTableViewController.h
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelTrip.h"
#import <Parse/Parse.h>

@interface MainTableViewController : UITableViewController

@property (strong, nonatomic) PFObject* myUser;

- (TravelTrip*) findPlaceWithName: (NSString*) inName;


@end
