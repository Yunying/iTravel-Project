//
//  TripDayTableViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/4/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "TripDayTableViewController.h"
#import "Constants.h"
#import "NewHotelViewController.h"
#import "NewSightViewController.h"

@interface TripDayTableViewController ()

@property (nonatomic) bool haveHotel;

@property (nonatomic) NSInteger sightNumber;


@end

@implementation TripDayTableViewController

static NSString * const cellIdentifier = @"TripDayCell";
static NSInteger const SightRowNumber = 3;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.title = _tripDay.tripDate;
    UIBarButtonItem *edit=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editTripDay:)];
    self.navigationItem.rightBarButtonItem = edit;
    
    //Initialize
    if (_tripDayObj[kHotelName] == nil){
        _haveHotel = false;
    } else {
        _haveHotel = true;
    }
    
    _sightNumber = _sights.count;
}

- (void) editTripDay: (UIBarButtonItem*) button {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section){
        case 0:
            return 3;
            break;
        case 1:
            return _sightNumber*SightRowNumber+1;
            break;
        case 2:
            if (_haveHotel){
                return 4;
            } else {
                return 1;
            }
            break;
        case 3:
            return 1;
            break;
    }
    return 0;
}

- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section){
        case 0:
            return @"Summary";
            break;
        case 1:
            return @"Event";
            break;
        case 2:
            return @"Lodging";
            break;
        case 3:
            return @"Images";
            break;
    }
    return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.section){
        case 0:
            if (indexPath.row == 0){
                cell.textLabel.text = @"Date";
                cell.detailTextLabel.text = _tripDayObj[kDate];
            } else if (indexPath.row == 1){
                cell.textLabel.text = @"Itinerary";
                cell.detailTextLabel.text = _tripDayObj[kTripDaySummary];
            } else if (indexPath.row == 2){
                cell.textLabel.text = @"Cost";
                cell.detailTextLabel.text = _tripDayObj[kTripDayCost];
            }
            break;
        case 1:
            if (indexPath.row == _sightNumber*SightRowNumber){
                cell.textLabel.text = @"Add Sight";
                cell.detailTextLabel.text = @"";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                int sightIndex = indexPath.row / SightRowNumber;
                PFObject* sight = (PFObject*)_sights[sightIndex];
                if (indexPath.row % SightRowNumber == 0){
                    cell.textLabel.text = @"Destination";
                    cell.detailTextLabel.text = sight[kSightName];
                } else if (indexPath.row % SightRowNumber == 1){
                    cell.textLabel.text = @"Transportation";
                    cell.detailTextLabel.text = sight[kSightTransport];
                } else if (indexPath.row % SightRowNumber == 2){
                    cell.textLabel.text = @"Address";
                    cell.detailTextLabel.text = sight[kSightAddress];
                }
            }
            break;
        case 2:
            if (_haveHotel){
                if (indexPath.row == 0){
                    cell.textLabel.text = @"Name";
                    cell.detailTextLabel.text = _tripDayObj[kHotelName];
                } else if (indexPath.row == 1){
                    cell.textLabel.text = @"Address";
                    cell.detailTextLabel.text = _tripDayObj[kHotelAddress];
                } else if (indexPath.row == 2){
                    cell.textLabel.text = @"Email";
                    cell.detailTextLabel.text = _tripDayObj[kHotelEmail];
                } else {
                    cell.textLabel.text = @"Phone";
                    cell.detailTextLabel.text = _tripDayObj[kHotelPhone];
                }
            } else {
                cell.textLabel.text = @"Add Lodging";
                cell.detailTextLabel.text = @"";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        case 3:
            cell.textLabel.text = @"Add Image";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0){
        [self performSegueWithIdentifier:kAddNewSightSegue sender:self];
    } else if (indexPath.section == 2 && !_haveHotel){
        [self performSegueWithIdentifier:kAddNewHotelSegue sender:self];

    }
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0){
        return YES;
    } else {
        return NO;
    }
}


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
    if ([segue.identifier isEqualToString:kAddNewHotelSegue]){
        NewHotelViewController* controller = segue.destinationViewController;
        controller.tripDay = _tripDay;
        
    } else if ([segue.identifier isEqualToString:kAddNewSightSegue]){
        NewSightViewController* controller = segue.destinationViewController;
        controller.tripDay = _tripDay;
    }
}


@end
