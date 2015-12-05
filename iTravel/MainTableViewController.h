//
//  MainTableViewController.h
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelTrip.h"

@interface MainTableViewController : UITableViewController

- (TravelTrip*) findPlaceWithName: (NSString*) inName;

@end
