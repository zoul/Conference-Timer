#import "Factory.h"
#import "SettingsController.h"

@implementation Factory

- (SettingsController*) buildSettingsController
{
    SettingsController *controller = [[SettingsController alloc] initWithNibName:nil bundle:nil];
    [controller view];
    [controller setFullTalkMinutes:15];
    return [controller autorelease];
}

- (MainScreenController*) buildMainScreenController
{
    MainScreenController *controller = [[MainScreenController alloc] initWithNibName:nil bundle:nil];
    [controller setSettingsController:[self buildSettingsController]];
    return [controller autorelease];
}

@end
