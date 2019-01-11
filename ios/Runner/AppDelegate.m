#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "GLTexturePlugin.h"
#import "PagePlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [GLTexturePlugin registerWithRegistrar:[self registrarForPlugin:@"GLTexture"]];
    [PagePlugin registerWithRegistrar:[self registrarForPlugin:@"Page"]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = paths.firstObject;
    NSLog(@"%@",basePath);
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

