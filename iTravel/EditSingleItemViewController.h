//
//  EditSingleItemViewController.h
//  iTravel
//
//  Created by YUNYING TU on 12/5/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripDayTableViewController.h"

typedef void(^EditItemCompletionHandler)(NSString* text);

@interface EditSingleItemViewController : UIViewController

@property (strong, nonatomic) NSString* editTitle;
@property (strong, nonatomic) NSString* editContent;

@property(copy, nonatomic) EditItemCompletionHandler completionHandler;

@end
