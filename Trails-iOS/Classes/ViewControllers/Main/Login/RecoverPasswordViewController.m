//
//  RecoverPasswordViewController.m
//  DigiGraff-IOS
//
//  Created by Georgi Christov on 25/11/2014.
//  Copyright (c) 2014 DigiGraff. All rights reserved.
//

#import "RecoverPasswordViewController.h"

@interface RecoverPasswordViewController () {
    
    IBOutlet UITextField *emailField;
}

- (IBAction)onClickCancel:(id)sender;

@end

@implementation RecoverPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickCancel:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onClickReset {
    [self.view endEditing:YES];
    
    NSLog(@"CLICKED RESET PASSWORD");
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0)
        [self onClickReset];
}

@end
