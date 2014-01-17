//
//  PeopleSearchTableViewCell.m
//  People
//
//  Created by Bruno Koga on 10/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchTableViewCell.h"
#import "HHPanningTableViewCell_Private.h"
#import "PeopleContactServices.h"
#import "NSString+PhoneNumberFormatter.h"
#import "PeopleThemeManager.h"

@interface PeopleSearchTableViewCell ()
@property (nonatomic, strong) UIView *persistentDrawerView;

@end
@implementation PeopleSearchTableViewCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    [self setupDrawer];
    [self adjustFonts];
//    self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.height/2;
//    self.photoImageView.layer.borderWidth = 1.0f;
//    self.photoImageView.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f
//                                                            green:242.0f/255.0f
//                                                             blue:244.0f/255.0f
//                                                            alpha:1.0f] CGColor];
    [self.photoImageView setClipsToBounds:YES];

}
- (void)adjustFonts
{
    id<PeopleTheme> theme = [PeopleThemeManager theme];
    [self.nameLabel setFont:[theme mediumFontWithSize:self.nameLabel.font.pointSize]];
    [self.roleLabel setFont:[theme mediumFontWithSize:self.roleLabel.font.pointSize]];
    [self.loginLabel setFont:[theme mediumFontWithSize:self.loginLabel.font.pointSize]];
    [self.telLabel setFont:[theme regularNumberFontWithSize:self.telLabel.font.pointSize]];
    [self.mobileLabel setFont:[theme regularNumberFontWithSize:self.mobileLabel.font.pointSize]];
}

- (void)setupDrawer
{
    self.directionMask = 1;

    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PeopleSearchDrawerCell"
                                                      owner:self
                                                    options:nil];
    UIView *drawerView = (UIView *)nibViews[0];
    self.persistentDrawerView = drawerView;
    self.drawerView = drawerView;
}
static CGFloat const kPhotoOffset = 76.0;

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.drawerView = self.persistentDrawerView;
    self.directionMask = 1;
}

#pragma mark - Actions

- (IBAction)telButtonPressed:(id)sender
{
    NSNumber *number = @([self.telLabel.text integerValue]);
    [[PeopleContactServices sharedServices] callPhoneNumber:number];
}

- (IBAction)mobileButtonPressed:(id)sender
{
    NSNumber *number = @([self.mobileLabel.text integerValue]);
    [[PeopleContactServices sharedServices] callPhoneNumber:number];
}

- (IBAction)emailButtonPressed:(id)sender
{
    NSString *recipient = [self.loginLabel.text ciandtEmail];
    [[PeopleContactServices sharedServices] presentEmailComposerOnViewController:self.viewController
                                                                  withRecipients:@[recipient]];

}

- (IBAction)smsButtonPressed:(id)sender
{
    NSString *recipient = self.mobileLabel.text;
    [[PeopleContactServices sharedServices] presentSMSComposerOnViewController:self.viewController
                                                                withRecipients:@[recipient]];

}
#pragma mark - Superclass overriding

/*
 *
 * We're overriding this method because the original library doesn't support
 * partial-opened drawer.
 * To do so, I created a HHPanningTableViewCell_Private.h exposing some methods
 * and properties that I needed to correctly override this method.
 *
 */

- (void)setDrawerRevealed:(BOOL)revealed direction:(HHPanningTableViewCellDirection)direction animated:(BOOL)animated
{
	if ([self isEditing] || (self.drawerView == nil)) {
		return;
	}
    
	self.drawerRevealed = revealed;
    
	UIView	*drawerView		= self.drawerView;
	UIView	*shadowView		= self.shadowView;
	UIView	*contentView	= self.contentView;
    
	CGFloat duration		= animated ? HH_PANNING_ANIMATION_DURATION : 0.0f;
    
	if (revealed) {
		CGRect	bounds		= [contentView frame];
		CGFloat translation = 0.0f;
        
		if (direction == HHPanningTableViewCellDirectionRight) {
			translation = bounds.size.width -kPhotoOffset;
		}
		else {
			translation = -bounds.size.width +kPhotoOffset;
		}
        
		[self installViews];
        
		self.animationInProgress = YES;
        
		void	(^animations)(void) = ^{
			self.translation = translation;
		};
        
		void	(^completion)(BOOL finished) = ^(BOOL finished) {
			self.animationInProgress = NO;
		};
        
		if (animated) {
			[UIView animateWithDuration:HH_PANNING_ANIMATION_DURATION
								  delay:0.0f
								options:UIViewAnimationOptionCurveEaseOut
							 animations:animations
							 completion:completion];
		}
		else {
			animations();
			completion(YES);
		}
	}
	else {
		void	(^animations)(void) = ^{
			self.translation = 0.0f;
		};
        
		self.animationInProgress = YES;
        
		void	(^completion)(BOOL finished) = ^(BOOL finished) {
			[drawerView removeFromSuperview];
			[shadowView removeFromSuperview];
            
			self.animationInProgress = NO;
		};
        
		if (animated) {
			BOOL shouldBounce = self.shouldBounce;
            
			if (shouldBounce) {
				CGFloat bounceDuration		= duration;
				CGFloat translation			= self.translation;
				CGFloat bounceMultiplier	= fminf(fabsf(translation / HH_PANNING_TRIGGER_OFFSET), 1.0f);
				CGFloat bounceTranslation	= bounceMultiplier * HH_PANNING_BOUNCE_DISTANCE;
                
				if (translation < 0.0f) {
					bounceTranslation *= -1.0;
				}
                
				[UIView animateWithDuration:duration
									  delay:0.0f
									options:UIViewAnimationOptionCurveEaseOut
								 animations:animations
								 completion:^(BOOL finished) {
									 [UIView animateWithDuration:bounceDuration
														   delay:0.0f
														 options:UIViewAnimationOptionCurveLinear
													  animations:^{
														  self.translation = bounceTranslation;
													  } completion:^(BOOL finished) {
														  [UIView animateWithDuration:bounceDuration
																				delay:0.0f
																			  options:UIViewAnimationOptionCurveLinear
																		   animations:animations
																		   completion:completion];
													  }];
								 }];
			}
			else {
				[UIView animateWithDuration:duration
									  delay:0.0f
									options:UIViewAnimationOptionCurveEaseOut
								 animations:animations
								 completion:completion];
			}
		}
		else {
			animations();
			completion(YES);
		}
	}
}

@end
