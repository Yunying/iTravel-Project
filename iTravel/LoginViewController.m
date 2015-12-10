//
//  LoginViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/7/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "LoginViewController.h"
#import "GlobalUtility.h"
#import "Constants.h"
#import "TravelDatabase.h"
#import "MainTableViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *signinButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@property(strong, nonatomic) GlobalUtility* util;
@property(strong, nonatomic) TravelDatabase* database;

@property(strong, nonatomic) PFObject* myUser;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _util = [GlobalUtility sharedModel];
    _database = [TravelDatabase sharedModel];
    
    //Textfield
    [_util styleTextField:_usernameTextfield];
    [_util styleTextField:_passwordTextfield];
    _usernameTextfield.layer.borderColor=[[UIColor whiteColor]CGColor];
    _passwordTextfield.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    UIColor *color = [UIColor whiteColor];
    _usernameTextfield.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Username"
     attributes:@{NSForegroundColorAttributeName:color}];
    _passwordTextfield.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Password"
     attributes:@{NSForegroundColorAttributeName:color}];
    _passwordTextfield.secureTextEntry = NO;
    
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
- (IBAction)signinButtonTapped:(id)sender {
    if (_usernameTextfield.text != nil && _passwordTextfield.text != nil
        && ![_usernameTextfield.text isEqualToString:@""] && ![_passwordTextfield.text isEqualToString:@""]){
        PFObject* user = [_database getUser: _usernameTextfield.text
                               withPassword:_passwordTextfield.text];
        if (user != nil){
            _myUser = user;
            _database.currentUser = user;
            [self performSegueWithIdentifier:kLoginSegue sender:self];
        } else {
            [self loginFailed];
        }
    } else {
        [self loginFailed];
    }
    
}

- (void) loginFailed {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Failed"
                                                                   message:@"Username or password invalid"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


- (IBAction)signupButtonTapped:(id)sender {
    if (_usernameTextfield.text != nil && _passwordTextfield.text != nil
        && ![_usernameTextfield.text isEqualToString:@""] && ![_passwordTextfield.text isEqualToString:@""]){
        [_database saveNewUser:_usernameTextfield.text withPassword:_passwordTextfield.text];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                       message:@"New user created! Login with your username and password."
                                                                preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:YES completion:nil];

    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:kLoginSegue]){
        UINavigationController* nav = segue.destinationViewController;
        MainTableViewController* controller = (MainTableViewController*)nav.topViewController;
        controller.myUser = _myUser;
    }
}

-(void)dismissKeyboard {
    [_usernameTextfield resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
}


@end
