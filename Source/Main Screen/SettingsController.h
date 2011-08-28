@protocol SettingsDelegate <NSObject>
- (void) setTalkDuration: (NSTimeInterval) minutes;
- (void) resetTalkTime;
- (void) toggleClock;
@end

@interface SettingsController : UIViewController

@property(retain) IBOutlet UIButton *stopButton;
@property(retain) IBOutlet UIButton *resetButton;
@property(retain) IBOutlet UISlider *timeSlider;
@property(retain) IBOutlet UILabel  *timeLabel;

@property(assign, nonatomic) NSTimeInterval talkDuration;
@property(assign, nonatomic) BOOL clockRunning;

@property(assign) id<SettingsDelegate> delegate;

- (IBAction) changeTalkDuration: (UISlider*) sender;
- (IBAction) resetTalkTime;
- (IBAction) toggleClock;

@end
