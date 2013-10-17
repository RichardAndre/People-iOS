//
//  PeopleLoginViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleLoginViewController.h"
#import "PeopleValidation.h"
#import "PeopleServices.h"
#import "PeoplePreferences.h"

@interface PeopleLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerBottomDistanceConstraint;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

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

//FIXME: Do we need the willHide parameter here?
- (void)keyboardWillHide:(BOOL)willHide
       animationDuration:(NSTimeInterval)animationDuration
          keyboardHeight:(CGFloat)height
{
    if (!willHide)
    {
        //TODO: animate up

    }
    else
    {
        //TODO: animate down
    }
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.containerBottomDistanceConstraint.constant = height;
                         [self.view layoutIfNeeded];
                     }];
}

- (void)keyboardWillAppear:(NSNotification*)notification
{
    NSTimeInterval animationDuration = [(NSNumber*)[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
   
    [self keyboardWillHide:NO
         animationDuration:animationDuration
            keyboardHeight:keyboardRect.size.height];
}

- (void)keyboardWillDisappear:(NSNotification*)notification
{
    NSTimeInterval animationDuration = [(NSNumber*)[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self keyboardWillHide:YES
         animationDuration:animationDuration
            keyboardHeight:CGRectZero.size.height];
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
        [self loginWithUsername:username password:password];
    }
    else
    {
        [self loginErrorWithError:validationError];
    }
    
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)performLoginSucceededOperationsWithColaborador:(PeopleCollaborator *)colaborador
{
    [PeoplePreferences setAutoLogin:YES];
    [PeoplePreferences setUsername:self.usernameTextField.text
                          password:self.passwordTextField.text];
    
    [self performSegueWithIdentifier:kInitialToLoginSegue sender:self];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL enabled = YES;
    
    if (([textField.text length] <=1) && ([string length] == 0)) {
        enabled = NO;
    }
    
    if (textField != self.usernameTextField && [self.usernameTextField.text length] == 0)
    {
        enabled = NO;
    }
    
    if (textField != self.passwordTextField && [self.passwordTextField.text length] == 0)
    {
        enabled = NO;
    }
    
    
    [self.loginButton setEnabled:enabled];
    
    return YES;
}

#pragma mark - Functionality

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    self.loginButton.enabled = NO;
    [PeopleServices loginWithUsername:username
                             password:password
                              success:^(PeopleCollaborator *colaborador) {
                                  [self performLoginSucceededOperationsWithColaborador:colaborador];
                              } failure:^(NSError *error) {
                                  [self loginErrorWithError:error];
                              }];
}

- (void)loginErrorWithError:(NSError *)error
{
    NSString *loginButtonTitle;
    NSString *userPadImageName;
    NSString *passPadImageName;
    switch (error.code) {
        case PeopleValidationErrorBlankUsernameOnly:
            userPadImageName = @"ico-user-error";
            passPadImageName = @"ico-pass-normal";
            loginButtonTitle = NSLocalizedString(@"Blank username!", @"");
            break;
        case PeopleValidationErrorBlankPasswordOnly:
            userPadImageName = @"ico-user-normal";
            passPadImageName = @"ico-pass-error";
            loginButtonTitle = NSLocalizedString(@"Blank password!", @"");
            break;
        case PeopleValidationErrorBlankUsernameAndPassword:
            userPadImageName = @"ico-user-error";
            passPadImageName = @"ico-pass-error";
            loginButtonTitle = NSLocalizedString(@"Blank username and password!", @"");
            break;
        default:
            userPadImageName = @"ico-user-normal";
            passPadImageName = @"ico-pass-normal";
            loginButtonTitle = NSLocalizedString(@"Server Error!", @"");
            break;
    }
    
    [self.loginButton setTitle:loginButtonTitle forState:UIControlStateNormal];
    self.loginButton.enabled = YES;
    
}



@end
