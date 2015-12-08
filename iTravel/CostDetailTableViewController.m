//
//  CostDetailTableViewController.m
//  
//
//  Created by YUNYING TU on 12/6/15.
//
//

#import "CostDetailTableViewController.h"
#import "Constants.h"
#import "GlobalUtility.h"
#import "TravelDatabase.h"
#import <Parse/Parse.h>
#import "EditSingleItemViewController.h"

@interface CostDetailTableViewController ()

@property(strong, nonatomic) TravelDatabase* database;
@property(strong, nonatomic) GlobalUtility* util;

@property(strong, nonatomic) NSString* itemConst;

@property float originalNumber;
@property NSString* originalItem;

@property PFObject* editItem;

@end

@implementation CostDetailTableViewController

static NSString * const cellIdentifier = @"CostDetailCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    _database = [TravelDatabase sharedModel];
    _util = [GlobalUtility sharedModel];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Cost Summary";
    _sights = [_database getSightsForTripDay:_tripDay];
    _others = [_database getThingsForTripDay:_tripDay];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    if (_others == nil) {
        _others = [[NSMutableArray alloc]init];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addButtonPressed: (UIBarButtonItem*) button {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Cost Item"
                                                                   message:@"Please enter cost item and amount"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UITextField* priceTextField = alert.textFields[1];
        
        PFObject* obj = [PFObject objectWithClassName:kThingClass];
        obj[kThingParent] = _tripDay;
        obj[kThingItem] = alert.textFields[0].text;
        obj[kThingAmount] = alert.textFields[1].text;
        [obj save];
        
        
        PFObject* dayObj = _tripDay;
        if (dayObj[kTripDayCost] == nil){
            dayObj[kTripDayCost] = priceTextField.text;
            dayObj[kTripDayOtherCost] = priceTextField.text;
        } else {
            float newCost = [dayObj[kTripDayCost] floatValue] + [priceTextField.text floatValue];
            dayObj[kTripDayCost] = [NSString stringWithFormat:@"%1.2f", newCost];
            dayObj[kTripDayOtherCost] = [NSString stringWithFormat:@"%1.2f", newCost];
        }
        [dayObj save];
        
        [self viewDidLoad];
        [self.tableView reloadData];
        [_parentView viewDidLoad];
        [_parentView.tableView reloadData];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Cost Item";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Cost Amount";
    }];
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section){
        case 0:
            return 1;
            break;
        case 1:
            return _sights.count;
            break;
        case 2:
            return _others.count;
    }
    return @"";
}

- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section){
        case 0:
            return @"Lodging";
            break;
        case 1:
            return @"Events";
            break;
        case 2:
            return @"Others";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 0){
        cell.textLabel.text = _tripDay[kHotelName];
        cell.detailTextLabel.text = _tripDay[kTripDayHotelCost];
    } else if (indexPath.section == 1){
        int sightIndex = indexPath.row;
        PFObject* sight = (PFObject*)_sights[sightIndex];
        cell.textLabel.text = sight[kSightName];
        cell.detailTextLabel.text = sight[kSightCost];
    } else {
        int otherIndex = indexPath.row;
        PFObject* thing = (PFObject*)_others[otherIndex];
        cell.textLabel.text = thing[kThingItem];
        cell.detailTextLabel.text = thing[kThingAmount];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        _itemConst = kTripDayHotelCost;
        _editItem = nil;
    } else {
        _itemConst = kTripDaySightCost;
        _editItem = (PFObject*)_sights[indexPath.row];
    }
    _originalNumber = [_editItem[kSightCost] floatValue];
    _originalItem = _editItem[kSightName];
    [self performSegueWithIdentifier:kEditSingleItemSegue sender:self];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
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
    
    if ([segue.identifier isEqualToString:kEditSingleItemSegue]){
        EditSingleItemViewController* controller = segue.destinationViewController;
        controller.editTitle = _originalItem;

        controller.editContent = [NSString stringWithFormat:@"%1.2f", _originalNumber];

        controller.completionHandler = ^(NSString* text){
            if (text != nil){
                float newVal = [text floatValue];
                float itemCost = [_tripDay[_itemConst] floatValue];
                float dayCost = [_tripDay[kTripDayCost] floatValue];
                float updated = itemCost -_originalNumber + newVal;
                float updatedDay = dayCost - _originalNumber + newVal;
                _tripDay[kTripDayCost] = [NSString stringWithFormat:@"%1.2f",updatedDay];
                _tripDay[_itemConst] = [NSString stringWithFormat:@"%1.2f",updated];
                [_tripDay save];
                
                if (_editItem){
                    _editItem[kSightCost] = [NSString stringWithFormat:@"%1.2f", newVal];

                    [_editItem save];
                }
                
                [self viewDidLoad];
                [self.tableView reloadData];
                [_parentView viewDidLoad];
                [_parentView.tableView reloadData];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
}


@end
