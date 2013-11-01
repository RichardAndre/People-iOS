//
//  PeopleTeamViewAllViewController.m
//  People
//
//  Created by Bruno Koga on 11/1/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleTeamViewAllViewController.h"
#import <iOS-blur/AMBlurView.h>
#import "PeopleServices.h"

@interface PeopleTeamViewAllViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIView *teamView;

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

    [self createTeamMemberButtons];
    [self downloadPictures];
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

static CGFloat const kPhotoButtonWidth = 44.0;
static CGFloat const kPhotoButtonSpacing = 15.0;


- (void)createTeamMemberButtons
{
    for (UIButton *button in [self.teamView subviews])
    {
        [button removeFromSuperview];
    }
    
    CGFloat offset = 20;
    CGFloat offsetY = 64;
    
    for (NSInteger i = 0; i < [self.teamMembers count]; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setFrame:CGRectMake(offset,
                                    offsetY,
                                    kPhotoButtonWidth, kPhotoButtonWidth)];
        button.layer.cornerRadius = button.frame.size.height/2;
        [button setClipsToBounds:YES];
        [button addTarget:self
                   action:@selector(buttonTouched:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.teamView addSubview:button];
        offset += kPhotoButtonWidth + kPhotoButtonSpacing;
        if (offset > 280)
        {
            offset = 20;
            offsetY += 60;
        }
    }
}

- (void)setTeamMemberPicture:(UIImage *)image forIndex:(NSInteger)index
{
    [(UIButton *)self.teamView.subviews[index] setImage:image
                                           forState:UIControlStateNormal];
}

- (void)downloadPictures
{
    NSDictionary *member;
    NSString *memberLogin;
    for (NSInteger i = 0; i < [self.teamMembers count]; i++)
    {
        member = self.teamMembers[i];
        memberLogin = member[@"login"];
        
        [PeopleServices photoForUser:memberLogin
                             success:^(UIImage *image) {
                                 if ([image isKindOfClass:[UIImage class]])
                                 {
                                     [self setTeamMemberPicture:image forIndex:i];
                                 }
                             } failure:^(NSError *error) {
                                 
                             }];
    }

}

- (void)buttonTouched:(id)sender
{
    NSUInteger index = [self.teamView.subviews indexOfObject:sender];
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 [self.delegate openProfileForUser:self.teamMembers[index]];
                             }];
    
}

@end
