@class Talk;

@protocol TalkDelegate <NSObject>
- (void) talkDidStart: (Talk*) talk;
- (void) talkDidStop: (Talk*) talk;
- (void) talkTimeDidChange: (Talk*) talk;
@end

@interface Talk : NSObject

@property(readonly) NSTimeInterval duration;
@property(readonly) NSTimeInterval currentTime;
@property(readonly) BOOL isRunning;

@property(assign) id<TalkDelegate> delegate;

+ (id) talkWithDuration: (NSTimeInterval) duration;
- (id) initWithDuration: (NSTimeInterval) duration;

- (void) startClock;
- (void) stopClock;

@end
