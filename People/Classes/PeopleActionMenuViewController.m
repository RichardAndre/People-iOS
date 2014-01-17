//
//  PeopleActionMenuViewController.m
//  People
//
//  Created by Christian Sampaio on 12/16/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleActionMenuViewController.h"
#import "PeopleThemeManager.h"
#import "PeoplePreferences.h"
#import "PeopleLoginViewController.h"
#import "PeopleCollaborator.h"
#import "PeopleServices.h"
#import <iOS-blur/AMBlurView.h>

@interface PeopleActionMenuViewController ()
@property (weak, nonatomic) IBOutlet UIView *logoutView;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *peopleImage;
@property (assign, nonatomic) BOOL hasPeople;


@end

@implementation PeopleActionMenuViewController

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
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    AMBlurView *blurView = [AMBlurView new];
    [blurView setBlurTintColor:[theme primaryColorMenu]];
    [blurView setFrame:self.view.bounds];
    [self.view insertSubview:blurView
                belowSubview:_logoutView];
    self.peopleImage.layer.cornerRadius = self.peopleImage.frame.size.height/2;
    [self.peopleImage setClipsToBounds:YES];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)populateMenu{
    if(!_hasPeople){
        NSString *username = [PeoplePreferences username];
        [PeopleServices profileForUser:username
                               success:^(PeopleCollaborator *colaborador) {
                                   self.loginLabel.text = colaborador.login;
                                   self.nameLabel.text = colaborador.name;
                                   self.positionLabel.text = colaborador.role;
                                   [PeopleServices photoForUser:username
                                                        success:^(UIImage *image) {
                                                            _hasPeople = YES;
                                                            [self.peopleImage setImage:image];
                                                        } failure:nil];
                               } failure:nil];
    }
    
}

- (IBAction)logout:(id)sender {
    [PeoplePreferences resetUsernameAndPassword];
    [self.navigation closeMenu];
    for (UIViewController *controller in self.navigation.viewControllers){
        if(![controller isKindOfClass:[PeopleLoginViewController class]]){
            [self.navigation popViewControllerAnimated:NO];
        }
    }
}

-(void)changeHasPeople{
    _hasPeople = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
