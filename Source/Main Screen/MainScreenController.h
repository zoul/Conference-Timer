@class SettingsController;

@interface MainScreenController : UIViewController

@property(retain) IBOutlet UILabel  *display;
@property(retain) AVAudioPlayer *bellSound;
@property(retain) SettingsController *settingsController;

- (IBAction) displaySettingsFrom: (UIButton*) sender;

@end
