@protocol SettingsDelegate <NSObject>
- (void) setFullTalkTime: (NSUInteger) minutes;
- (void) startNewTalk;
- (void) stopCurrentTalk;
- (void) resetTalkTime;
@end

@interface SettingsController : UIViewController

@property(retain) IBOutlet UIButton *stopButton;
@property(retain) IBOutlet UIButton *resetButton;
@property(retain) IBOutlet UISlider *timeSlider;
@property(retain) IBOutlet UILabel  *timeLabel;

@property(assign, nonatomic) NSUInteger fullTalkMinutes;
@property(assign, nonatomic) BOOL talkInProgress;

@property(assign) id<SettingsDelegate> delegate;

- (IBAction) talkTimeDidChange: (UISlider*) sender;
- (IBAction) toggleRunning;
- (IBAction) resetTime;

@end
