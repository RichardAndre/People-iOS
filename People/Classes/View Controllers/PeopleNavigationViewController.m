//
//  PeopleNavigationViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleNavigationViewController.h"
#import "PeopleActionMenuViewController.h"
#import "PeopleLoginViewController.h"
#import "PeopleProfileViewController.h"
#import "PeopleBaseViewController.h"

@interface PeopleNavigationViewController ()

@property (nonatomic, strong) PeopleActionMenuViewController *menuVC;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) NSInteger lastValidX;
@property (nonatomic, assign) NSInteger firstX;
@property (nonatomic, assign) NSInteger firstY;
@property (nonatomic, assign) BOOL isSideMenuOpen;
@property (nonatomic, assign) BOOL menuEnable;
@property (nonatomic, assign) CGFloat openDistance;
@property (nonatomic, assign) CGFloat openRightContentX;
@property (nonatomic, assign) CGFloat closeContentX;
@property (nonatomic, assign) CGFloat elasticMargin;
@property (nonatomic, assign) UIViewController *showViewController;

@end

static CGFloat const CITSidebarAnimationDuration = 0.3f;
static CGFloat const CITSidebarDelayDuration = 0.0f;
static CGFloat const CITSidebarRightContentDistance = 266.0f;

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
    self.delegate = self;
    self.menuVC = [PeopleActionMenuViewController new];
    CGRect menuFrame = self.menuVC.view.frame;
    menuFrame.origin.x = self.view.frame.size.width;
    
    self.menuVC.view.frame = menuFrame;
    self.menuVC.navigation = self;
    [self.view addSubview:self.menuVC.view];
    
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [_pan setDelegate:self];
    [_pan setMinimumNumberOfTouches:1];
    [_pan setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:_pan];
    
    _openDistance = CITSidebarRightContentDistance;
    _openRightContentX = self.view.frame.size.width - (self.menuVC.view.frame.size.width/2) ;
    _closeContentX = self.view.frame.size.width + (self.menuVC.view.frame.size.width/2);
    _elasticMargin = 0;
    _menuEnable = YES;
	// Do any additional setup after loading the view.
}

- (void)onPan:(id)sender{
    
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    CGPoint translatedPoint = [pan translationInView:self.menuVC.view];
    
    if ([pan state] == UIGestureRecognizerStateBegan) {
        
        _lastValidX = [pan locationInView:self.view].x;
        _firstX = [self.menuVC.view center].x;
        _firstY = [self.menuVC.view center].y;
    }
    
    CGFloat dragX;
    if (translatedPoint.x > 0) {
        dragX = _firstX+translatedPoint.x-30;
    }else{
        dragX = _firstX+translatedPoint.x+30;
    }
    if (translatedPoint.x > 30.0 || translatedPoint.x < -30.0) {
        
        if (dragX < _openRightContentX) {
            dragX = _openRightContentX;
        }
        if (!_menuEnable) {
            if (dragX < _closeContentX) {
                dragX = _closeContentX;
            }
        }
        
        translatedPoint = CGPointMake(dragX, _firstY);
        [self.menuVC.view setCenter:translatedPoint];
    }
    
    
    if ([pan state] == UIGestureRecognizerStateEnded) {
        CGFloat velocityX = (0.5*[pan velocityInView:self.view].x);
        
        CGFloat finalX = _closeContentX;
        if (velocityX  < 0) {
            if (dragX < _closeContentX && _menuEnable) {
                finalX = _openRightContentX;
                self.isSideMenuOpen = YES;
                self.visibleViewController.view.userInteractionEnabled = NO;
            }
            else
            {
                finalX = _closeContentX;
                self.isSideMenuOpen = NO;
            }
        } else {
      
            finalX = _closeContentX;
            self.isSideMenuOpen = NO;
            self.visibleViewController.view.userInteractionEnabled = YES;
        

        }
        
        CGFloat animationDuration = (ABS(velocityX)*.00004)+.2;
        [self.pan setEnabled:NO];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
        [self.menuVC.view setCenter:CGPointMake(finalX, _firstY)];
        [UIView commitAnimations];
        
        ((PeopleBaseViewController *)self.showViewController).statusBarHidden = self.isSideMenuOpen;
        
        [self.showViewController setNeedsStatusBarAppearanceUpdate];
        
        
    }
}

-(void)closeMenu {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [self.menuVC.view setCenter:CGPointMake(_closeContentX, _firstY)];
    [UIView commitAnimations];
    self.isSideMenuOpen = NO;
    [self.pan setEnabled:NO];
}

- (void)animationDidFinish{
    [self.pan setEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.isSideMenuOpen){
        [self closeMenu];
    }
    if(![viewController isKindOfClass:[PeopleLoginViewController class]]){
        [self.menuVC populateMenu];
        [self.pan setEnabled:YES];
        self.showViewController = viewController;
    } else {
        
        [self.menuVC changeHasPeople];
        [self.pan setEnabled:NO];
    }
}

@end
