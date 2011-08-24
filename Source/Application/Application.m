#import "Application.h"
#import "Factory.h"

@interface Application ()
@property(retain) Factory *factory;
@property(retain) UIViewController *mainScreenController;
@end

@implementation Application
@synthesize window, factory, mainScreenController;

- (BOOL) application: (UIApplication*) application didFinishLaunchingWithOptions: (NSDictionary*) launchOptions
{
    factory = [[Factory alloc] init];
    [self setMainScreenController:[factory buildMainScreenController]];
    [window setRootViewController:mainScreenController];
    [window makeKeyAndVisible];
    return YES;
}

- (void) dealloc
{
    [window release];
    [factory release];
    [mainScreenController release];
    [super dealloc];
}

@end
