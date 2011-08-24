#import "SettingsController.h"

@interface MainScreenController : UIViewController <SettingsDelegate>

@property(retain) IBOutlet UILabel *timeLabel;
@property(retain) SettingsController *settingsController;
@property(readonly) BOOL talkInProgress;

- (IBAction) displaySettings: (id) sender;

@end
