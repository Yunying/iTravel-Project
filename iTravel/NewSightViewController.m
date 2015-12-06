//
//  NewSightViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/5/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "NewSightViewController.h"
#import "TravelDatabase.h"
#import "GlobalUtility.h"
#import "Constants.h"

@interface NewSightViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *transportTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@property(strong, nonatomic) GlobalUtility* util;
@property(strong, nonatomic) TravelDatabase* database;

@end

@implementation NewSightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _util = [GlobalUtility sharedModel];
    _database = [TravelDatabase sharedModel];
    
    //Navigation Bar
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    UIBarButtonItem *saveButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];
    self.navigationItem.title = @"New Sight";
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = saveButton;
    [self.navigationBar pushNavigationItem:self.navigationItem animated:NO];
    
    //Text Fields
    [_util styleTextField:_nameTextField];
    [_util styleTextField:_addressTextField];
    [_util styleTextField:_transportTextField];
    [_util styleTextField:_priceTextField];
    
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
    [_transportTextField resignFirstResponder];
    [_priceTextField resignFirstResponder];
}

- (void) cancelButtonTapped: (UIBarButtonItem*) button {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void) saveButtonTapped: (UIBarButtonItem*) button {
    PFObject* obj = [PFObject objectWithClassName:kSightClass];
    obj[kSightName] = _nameTextField.text;
    obj[kSightAddress] = _addressTextField.text;
    obj[kSightTransport] = _transportTextField.text;
    obj[kSightParent] = _tripDay.parseObj;
    [obj save];
    
    PFObject* dayObj = _tripDay.parseObj;
    if (dayObj[kTripDayCost] == nil){
        dayObj[kTripDayCost] = _priceTextField.text;
    } else {
        float newCost = [dayObj[kTripDayCost] floatValue] + [_priceTextField.text floatValue];
        dayObj[kTripDayCost] = [NSString stringWithFormat:@"%1.2f", newCost];
    }
    [dayObj save];
    
    [_parentView viewDidLoad];
    [_parentView.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
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
