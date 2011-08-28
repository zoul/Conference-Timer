#import "SettingsController.h"

static const NSTimeInterval SecondsPerMinute = 60;

@implementation SettingsController
@synthesize stopButton, resetButton, timeSlider, timeLabel, clockRunning, delegate;

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
    [timeSlider setEnabled:!clockRunning];
    [resetButton setEnabled:!clockRunning];
    [stopButton setTitle:clockRunning ? @"Stop" : @"Start" forState:UIControlStateNormal];
    [timeLabel setText:[NSString stringWithFormat:@"Talk Time: %i minute%s",
        (NSInteger) [timeSlider value], [timeSlider value] == 1 ? "" : "s"]];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

#pragma Controls

- (IBAction) toggleClock
{
    [delegate toggleClock];
}

- (IBAction) resetTalkTime
{
    [delegate resetTalkTime];
}

- (IBAction) changeTalkDuration: (UISlider*) sender
{
    [delegate setTalkDuration:[sender value]];
    [self updateUI];
}

#pragma mark Talk Time

- (void) setTalkDuration: (NSTimeInterval) duration
{
    [timeSlider setValue:ceil(duration / SecondsPerMinute)];
}

- (NSTimeInterval) talkDuration
{
    return floor([timeSlider value]) * SecondsPerMinute;
}

#pragma mark Events

- (void) setClockRunning: (BOOL) running
{
    if (running != clockRunning) {
        clockRunning = running;
        [self updateUI];
    }
}

@end
