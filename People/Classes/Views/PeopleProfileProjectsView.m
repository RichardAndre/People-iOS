//
//  PeopleProfileProjectsView.m
//  People
//
//  Created by Bruno Koga on 10/20/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleProfileProjectsView.h"
#import "PeopleThemeManager.h"

@interface PeopleProfileProjectsView ()
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *pastLabel;

@end
@implementation PeopleProfileProjectsView

- (id)init
{
    self = [super init];
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
    [self adjustFonts];
}

- (void)adjustFonts
{
    
     id<PeopleTheme> theme = [PeopleThemeManager theme];
    [self.currentLabel setFont:[theme lightFontWithSize:self.currentLabel.font.pointSize]];
    [self.pastLabel setFont:[theme lightFontWithSize:self.pastLabel.font.pointSize]];
}

#pragma mark - Setter Override

- (void)setPastProjects:(NSArray *)pastProjects
{
    _pastProjects = pastProjects;
    [self redraw];
}

- (void)setCurrentProjects:(NSArray *)currentProjects
{
    _currentProjects = currentProjects;
    [self redraw];
}
- (void)setPastProjects:(NSArray *)pastProjects currentProjects:(NSArray *)currentProjects
{
    _currentProjects = currentProjects;
    _pastProjects = pastProjects;
    [self redraw];
}

- (void)redraw
{
    NSString *currentText = NSLocalizedString(@"Current", @"Current Projects Label on Profile Screen");
    currentText = [currentText stringByAppendingString:@"\n"];
    NSString *pastText = NSLocalizedString(@"Past", @"Past Projects Label on Profile Screen");
    pastText = [pastText stringByAppendingString:@"\n"];
    
    // build Attributed Text Mechanism
    NSMutableAttributedString *currentAttributedText = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *pastAttributedText = [[NSMutableAttributedString alloc] initWithString:@""];
    
    
    NSString *currentProjects = [self.currentProjects componentsJoinedByString:@", "];
    NSString *pastProjects = [self.pastProjects componentsJoinedByString:@", "];
    
    
    if (currentProjects)
    {
        NSString *currentProjectsString = [currentText stringByAppendingString:currentProjects];
        currentAttributedText = [[NSMutableAttributedString alloc] initWithString:currentProjectsString];
        
        UIColor *projectCategoryTitleColor = [UIColor grayColor];
        [currentAttributedText addAttribute:NSForegroundColorAttributeName
                                      value:projectCategoryTitleColor
                                      range:NSMakeRange(0, [currentText length])];
    
    }
    if (pastProjects)
    {
        NSString *pastProjectsString = [pastText stringByAppendingString:pastProjects];
        pastAttributedText = [[NSMutableAttributedString alloc] initWithString:pastProjectsString];
        
        UIColor *projectCategoryTitleColor = [UIColor grayColor];
        [pastAttributedText addAttribute:NSForegroundColorAttributeName
                                   value:projectCategoryTitleColor
                                   range:NSMakeRange(0, [pastText length])];
        
    }
    
    [self.currentLabel setAttributedText:currentAttributedText];
    [self.pastLabel setAttributedText:pastAttributedText];
    [self.currentLabel sizeToFit];
    [self.pastLabel sizeToFit];
    [self.pastLabel setFrame:CGRectMake(self.pastLabel.frame.origin.x,
                                       self.currentLabel.frame.size.height + 30.0,
                                        self.pastLabel.frame.size.width, self.pastLabel.frame.size.height)];

}

- (CGFloat)totalHeight
{
    CGFloat returnValue = 0;
    returnValue = self.pastLabel.frame.origin.y + self.pastLabel.frame.size.height;
    return returnValue;
}

@end
