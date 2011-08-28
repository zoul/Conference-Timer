#import "Talk.h"

static const NSTimeInterval SecondsPerMinute = 60;
static const NSTimeInterval DefaultTalkDuration = 15*SecondsPerMinute;

@interface Talk ()
@property(assign) NSTimeInterval duration;
@property(assign) NSTimeInterval currentTime;
@property(assign) BOOL isRunning;
@property(retain) NSTimer *timer;
@end

@implementation Talk
@synthesize duration, currentTime, isRunning, timer, delegate;

#pragma mark Initialization

+ (id) talkWithDuration: (NSTimeInterval) duration
{
    return [[[self alloc] initWithDuration:duration] autorelease];
}

- (id) initWithDuration: (NSTimeInterval) newDuration
{
    self = [super init];
    [self setDuration:newDuration];
    [self setCurrentTime:duration];
    return self;
}

- (id) init
{
    return [self initWithDuration:DefaultTalkDuration];
}

- (void) dealloc
{
    NSParameterAssert(![self isRunning]);
    [super dealloc];
}

#pragma mark Controls

- (void) startClock
{
    if (![self isRunning]) {
        LOG(@"Talk %@ started.", self);
        [self setTimer:[NSTimer scheduledTimerWithTimeInterval:1 target:self
            selector:@selector(tick) userInfo:nil repeats:YES]];
        [self setIsRunning:YES];
        [delegate talkDidStart:self];
    }
}

- (void) stopClock
{
    if ([self isRunning]) {
        LOG(@"Talk %@ stopped.", self);
        [timer invalidate];
        [self setTimer:nil];
        [self setIsRunning:NO];
        [delegate talkDidStop:self];
    }
}

- (void) tick
{
    [self setCurrentTime:MAX(0, currentTime-1)];
    [delegate talkTimeDidChange:self];
    if (currentTime == 0) {
        [self stopClock];
    }
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"<%@, duration %0.0fs>", [self class], duration];
}

@end
