#import "Factory.h"
#import "SettingsController.h"

@implementation Factory

- (AVAudioPlayer*) buildBellSound
{
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"bell" withExtension:@"mp3"];
    AVAudioPlayer *sound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:NULL];
    [sound prepareToPlay];
    return [sound autorelease];
}

- (SettingsController*) buildSettingsController
{
    SettingsController *controller = [[SettingsController alloc] initWithNibName:nil bundle:nil];
    [controller view];
    [controller setTalkDuration:15*60];
    return [controller autorelease];
}

- (MainScreenController*) buildMainScreenController
{
    MainScreenController *controller = [[MainScreenController alloc] initWithNibName:nil bundle:nil];
    [controller setSettingsController:[self buildSettingsController]];
    [controller setBellSound:[self buildBellSound]];
    return [controller autorelease];
}

@end
