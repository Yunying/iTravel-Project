//
//  AddTripViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "AddTripViewController.h"
#import "GlobalUtility.h"
#import "Constants.h"
#import "MainTableViewController.h"
#import "TravelTrip.h"
#import "TravelDatabase.h"

@interface AddTripViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *budgetTextField;

@property(strong, nonatomic) GlobalUtility* util;
@property(strong, nonatomic) TravelDatabase* database;

@end

@implementation AddTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _util = [GlobalUtility sharedModel];
    _database = [TravelDatabase sharedModel];
    
    //Round Corner
    [_util styleTextField:_nameTextField];
    [_util styleTextField:_startDateTextField];
    [_util styleTextField:_endDateTextField];
    [_util styleTextField:_budgetTextField];
    
    //DatePicker setup
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [_startDateTextField setInputView:datePicker];
    [_endDateTextField setInputView:datePicker];
    
    //Handler
    __weak typeof(self) weakSelf = self;
    self.completionHandler = ^BOOL(NSString* inName, NSString* inStartDate, NSString* inEndDate, NSString* inBudget){
        if ([inName isEqual: @""]){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ERROR"
                                                        message:@"Please enter name of the trip."
                                                        preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {                         }];
            
            [alert addAction:defaultAction];
            [weakSelf presentViewController:alert animated:YES completion:nil];

            return false;
        } else {
            TravelTrip* newTrip = [[TravelTrip alloc]init];
            newTrip.name = inName;
            newTrip.startDate = inStartDate;
            newTrip.endDate = inEndDate;
            newTrip.budget = inBudget;
            [newTrip generateTripDays];
            [weakSelf.database saveNewTrip:newTrip];
            return true;
        }
    };
}

- (IBAction)doneButtonPressed:(id)sender {
    bool success = self.completionHandler(_nameTextField.text,
                                          _startDateTextField.text,
                                          _endDateTextField.text,
                                          _budgetTextField.text);
    
    if (success){
        [_parentView viewDidLoad];
        [self dismissViewControllerAnimated:YES completion:nil];
    } 
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dateTextField: (UIDatePicker*) sender {
    UITextField* currField;
    if (_startDateTextField.isFirstResponder){
        currField = _startDateTextField;
    } else {
        currField = _endDateTextField;
    }
    UIDatePicker *picker = (UIDatePicker*)currField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *date = picker.date;
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    currField.text = [NSString stringWithFormat:@"%@",dateString];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:kSaveTripSegue]){
        MainTableViewController *trips = segue.destinationViewController;
        
        
    }
}


@end
