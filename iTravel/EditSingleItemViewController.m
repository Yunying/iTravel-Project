//
//  EditSingleItemViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/5/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "EditSingleItemViewController.h"

@interface EditSingleItemViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation EditSingleItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Text View
    _textView.layer.borderWidth = 1.0f;
    _textView.layer.borderColor = [[UIColor blackColor] CGColor];
    _textView.layer.cornerRadius = 10.0f;
    _textView.layer.masksToBounds = YES;
    _textView.text = _editContent;
    
    //Navigation Bar
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    UIBarButtonItem *saveButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];
    self.navigationItem.title = _editTitle;
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

- (void) cancelButtonTapped: (UIBarButtonItem*) button {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) saveButtonTapped: (UIBarButtonItem*) button {
    self.completionHandler(_textView.text);
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
