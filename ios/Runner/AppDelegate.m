#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "GLTexturePlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [GLTexturePlugin registerWithRegistrar:[self registrarForPlugin:@"GLTexture"]];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

