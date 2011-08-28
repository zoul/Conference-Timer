#import "MainScreenController.h"
#import "SettingsController.h"
#import "Talk.h"

@interface MainScreenController () <TalkDelegate, SettingsDelegate>
@property(retain) Talk *talk;
@end

@implementation MainScreenController
@synthesize display, settingsController, talk, bellSound;

#pragma mark Initialization

- (void) dealloc
{
    [talk release];
    [display release];
    [settingsController release];
    [bellSound release];
    [super dealloc];
}

- (void) updateUI
{
    NSUInteger secondsRemaining = [talk currentTime];
    [display setText:[NSString stringWithFormat:@"%02i:%02i",
        secondsRemaining / 60, secondsRemaining % 60]];
}

- (void) startNewTalk
{
    [self setTalk:[Talk talkWithDuration:[settingsController talkDuration]]];
    [talk setDelegate:self];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    [settingsController setDelegate:self];
    [self startNewTalk];
    [self updateUI];
}

- (IBAction) displaySettingsFrom: (UIButton*) sender
{
    // TODO: The popover probably leaks
    UIPopoverController *popover = [[UIPopoverController alloc]
        initWithContentViewController:settingsController];
    [popover setPopoverContentSize:[[settingsController view] bounds].size];
    [popover presentPopoverFromRect:[sender frame] inView:[sender superview]
        permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark Settings Delegate

- (void) setTalkDuration: (NSTimeInterval) duration
{
    [self startNewTalk];
    [self updateUI];
}

- (void) toggleClock
{
    SEL action = [talk isRunning] ? @selector(stopClock) : @selector(startClock);
    [talk performSelector:action];
}

- (void) resetTalkTime
{
    [self startNewTalk];
    [self updateUI];
}

#pragma mark Talk Delegate

- (void) talkDidStart: (Talk*) talk
{
    [settingsController setClockRunning:YES];
}

- (void) talkDidStop: (Talk*) talk
{
    [settingsController setClockRunning:NO];
}

- (void) talkTimeDidChange: (Talk*) talk
{
    [self updateUI];
}

- (void) talkDidFinish: (Talk*) talk
{
    [bellSound play];
}

#pragma mark Housekeeping

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    return YES;
}

@end
