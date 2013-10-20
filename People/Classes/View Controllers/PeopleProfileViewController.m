//
//  PeopleProfileViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleProfileViewController.h"
#import "PeopleProfileDetailsView.h"
#import "PeopleProfileContactView.h"
#import "PeopleProfileCoachView.h"
#import "PeopleProfileTeamView.h"
#import "PeopleProfileProjectsView.h"
#import "PeopleServices.h"
#import "PeopleContactServices.h"
#import "NSString+PhoneNumberFormatter.h"

@interface PeopleProfileViewController ()
@property (nonatomic, strong) PeopleProfileDetailsView *detailView;
@property (nonatomic, strong) PeopleProfileContactView *phoneContactView;
@property (nonatomic, strong) PeopleProfileContactView *mobileContactView;
@property (nonatomic, strong) PeopleProfileContactView *emailContactView;
@property (nonatomic, strong) PeopleProfileCoachView *coachView;
@property (nonatomic, strong) PeopleProfileTeamView *teamView;
@property (nonatomic, strong) PeopleProfileProjectsView *projectsView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation PeopleProfileViewController

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
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    [self createViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self populate];
}

#pragma mark - View Creation
- (void)createViews
{
    CGFloat deltaY = 0;
    deltaY = self.navigationController.navigationBar.frame.size.height + 20.0; //statusbar
    [self createDetailViewStartingAtY:deltaY];
    deltaY += self.detailView.frame.size.height;
    
    [self createPhoneContactViewStartingAtY:deltaY];
    deltaY += self.phoneContactView.frame.size.height;
    
    [self createMobileContactViewStartingAtY:deltaY];
    deltaY += self.mobileContactView.frame.size.height;
    
    [self createEmailContactViewStartingAtY:deltaY];
    deltaY += self.emailContactView.frame.size.height;
    
    [self createCoachViewStartingAtY:deltaY];
    deltaY += self.coachView.frame.size.height;
    
    [self createTeamViewStartingAtY:deltaY];
    deltaY += self.teamView.frame.size.height;
    
    [self createProjectsViewStartingAtY:deltaY];
    deltaY += self.projectsView.frame.size.height;
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, deltaY)];
}

- (void)createCoachViewStartingAtY:(CGFloat)y
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PeopleProfileCoachView"
                                                      owner:self
                                                    options:nil];
    PeopleProfileCoachView *coachView = (PeopleProfileCoachView *)nibViews[0];
    [coachView setFrame:CGRectMake(0, y,
                                   coachView.frame.size.width, coachView.frame.size.height)];
    
    [self.scrollView addSubview:coachView];
    self.coachView = coachView;
}

- (void)createTeamViewStartingAtY:(CGFloat)y
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PeopleProfileTeamView"
                                                      owner:self
                                                    options:nil];
    PeopleProfileTeamView *teamView = (PeopleProfileTeamView *)nibViews[0];
    [teamView setFrame:CGRectMake(0, y,
                                  teamView.frame.size.width, teamView.frame.size.height)];
    
    [self.scrollView addSubview:teamView];
    self.teamView = teamView;
}

- (void)createProjectsViewStartingAtY:(CGFloat)y
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PeopleProfileProjectsView"
                                                      owner:self
                                                    options:nil];
    PeopleProfileProjectsView *projectsView = (PeopleProfileProjectsView *)nibViews[0];
    [projectsView setFrame:CGRectMake(0, y,
                                      projectsView.frame.size.width, projectsView.frame.size.height)];

    [self.scrollView addSubview:projectsView];
    self.projectsView = projectsView;
}

- (void)createPhoneContactViewStartingAtY:(CGFloat)y
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PeopleProfileContactView"
                                                      owner:self
                                                    options:nil];
    PeopleProfileContactView *phoneContactView = (PeopleProfileContactView *)nibViews[0];
    [phoneContactView setFrame:CGRectMake(0, y,
                                    phoneContactView.frame.size.width, phoneContactView.frame.size.height)];
    [self.scrollView addSubview:phoneContactView];
    self.phoneContactView = phoneContactView;

    
}

- (void)createMobileContactViewStartingAtY:(CGFloat)y
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PeopleProfileContactView"
                                                      owner:self
                                                    options:nil];
    PeopleProfileContactView *mobileContactView = (PeopleProfileContactView *)nibViews[0];
    [mobileContactView setFrame:CGRectMake(0, y,
                                          mobileContactView.frame.size.width, mobileContactView.frame.size.height)];
    [self.scrollView addSubview:mobileContactView];
    self.mobileContactView = mobileContactView;
}

- (void)createEmailContactViewStartingAtY:(CGFloat)y
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PeopleProfileContactView"
                                                      owner:self
                                                    options:nil];
    PeopleProfileContactView *emailContactView = (PeopleProfileContactView *)nibViews[0];
    [emailContactView setFrame:CGRectMake(0, y,
                                          emailContactView.frame.size.width, emailContactView.frame.size.height)];
    [self.scrollView addSubview:emailContactView];
    self.emailContactView = emailContactView;
}

