//
//  SignUpViewController.m
//  DigiGraff-IOS
//
//  Created by Georgi Christov on 25/11/2014.
//  Copyright (c) 2014 DigiGraff. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController () {
    
    IBOutlet UILabel *termsLabel;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    IBOutlet UITextField *confirmPasswordField;
    IBOutlet UITextField *emailField;
    IBOutlet UITextField *firstnameField;
    IBOutlet UITextField *lastnameField;
}

@end

@implementation SignUpViewController

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

- (void)onClickCancel {
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onClickSignup {
    [self.view endEditing:YES];
    
    NSLog(@"CLICKED SIGN UP");
}

- (void)onClickTerms {
    [self performSegueWithIdentifier:@"SEGUE_VIEW_TERMS" sender:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 7)
                [self onClickTerms];
            
            break;
        }
        case 1: {
            if (indexPath.row == 0)
                [self onClickSignup];
            else if (indexPath.row == 1)
                [self onClickCancel];
            
            break;
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1)
        [[self.view viewWithTag:2] becomeFirstResponder];
    else if (textField.tag == 2)
        [[self.view viewWithTag:3] becomeFirstResponder];
    else if (textField.tag == 3)
        [[self.view viewWithTag:4] becomeFirstResponder];
    else if (textField.tag == 4)
        [[self.view viewWithTag:5] becomeFirstResponder];
    else if (textField.tag == 5)
        [[self.view viewWithTag:6] becomeFirstResponder];
    else if (textField.tag == 6)
        [self.view endEditing:YES];
    
    return YES;
}

#pragma mark - Setup

- (void)setupLabels {
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    termsLabel.attributedText = [[NSAttributedString alloc] initWithString:termsLabel.text attributes:underlineAttribute];
}

@end
