//
//  PeopleTeamViewAllViewController.m
//  People
//
//  Created by Bruno Koga on 11/1/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleTeamViewAllViewController.h"
#import <iOS-blur/AMBlurView.h>

@interface PeopleTeamViewAllViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation PeopleTeamViewAllViewController

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
    self.backgroundImageView.image = self.backgroundImage;
    AMBlurView *blurView = [AMBlurView new];
    [blurView setBlurTintColor:[UIColor clearColor]];
    [blurView setFrame:self.view.bounds];
    [self.view insertSubview:blurView
                aboveSubview:self.backgroundImageView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:^{
    
                             }];
}
@end
