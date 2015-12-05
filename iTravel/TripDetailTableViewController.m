//
//  TripDetailTableViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/3/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "TripDetailTableViewController.h"
#import "TravelTrip.h"
#import "TripDay.h"
#import "GlobalUtility.h"

@interface TripDetailTableViewController()

@property(strong, nonatomic, setter=setTrip:) TravelTrip* myTrip;
@property(strong, nonatomic) GlobalUtility* util;

@end

@interface TripDetailTableViewController ()

@end

@implementation TripDetailTableViewController

static NSString * const cellIdentifier = @"TripDetailCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Global classes
    _util = [GlobalUtility sharedModel];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.title = _myTrip.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return 5;
    } else {
        //TODO
        NSLog(@"Number of trip days: %lu", (unsigned long)[_myTrip numberOfTripDays]);
        return [_myTrip numberOfTripDays];
    }
}

- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Summary";
    } else {
        // return some string here ...
        return @"Plans";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0){
        switch (indexPath.row){
            case 0:
                cell.textLabel.text = @"Destination";
                cell.detailTextLabel.text = _myTrip.name;
                break;
            case 1:
                cell.textLabel.text = @"Start Date";
                cell.detailTextLabel.text = [_util formatDateStringWithSlash:_myTrip.startDate];

                break;
            case 2:
                cell.textLabel.text = @"End Date";
                cell.detailTextLabel.text = [_util formatDateStringWithSlash:_myTrip.endDate];

                break;
            case 3:
                cell.textLabel.text = @"Trip Budget";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %1.2f",
                                             [_myTrip.budget floatValue]];

                break;
            case 4:
                cell.textLabel.text = @"Current Cost";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %1.2f",
                                             _myTrip.getCurrentCost];

                break;
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString* datePart = [_util formatDateStringWithoutYear:
                              [_myTrip tripDayAtIndex:indexPath.row].tripDate];
        NSString* labelText = [NSString stringWithFormat:@"%@ %ld", @"Day", indexPath.row+1];
        cell.textLabel.text = labelText;
        cell.detailTextLabel.text = datePart;

    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
