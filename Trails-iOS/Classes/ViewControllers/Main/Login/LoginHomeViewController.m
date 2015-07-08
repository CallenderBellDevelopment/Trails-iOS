//
//  LoginHomeViewController.m
//  DigiGraff-IOS
//
//  Created by Georgi Christov on 25/11/2014.
//  Copyright (c) 2014 DigiGraff. All rights reserved.
//

#import "LoginHomeViewController.h"
#import "AppDelegate.h"

@interface LoginHomeViewController () {
    
    IBOutlet UILabel *forgotPasswordLabel;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    
    UILabel *signupLabel;
}

@end

@implementation LoginHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [self setupLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClickLogin {
    [self.view endEditing:YES];
    
    if ([InputValidator validateLoginInput:usernameField.text password:passwordField.text viewController:self]) {
        [[LoadingViewManager getInstance] addLoadingToView:self.navigationController.view withMessage:@"Processing"];
        
        [TRSUserManager loginWithUsername:usernameField.text password:passwordField.text successBlock:^(TRSResponseObject *response) {
            [[LoadingViewManager getInstance] removeLoadingView];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOG_IN object:nil];
            });
        } failureBlock:^(TRSResponseObject *response) {
            [[LoadingViewManager getInstance] removeLoadingView];
            
            if (response.reason == AUTHORIZATION_NEEDED)
                [Utils showMessage:APP_NAME message:@"The username or password are incorrect."];
            else
                [Utils showMessage:APP_NAME message:response.message];
        }];
    }
}

- (void)onClickFacebookLogin {
    NSLog(@"CLICKED FACEBOOK LOGIN");
}

- (void)onClickForgottenPassword {
    [self performSegueWithIdentifier:@"SEGUE_RESET_PASSWORD" sender:nil];
}

- (void)onClickSignup {
    [self performSegueWithIdentifier:@"SEGUE_SIGN_UP" sender:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 3)
                [self onClickForgottenPassword];
            
            break;
        }
        case 1: {
            if (indexPath.row == 0)
                [self onClickLogin];
            else if (indexPath.row == 1)
                [self onClickFacebookLogin];
            
            break;
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1)
        [passwordField becomeFirstResponder];
    else if (textField.tag == 2)
        [self onClickLogin];
    
    return YES;
}

#pragma mark - Setup

- (void)setupLabels {
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    signupLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 30, self.view.frame.size.width, 25)];
    signupLabel.text = @"Sign up for Trails";
    signupLabel.textAlignment = NSTextAlignmentCenter;
    signupLabel.font = [UIFont systemFontOfSize:15];
    signupLabel.userInteractionEnabled = YES;
    [self.view addSubview:signupLabel];
    
    UITapGestureRecognizer *rec2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSignup)];
    rec2.numberOfTapsRequired = 1;
    rec2.numberOfTouchesRequired = 1;
    [signupLabel addGestureRecognizer:rec2];
    
    signupLabel.attributedText = [[NSAttributedString alloc] initWithString:signupLabel.text attributes:underlineAttribute];
    forgotPasswordLabel.attributedText = [[NSAttributedString alloc] initWithString:forgotPasswordLabel.text attributes:underlineAttribute];
}

@end
