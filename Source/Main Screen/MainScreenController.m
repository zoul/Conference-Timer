#import "MainScreenController.h"
#import "SettingsController.h"

@interface MainScreenController ()
@property(retain) NSTimer *timer;
@property(assign) NSUInteger secondsRemaining;
@end

@implementation MainScreenController
@synthesize timeLabel, settingsController, timer, secondsRemaining;

- (void) dealloc
{
    [timer release];
    [timeLabel release];
    [settingsController release];
    [super dealloc];
}

- (void) updateUI
{
    [timeLabel setText:[NSString stringWithFormat:@"%02i:%02i",
        secondsRemaining / 60, secondsRemaining % 60]];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    [settingsController setDelegate:self];
    [self setSecondsRemaining:[settingsController fullTalkMinutes]*60];
    [self updateUI];
}

- (IBAction) displaySettings: (id) sender
{
    UIPopoverController *popover = [[UIPopoverController alloc]
        initWithContentViewController:settingsController];
    [popover setPopoverContentSize:[[settingsController view] bounds].size];
    [popover presentPopoverFromRect:[sender frame] inView:[sender superview]
        permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (BOOL) talkInProgress
{
    return (timer != nil);
}

- (void) updateTime
{
    secondsRemaining--;
    [self updateUI];
    if (secondsRemaining == 0) {
        [self stopCurrentTalk];
    }
}

#pragma mark Settings Delegate

- (void) setFullTalkTime: (NSUInteger) minutes
{
    [self setSecondsRemaining:minutes*60];
    [self updateUI];
}

- (void) startNewTalk
{
    NSParameterAssert(![self talkInProgress]);
    [self setSecondsRemaining:[settingsController fullTalkMinutes]*60];
    [settingsController setTalkInProgress:YES];
    [self setTimer:[NSTimer scheduledTimerWithTimeInterval:1 target:self
        selector:@selector(updateTime) userInfo:nil repeats:YES]];
}

- (void) stopCurrentTalk
{
    [settingsController setTalkInProgress:NO];
    [timer invalidate];
    [self setTimer:nil];
}

- (void) resetTalkTime
{
    [self setSecondsRemaining:[settingsController fullTalkMinutes]*60];
    [self updateUI];
}

#pragma mark Housekeeping

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    return YES;
}

@end
