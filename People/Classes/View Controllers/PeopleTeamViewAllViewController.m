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
@property (weak, nonatomic) IBOutlet UIScrollView *teamView;

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
    [blurView setBlurTintColor:[UIColor whiteColor]];
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

static CGFloat const kPhotoButtonWidth = 48.0;
static CGFloat const kPhotoButtonSpacing = 30.0;


- (void)createTeamMemberButtons
{
    for (UIButton *button in [self.teamView subviews])
    {
        [button removeFromSuperview];
    }
    
    CGFloat offset = 19;
    CGFloat offsetY = 0;
    CGFloat content = 20;
    
    for (NSInteger i = 0; i < [self.teamMembers count]; i++) {
        UIButton *button = [[UIButton alloc] init];
        UILabel *label = [[UILabel alloc] init];
        [label setFrame:CGRectMake(offset - 10,
                                  offsetY + 54,
                                  kPhotoButtonWidth + 20, 20)];
        [label setTextAlignment:NSTextAlignmentCenter];
        UIFont *loginFont = [UIFont fontWithName:@"Roboto-Regular" size:12.0];
        
        [label setTextColor:[UIColor blackColor]];
        [label setFont:loginFont];
        
        [button setFrame:CGRectMake(offset,
                                    offsetY,
                                    kPhotoButtonWidth, kPhotoButtonWidth)];
        button.layer.cornerRadius = button.frame.size.height/2;
        [button setClipsToBounds:YES];
        [button addTarget:self
                   action:@selector(buttonTouched:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.teamView addSubview:button];
        [self.teamView addSubview:label];
        offset += kPhotoButtonWidth + kPhotoButtonSpacing;
        if (offset > 280)
        {
            offset = 19;
            offsetY += 80;
        }
        if(i % 4 == 0){
           content += 80;
        }
    }
    if([self.teamMembers count] > 20 ){
        content += 80;
    }
    
    self.teamView.contentSize = CGSizeMake(320, content);
}

- (void)setTeamMemberPicture:(UIImage *)image andLogin:(NSString *)login forIndex:(NSInteger)index
{
    [(UILabel *)self.teamView.subviews[index*2+1] setText:login];
    [(UIButton *)self.teamView.subviews[index*2] setImage:image
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
                                     [self setTeamMemberPicture:image andLogin:memberLogin forIndex:i];
                                 }
                             } failure:^(NSError *error) {
                                 
                             }];
    }

}

- (void)buttonTouched:(id)sender
{
    NSUInteger index = [self.teamView.subviews indexOfObject:sender] / 2;
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 [self.delegate openProfileForUser:self.teamMembers[index]];
                             }];
    
}

@end
