
#define HH_PANNING_TRIGGER_OFFSET		100.0f
#define HH_PANNING_BOUNCE_DISTANCE		10.0f
#define HH_PANNING_ANIMATION_DURATION	0.1f


@interface HHPanningTableViewCell (Private)

@property (nonatomic, assign, getter = isDrawerRevealed) BOOL drawerRevealed;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, assign) CGFloat translation;
@property (nonatomic, assign, getter = isAnimationInProgress) BOOL animationInProgress;

- (void)installViews;
@end

