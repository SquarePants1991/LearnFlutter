#import "PagePlugin.h"
#import <Flutter/Flutter.h>

@implementation PagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"me.ht/page"
                                     binaryMessenger:[registrar messenger]];
    PagePlugin* instance = [[PagePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"start" isEqualToString:call.method]) {
        UIViewController *newVC = [UIViewController new];
        newVC.view.backgroundColor = UIColor.redColor;
        [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:newVC animated:YES completion:nil];
        result([@"page is start" stringByAppendingFormat:@"%@", call.arguments]);
    }
}

@end
