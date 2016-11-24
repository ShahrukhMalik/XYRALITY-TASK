//
//  XTLoginViewController.m
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "XTLoginViewController.h"

#import "NSString+Utility.h"


#pragma mark -

@interface XTLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginButtonTapped:(id)sender;

@end


#pragma mark -

@implementation XTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Rounded corners for login button
    self.loginButton.layer.cornerRadius = 3.0f;
    self.loginButton.clipsToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Action methods

- (IBAction)loginButtonTapped:(id)sender {
    [self validateLogin];
}


#pragma mark -
#pragma mark Private methods

- (BOOL)validateLogin {
    BOOL isValid = NO;
    
    // Removing leading and trailing white spaces from strings
    NSString *email = self.emailTextField.text.stringByTrimmingLeadingAndTrailingWhiteSpaces;
    NSString *password = self.passwordTextField.text.stringByTrimmingLeadingAndTrailingWhiteSpaces;
    
    NSString *errorMessage = @"";
    
    if ([email length] == 0) {
        errorMessage = @"Email is required.";
        
    } else if ([password length] == 0) {
        errorMessage = @"Password is required.";
        
    } else if (![email isValidEmail]) {
        errorMessage = @"Please enter valid email.";
        
    } else {
        isValid = YES;
    }
    
    if (!isValid) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    return isValid;
}

@end
