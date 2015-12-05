//
//  NewSightViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/5/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "NewSightViewController.h"
#import "GlobalUtility.h"
#import "Constants.h"

@interface NewSightViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation NewSightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Navigation Bar
    
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    UIBarButtonItem *saveButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];
    self.navigationItem.title = @"New Sight";
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = saveButton;
    [self.navigationBar pushNavigationItem:self.navigationItem animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cancelButtonTapped: (UIBarButtonItem*) button {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void) saveButtonTapped: (UIBarButtonItem*) button {
    
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
