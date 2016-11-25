//
//  XTLoginViewController.m
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "XTLoginViewController.h"

#import "XTAPIClient.h"
#import "XTSession.h"
#import "XTGameWorld.h"

#import "MBProgressHUD.h"

#import "NSString+Utility.h"


#pragma mark -

@interface XTLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginButtonTapped:(id)sender;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

@end


#pragma mark -

@implementation XTLoginViewController


#pragma mark -
#pragma mark UIViewController methods

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
    
    if ([self validateLogin]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"Please Wait...";
        
        // DEVELOPER'S NOTE: Weak self is used in block to avoid retain cycle
        __weak typeof(self) weakSelf = self;
        
        [[XTAPIClient sharedClient] sendAvailableGameWorldsRequestWithLogin:self.email
                                                                   password:self.password
                                                                 deviceType:[[XTSession sharedSession] deviceType]
                                                                   deviceID:[[XTSession sharedSession] deviceId]
                                                         andCompletionBlock:^(NSError *error, NSDictionary *responseDict) {
                                                             
                                                             [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
                                                             
                                                             if (error == nil) {
                                                                 NSArray *allGameWorlds = [responseDict objectForKey:@"allAvailableWorlds"];
                                                                 
                                                                 // Creating array of XTGameWorld objects from response
                                                                 [XTSession sharedSession].gameWorlds = [XTGameWorld arrayOfGameWorldsFromInfo:allGameWorlds];
                                                                 
                                                                 // DEVELOPER'S NOTE: Since there is no navigating backwards, so need to keep XTLoginViewController in memory
                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"XTNotifcationsLogInNotificationKey" object:nil];
                                                                 
                                                             } else {
                                                                 [weakSelf showErrorAlertWithMessage:error.localizedDescription];
                                                             }
                                                         }];
    }
}


#pragma mark -
#pragma mark Private methods

- (BOOL)validateLogin {
    BOOL isValid = NO;
    
    // Removing leading and trailing white spaces from strings
    self.email = self.emailTextField.text.stringByTrimmingLeadingAndTrailingWhiteSpaces;
    self.password = self.passwordTextField.text.stringByTrimmingLeadingAndTrailingWhiteSpaces;
    
    NSString *errorMessage = @"";
    
    if ([self.email length] == 0) {
        errorMessage = @"Email is required.";
        
    } else if ([self.password length] == 0) {
        errorMessage = @"Password is required.";
        
    } else if (![self.email isValidEmail]) {
        errorMessage = @"Please enter valid email.";
        
    } else {
        isValid = YES;
    }
    
    if (!isValid) {
        [self showErrorAlertWithMessage:errorMessage];
    }
    
    return isValid;
}

- (void)showErrorAlertWithMessage:(NSString *)errorMessage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
