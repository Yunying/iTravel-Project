//
//  MainTableViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "MainTableViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "TravelDatabase.h"
#import "AddTripViewController.h"
#import "TripDetailTableViewController.h"

@interface MainTableViewController ()


@property(strong, nonatomic) TravelDatabase* database;
@property(strong, nonatomic) NSArray* trips;

@property(strong, nonatomic) TravelTrip* showTrip;

@end

@implementation MainTableViewController

static NSString * const cellIdentifier = @"TripCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Navigation Bar
    
    self.navigationItem.title = @"My Travels";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *bookmarkButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                  target:self action:@selector(bookmarkButtonPressed:)];
    self.navigationItem.leftBarButtonItem = bookmarkButton;
    
    //Read from Parse Database
    _database = [TravelDatabase sharedModel];
    _trips = [_database getAllTripsFromDatabase];
    [self.tableView reloadData];
    
}

- (void) addButtonPressed: (UIBarButtonItem*) button {
    [self performSegueWithIdentifier:kAddTripSegue sender:self];
}

- (void) bookmarkButtonPressed: (UIBarButtonItem*) button {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Open Trip"
                                                message:@"Give us the trip code you wish to see!"
                                                preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Open" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSString* tripCode = alert.textFields[0].text;
        PFQuery* query = [PFQuery queryWithClassName:kTripClass];
        PFObject* obj = [query getObjectWithId:tripCode];
        if (obj != nil){
            _showTrip = [[TravelTrip alloc] constructFromPFObject:obj];
            [self performSegueWithIdentifier:kSharedTripSegue sender:self];
        }
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Trip Code";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TravelTrip*) findPlaceWithName: (NSString*) inName {
    for (int i=0; i<_trips.count; i++){
        TravelTrip* trip = (TravelTrip*)(_trips[i]);
        if ([trip.name isEqualToString:inName]){
            return trip;
        }
    }
    return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _trips.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    TravelTrip* trip = [_trips objectAtIndex:indexPath.row];
    cell.textLabel.text = [trip name];
    cell.detailTextLabel.text = [trip getDateRange];
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:kAddTripSegue]){
        AddTripViewController *addTrip = segue.destinationViewController;
        addTrip.parentView = self;
    } else if ([segue.identifier isEqualToString:kTripDetailSegue]){
        TripDetailTableViewController* detail = segue.destinationViewController;
        NSIndexPath* path = [self.tableView indexPathForSelectedRow];
        UITableViewCell *selectedCell=[self.tableView cellForRowAtIndexPath:path];
        NSString* placeName = selectedCell.textLabel.text;
        TravelTrip* selectedTrip = [self findPlaceWithName:placeName];
        
        [detail setTrip:selectedTrip];
    } else if ([segue.identifier isEqualToString:kSharedTripSegue]){
        TripDetailTableViewController* detail = segue.destinationViewController;
        [detail setTrip:_showTrip];
        

    }
    
}


@end
