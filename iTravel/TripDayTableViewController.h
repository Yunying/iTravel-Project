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
#import "TripDetailTableViewController.h"
#import "MWPhotoBrowser.h"

@interface TripDayTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MWPhotoBrowserDelegate>

@property(strong, nonatomic) NSString* tripName;
@property(strong, nonatomic) TripDay* tripDay;
@property(strong, nonatomic) PFObject* tripDayObj;
@property(nonatomic) bool endpoint;
@property(nonatomic) NSArray* sights;
@property(strong, nonatomic) TripDetailTableViewController* parentView;


- (void) editTripDay: (UIBarButtonItem*) button;
- (BOOL) haveHotel;
@end
