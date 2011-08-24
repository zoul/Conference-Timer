#import "SettingsController.h"

@implementation SettingsController
@synthesize stopButton, resetButton, timeSlider, timeLabel, timeRunning, delegate;

- (void) dealloc
{
    [stopButton release];
    [resetButton release];
    [timeSlider release];
    [timeLabel release];
    [super dealloc];
}

- (void) updateUI
{
    [timeSlider setEnabled:!timeRunning];
    [resetButton setEnabled:!timeRunning];
    [stopButton setTitle:timeRunning ? @"Stop" : @"Start" forState:UIControlStateNormal];
    [timeLabel setText:[NSString stringWithFormat:@"Talk Time: %i minute%s",
        (NSInteger) [timeSlider value], [timeSlider value] == 1 ? "" : "s"]];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

#pragma Controls

- (IBAction) toggleRunning
{
    SEL action = timeRunning ? @selector(stopCurrentTalk) : @selector(startNewTalk);
    [delegate performSelector:action];
}

- (IBAction) resetTime
{
    [delegate resetTalkTime];
}

#pragma mark Talk Time

- (void) setFullTalkMinutes: (NSUInteger) talkTime
{
    [timeSlider setValue:talkTime];
}

- (NSUInteger) fullTalkMinutes
{
    return [timeSlider value];
}

- (IBAction) talkTimeDidChange: (UISlider*) sender
{
    [delegate setFullTalkTime:[sender value]];
    [self updateUI];
}

#pragma mark Events

- (void) setTimeRunning: (BOOL) running
{
    if (running != timeRunning) {
        timeRunning = running;
        [self updateUI];
    }
}

@end