- (void)createDetailViewStartingAtY:(CGFloat)y
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PeopleProfileDetailsView"
                                                      owner:self
                                                    options:nil];
    PeopleProfileDetailsView *detailView = (PeopleProfileDetailsView *)nibViews[0];
    [detailView setFrame:CGRectMake(0, y,
                                    detailView.frame.size.width, detailView.frame.size.height)];
    [self.scrollView addSubview:detailView];
    self.detailView = detailView;


}

- (void)setCollaborator:(PeopleCollaborator *)collaborator
{
    _collaborator = collaborator;
    self.title = collaborator.login;
    [self populate];
    [PeopleServices profileForUser:collaborator.login
                           success:^(PeopleCollaborator *collaboratorProfile) {
                               self.collaborator.teammates = collaboratorProfile.teammates;
                               self.collaborator.currentProjects = collaboratorProfile.currentProjects;
                               self.collaborator.pastProjects = collaboratorProfile.pastProjects;
                               self.collaborator.mentorName = collaboratorProfile.mentorName;
                               [self.coachView.nameButton setTitle:self.collaborator.mentorName
                                                          forState:UIControlStateNormal];
                               //                               [self populateTeamView];
                               //[self populateProjectsView];]
                           } failure:^(NSError *error) {
                               
                           }];

}

- (void)populate
{
    [self populateDetailView];
    [self populatePhoneContactView];
    [self populateMobileContactView];
    [self populateEmailContactView];
    [self populateCoachView];
}

- (void)populateCoachView
{
    [self.coachView.nameButton setTitle:self.collaborator.mentorLogin
                               forState:UIControlStateNormal];

    [PeopleServices photoForUser:self.collaborator.mentorLogin
                         success:^(UIImage *image) {
                             if ([image isKindOfClass:[UIImage class]])
                             {
                                 self.coachView.imageView.image = image;
                             }
                         } failure:^(NSError *error) {
                             
                         }];
    [self.coachView.nameButton addTarget:self
                                  action:@selector(openCoachProfile)
                        forControlEvents:UIControlEventTouchUpInside];
}

- (void)populatePhoneContactView
{
    self.phoneContactView.titleLabel.text = NSLocalizedString(@"Phone", @"");
    self.phoneContactView.contentLabel.text = [self.collaborator.phone stringValue];
    [self.phoneContactView.button2 setHidden:YES];
    [self.phoneContactView.button1 addTarget:self
                                      action:@selector(callPhone)
                            forControlEvents:UIControlEventTouchUpInside];
}

- (void)populateMobileContactView
{
    self.mobileContactView.titleLabel.text = NSLocalizedString(@"Mobile", @"");
    self.mobileContactView.contentLabel.text = [self.collaborator.mobile stringValue];
    
    [self.mobileContactView.button1 addTarget:self
                                       action:@selector(callMobile)
                             forControlEvents:UIControlEventTouchUpInside];
    
    [self.mobileContactView.button2 addTarget:self
                                       action:@selector(smsToMobile)
                             forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)populateEmailContactView
{
    self.emailContactView.titleLabel.text = NSLocalizedString(@"E-mail", @"");
    self.emailContactView.contentLabel.text = [self.collaborator.login ciandtEmail];
    
    [self.emailContactView.button2 setHidden:YES];
    [self.emailContactView.button1 addTarget:self
                                       action:@selector(email)
                             forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)populateDetailView
{
    self.detailView.nameLabel.text = self.collaborator.name;
    self.detailView.roleLabel.text = self.collaborator.role;
    self.detailView.locationLabel.text = self.collaborator.location;

    [PeopleServices photoForUser:self.collaborator.login
                         success:^(UIImage *image) {
                             self.detailView.imageView.image = image;
                         } failure:^(NSError *error) {
                             
                         }];

}

- (void)callPhone
{
    NSNumber *number = self.collaborator.phone;
    [[PeopleContactServices sharedServices] callPhoneNumber:number];
}

- (void)smsToMobile
{
    NSString *recipient = [self.collaborator.mobile stringValue];
    [[PeopleContactServices sharedServices] presentSMSComposerOnViewController:self
                                                                withRecipients:@[recipient]];
    
}

- (void)callMobile
{
    NSNumber *number = self.collaborator.mobile;
    [[PeopleContactServices sharedServices] callPhoneNumber:number];
}

-(void)email
{
    NSString *recipient = [self.collaborator.login ciandtEmail];
    [[PeopleContactServices sharedServices] presentEmailComposerOnViewController:self
                                                                  withRecipients:@[recipient]];
    
}

- (void)openCoachProfile
{
    [PeopleServices colaboradoresForSearchTerm:self.collaborator.mentorLogin
                                       success:^(NSArray *colaboradores) {
                                           PeopleCollaborator *mentor;
                                           if ([colaboradores count] > 1) //case: mentor == 'bruno'
                                           {
                                               mentor = [colaboradores filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"login MATCHES %@", self.collaborator.mentorLogin]][0];
                                           }
                                           else
                                           {
                                               mentor = colaboradores[0];
                                           }
                                           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
                                           PeopleProfileViewController *mentorProfile = [storyboard instantiateViewControllerWithIdentifier:@"PeopleProfileViewController"];
                                           [mentorProfile setCollaborator:mentor];
                                           [self.navigationController pushViewController:mentorProfile animated:YES];
                                           
                                       } failure:^(NSError *error) {
                                           
                                       }];
}

@end
