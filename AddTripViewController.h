//
//  AddTripViewController.h
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewController.h"
#import <Parse/Parse.h>

typedef bool (^AddTripCompletionHandler)(NSString* inName, NSString* inStartDate,
                                         NSString* inEndDate, NSString* inBudget);

@interface AddTripViewController : UIViewController

@property(copy, nonatomic) AddTripCompletionHandler completionHandler;
@property(weak, nonatomic) MainTableViewController* parentView;

@property(nonatomic) PFObject* myUser;

@end
