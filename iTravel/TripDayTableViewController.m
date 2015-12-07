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
#import "TravelDatabase.h"
#import "EditSingleItemViewController.h"
#import "CostDetailTableViewController.h"

@interface TripDayTableViewController ()

@property (nonatomic) bool haveHotel;

@property (nonatomic) NSInteger sightNumber;

@property (nonatomic) TravelDatabase* database;

@property (nonatomic) bool haveImage;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) NSString* itemTitle;

@property (nonatomic, strong) NSString* itemContent;

@property (nonatomic, strong) NSString* itemConst;

@end

@implementation TripDayTableViewController

static NSString * const cellIdentifier = @"TripDayCell";
static NSInteger const SightRowNumber = 3;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    _database = [TravelDatabase sharedModel];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.title = _tripDay.tripDate;
    UIBarButtonItem *edit=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editTripDay:)];
    self.navigationItem.rightBarButtonItem = edit;
    
    //Load Variables
    [_database reloadTripDay:_tripDay];
    _tripDayObj = _tripDay.parseObj;
    _sights = [_database getSightsForTripDay:_tripDayObj];
    
    //Initialize
    if (_tripDayObj[kHotelName] == nil){
        _haveHotel = false;
    } else {
        _haveHotel = true;
    }
    
    if (_tripDayObj[kTripDayImageCount] == nil){
        _haveImage = false;
    } else {
        _haveImage = true;
    }
    
    _sightNumber = _sights.count;
    
    [_parentView viewDidLoad];
    [_parentView.tableView reloadData];
}

- (void) editTripDay: (UIBarButtonItem*) button {
    [self.tableView setEditing:YES animated:YES];
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
            if (_haveImage) {
                return 2;
            } else {
                return 1;
            }
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
                cell.backgroundColor = [UIColor colorWithRed:235.0/255.0
                                                       green:235.0/255.0
                                                        blue:235.0/255.0
                                                       alpha:1.0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                int sightIndex = indexPath.row / SightRowNumber;
                PFObject* sight = (PFObject*)_sights[sightIndex];
                if (indexPath.row % SightRowNumber == 0){
                    cell.textLabel.text = @"Destination";
                    cell.detailTextLabel.text = sight[kSightName];
                    cell.backgroundColor = [UIColor colorWithRed:245.0/255.0
                                                           green:245.0/255.0
                                                            blue:245.0/255.0
                                                           alpha:1.0];
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
            if (_haveImage){
                if (indexPath.row == 0){
                    cell.textLabel.text = @"View Image";
                    cell.detailTextLabel.text = @"";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                } else {
                    cell.textLabel.text = @"Add Image";
                    cell.detailTextLabel.text = @"";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            } else {
                cell.textLabel.text = @"Add Image";
                cell.detailTextLabel.text = @"";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section number: %ldl", (long)_sightNumber*SightRowNumber);
    if (indexPath.section == 1 && indexPath.row == _sightNumber*SightRowNumber){
        [self performSegueWithIdentifier:kAddNewSightSegue sender:self];
    } else if (indexPath.section == 2 && !_haveHotel){
        [self performSegueWithIdentifier:kAddNewHotelSegue sender:self];
    } else if (indexPath.section == 2 && _haveHotel){
        //Todo
        switch (indexPath.row){
            case 0:
                _itemTitle = @"Edit Hotel Name";
                _itemConst = kHotelName;
                break;
            case 1:
                _itemTitle = @"Edit Hotel Address";
                _itemConst = kHotelAddress;
                break;
            case 2:
                _itemTitle = @"Edit Hotel Email";
                _itemConst = kHotelEmail;
                break;
            case 3:
                _itemTitle = @"Edit Hotel Phone";
                _itemConst = kHotelPhone;
                break;
        }
        [self performSegueWithIdentifier:kEditSingleItemSegue sender:self];
        
    } else if (indexPath.section == 3){
        if ((_haveImage && indexPath.row == 1) || (!_haveImage && indexPath.row == 0)){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:NULL];
        } else {
            NSMutableArray* images = [_database getImagesForTripDay:_tripDayObj];
            _photos = [[NSMutableArray alloc] init];
            //[self performSegueWithIdentifier:kShowImageSegue sender:self];
            MWPhotoBrowser* photoBrowser = [[MWPhotoBrowser alloc]initWithDelegate:self];
            UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
            
            for (int i=0; i<images.count; i++){
                [_photos addObject:[MWPhoto photoWithImage:images[i]]];
            }
            
            nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
             
            [photoBrowser setCurrentPhotoIndex:0];
             
            [self.navigationController presentViewController:nc animated:YES completion:nil];
        }
    } else if (indexPath.section == 0 && indexPath.row == 1){
        _itemTitle = @"Edit Itinerary";
        _itemConst = kTripDaySummary;
        [self performSegueWithIdentifier:kEditSingleItemSegue sender:self];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        [self performSegueWithIdentifier:kCostDetailSegue sender:self];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [_database saveImage:chosenImage forTripDay:_tripDayObj];
    
    if (_tripDayObj[kTripDayImageCount] == nil){
        _tripDayObj[kTripDayImageCount] = @"1";
    } else {
        int value = [_tripDayObj[kTripDayImageCount] integerValue]+1;
        _tripDayObj[kTripDayImageCount] = [NSString stringWithFormat:@"%d", value];
    }
    [_tripDayObj save];
    [self viewDidLoad];
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 1
        && indexPath.row%SightRowNumber == 0
        && indexPath.row != SightRowNumber*_sightNumber){
        return YES;
    } else {
        return NO;
    }
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        int sightIndex = indexPath.row / SightRowNumber;
        PFObject* sight = (PFObject*)_sights[sightIndex];
        PFObject* dayObj = sight[kSightParent];
        [dayObj fetch];
        [_database updateTripDaySightCost:dayObj withValue:[sight[kSightCost] floatValue]];
        [_database reloadTripDay:_tripDay];
    
        //Delete
        [sight delete];
        _sights = [_database getSightsForTripDay:_tripDayObj];
        _sightNumber--;
        
        NSIndexPath* path = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        NSIndexPath* path2 = [NSIndexPath indexPathForRow:indexPath.row+2 inSection:indexPath.section];
        NSMutableArray* arr = [[NSMutableArray alloc]initWithObjects:indexPath,path,path2,nil];
        [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        
        [self viewDidLoad];
        [self.tableView reloadData];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:kAddNewHotelSegue]){
        NewHotelViewController* controller = segue.destinationViewController;
        
        controller.tripDay = _tripDay;
        controller.parentView = self;
        
    } else if ([segue.identifier isEqualToString:kAddNewSightSegue]){
        NewSightViewController* controller = segue.destinationViewController;
        controller.tripDay = _tripDay;
        controller.parentView = self;
    } else if ([segue.identifier isEqualToString:kEditSingleItemSegue]){
        EditSingleItemViewController* controller = segue.destinationViewController;
        controller.editTitle = _itemTitle;
        controller.editContent = _tripDayObj[_itemConst];
        controller.completionHandler = ^(NSString* text){
            if (text != nil){
                _tripDayObj[_itemConst] = text;
                [_tripDayObj save];
                [self.tableView reloadData];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    } else if ([segue.identifier isEqualToString:kCostDetailSegue]){
        CostDetailTableViewController* controller = segue.destinationViewController;
        controller.dayType = true;
        controller.tripDay = _tripDay.parseObj;
        controller.sights = _sights;
    }
}




@end
