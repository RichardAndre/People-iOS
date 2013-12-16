//
//  PeopleNavigationViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleNavigationViewController.h"
#import "PeopleActionMenuViewController.h"

@interface PeopleNavigationViewController ()

@property (nonatomic, strong) PeopleActionMenuViewController *menuVC;

@end

@implementation PeopleNavigationViewController

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
    self.menuVC = [PeopleActionMenuViewController new];
    CGRect menuFrame = self.menuVC.view.frame;
    menuFrame.origin.x = self.view.frame.size.width;
    self.menuVC.view.frame = menuFrame;
    [self.view addSubview:self.menuVC.view];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self.view addGestureRecognizer:pan];
	// Do any additional setup after loading the view.
}

- (void)onPan:(UIPanGestureRecognizer *)pan
{
    CGPoint location = [pan locationInView:self.view];
    BOOL rightSwipe = (location.x > (self.view.frame.size.width / 5) * 4);
//    if (rightSwipe && pan.direction = UIPA)
    {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
