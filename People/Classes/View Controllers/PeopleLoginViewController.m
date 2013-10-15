//
//  PeopleLoginViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleLoginViewController.h"
#import "PeopleValidation.h"

@interface PeopleLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerBottomDistanceConstraint;

@end

@implementation PeopleLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Initial Adjusts

- (void)adjustFonts
{
    
}

- (void)adjustUIElements
{

    /*
     Here we're just creating a view to use as a margin on our text fields
     and making sure that our text fields always show them.
     */
    UIView *usernameTextFieldPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, self.usernameTextField.frame.size.height)];
    [usernameTextFieldPaddingView setBackgroundColor:[UIColor clearColor]];
    
    [self.usernameTextField setLeftView:usernameTextFieldPaddingView];
    [self.usernameTextField setLeftViewMode:UITextFieldViewModeAlways];
    
    UIView *passwordTextFieldPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, self.passwordTextField.frame.size.height)];
    [passwordTextFieldPaddingView setBackgroundColor:[UIColor clearColor]];
    
    [self.passwordTextField setLeftView:passwordTextFieldPaddingView];
    [self.passwordTextField setLeftViewMode:UITextFieldViewModeAlways];

}

- (void)adjustLocalizationItems
{
    self.usernameTextField.placeholder = NSLocalizedString(@"username", @"");
    self.passwordTextField.placeholder = NSLocalizedString(@"password", @"");
}


#pragma mark - Keyboard Notifications

- (void)keyboardWillHide:(BOOL)willHide animationDuration:(NSTimeInterval)animationDuration
{

    //TODO: animate constraints!! (Autolayout)
    if (!willHide)
    {
        //TODO: animate up

    }
    else
    {
        //TODO: animate down
    }
}

- (void)keyboardWillAppear:(NSNotification*)notification
{
    NSTimeInterval animationDuration = [(NSNumber*)[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.containerBottomDistanceConstraint.constant = keyboardRect.size.height;
                         [self.view layoutIfNeeded];
                     }];
    
    
    [self keyboardWillHide:NO animationDuration:animationDuration];
}

- (void)keyboardWillDisappear:(NSNotification*)notification
{
    NSTimeInterval animationDuration = [(NSNumber*)[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.containerBottomDistanceConstraint.constant = CGRectZero.size.height;
                         [self.view layoutIfNeeded];
                     }];



    
    [self keyboardWillHide:YES animationDuration:animationDuration];
}

#pragma mark - Transitions

static NSString * const kInitialToLoginSegue = @"PeopleLoginToSearchSegue";

#pragma mark - Login Workflow

- (IBAction)loginButtonPressed:(id)sender
{
    
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    PeopleValidation *validation = [[PeopleValidation alloc] init];
    NSError *validationError = nil;
    if ([validation validUsername:username password:password error:&validationError])
    {
        //TODO: login
    }
    else
    {
        //TODO: error treatment
    }
    
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField) {
        [self loginButtonPressed:textField];
    }
    [textField resignFirstResponder];
    return YES;
}


@end
