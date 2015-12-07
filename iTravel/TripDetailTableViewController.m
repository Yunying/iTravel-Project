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
#import "Constants.h"
#import "TripDayTableViewController.h"
#import "TravelDatabase.h"
#import "MapViewController.h"

@interface TripDetailTableViewController()

@property(strong, nonatomic, setter=setTrip:) TravelTrip* myTrip;
@property(strong, nonatomic) GlobalUtility* util;
@property(strong, nonatomic) TravelDatabase* database;

@end

@interface TripDetailTableViewController ()

@end

@implementation TripDetailTableViewController

static NSString * const cellIdentifier = @"TripDetailCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Global classes
    _util = [GlobalUtility sharedModel];
    _database = [TravelDatabase sharedModel];
    NSMutableArray* array = [_database getAllTripDaysForTrip:_myTrip.name];
    _myTrip.tripDays = array;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.title = _myTrip.name;
    
    [self.tableView reloadData];
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
        return 7;
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
            case 5:
                cell.textLabel.text = @"Image Locations";
                cell.detailTextLabel.text = @"";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 6:
                cell.textLabel.text = @"Share Code";
                cell.detailTextLabel.text = _myTrip.parseObj.objectId;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1){
        [self performSegueWithIdentifier:kTripDayDetailSegue sender:self];

    } else if (indexPath.section == 0 && indexPath.row == 5){
        [self performSegueWithIdentifier:kMapViewSegue sender:self];
        /*Class mapItemClass = [MKMapItem class];
        if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
        {
            // Create an MKMapItem to pass to the Maps app
            CLLocationCoordinate2D coordinate =
            CLLocationCoordinate2DMake(16.775, -3.009);
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                           addressDictionary:nil];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
            [mapItem setName:@"My Place"];
            // Pass the map item to the Maps app
            [mapItem openInMapsWithLaunchOptions:nil];
            
            
        }*/
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:kTripDayDetailSegue]){
        TripDayTableViewController* controller = segue.destinationViewController;
        controller.tripName = _myTrip.name;
        NSIndexPath* path = [self.tableView indexPathForSelectedRow];
        TripDay* day = _myTrip.tripDays[path.row];
        [_database reloadTripDay:day];
        
        controller.tripDay = day;
        if (path.row == 0 || path.row == [_myTrip numberOfTripDays]-1){
            controller.endpoint = true;
        } else {
            controller.endpoint = false;
        }
        controller.parentView = self;
        
    } else if ([segue.identifier isEqualToString:kMapViewSegue]){
        MapViewController* controller = segue.destinationViewController;
        NSArray* imageLocations = _myTrip.parseObj[kImageLocations];
        controller.locations = imageLocations;
    }
}


@end
