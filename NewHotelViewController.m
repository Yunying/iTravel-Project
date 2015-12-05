//
//  NewHotelViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/5/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "NewHotelViewController.h"
#import "TravelDatabase.h"
#import "GlobalUtility.h"
#import "Constants.h"
#import "TravelTrip.h"

@interface NewHotelViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *startDate;
@property (weak, nonatomic) IBOutlet UITextField *endDate;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@property(strong, nonatomic) GlobalUtility* util;
@property(strong, nonatomic) TravelDatabase* database;

@property(strong, nonatomic) PFObject* tripObj;
@property(strong, nonatomic) PFObject* dayObj;

@end

@implementation NewHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialization
    _util = [GlobalUtility sharedModel];
    _database = [TravelDatabase sharedModel];
    _tripObj = _tripDay.parentTripObj;
    _dayObj = _tripDay.parseObj;
    
    //Text Field
    [_util styleTextField:_nameTextField];
    [_util styleTextField:_addressTextField];
    [_util styleTextField:_emailTextField];
    [_util styleTextField:_phoneTextField];
    [_util styleTextField:_priceTextField];
    [_util styleTextField:_startDate];
    [_util styleTextField:_endDate];
    
    _startDate.text = _tripDay.tripDate;
    _endDate.text = _tripObj[kTripEndDate];
    
    //Date Picker
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [_startDate setInputView:datePicker];
    [_endDate setInputView:datePicker];
    
    
    //Navigation Bar
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    UIBarButtonItem *saveButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];
    self.navigationItem.title = @"New Hotel";
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = saveButton;
    [self.navigationBar pushNavigationItem:self.navigationItem animated:NO];
    
    //Tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [_nameTextField resignFirstResponder];
    [_addressTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_startDate resignFirstResponder];
    [_endDate resignFirstResponder];
    [_priceTextField resignFirstResponder];
}

- (void) cancelButtonTapped: (UIBarButtonItem*) button {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) saveButtonTapped: (UIBarButtonItem*) button {
    
}

- (void) dateTextField: (UIDatePicker*) sender {
    UITextField* currField;
    if (_startDate.isFirstResponder){
        currField = _startDate;
    } else {
        currField = _endDate;
    }
    UIDatePicker *picker = (UIDatePicker*)currField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *date = picker.date;
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    currField.text = [NSString stringWithFormat:@"%@",dateString];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
