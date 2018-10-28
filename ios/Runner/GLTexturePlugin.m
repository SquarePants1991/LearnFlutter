//
//  GLTexturePlugin.m
//  Runner
//
//  Created by ocean on 2018/10/26.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

#import "GLTexturePlugin.h"

@implementation GLTexture
- (CVPixelBufferRef)copyPixelBuffer {
    UIImage *image_ = [UIImage imageNamed:@"AppIcon"];
    CGImageRef cgImage = image_.CGImage;
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);
    size_t bitsPerCom = CGImageGetBitsPerComponent(cgImage);
    CGColorSpaceRef space = CGImageGetColorSpace(cgImage);
    CGDataProviderRef dataProvider = CGImageGetDataProvider(cgImage);
    CFDataRef imageData = CGDataProviderCopyData(dataProvider);
    CFIndex dataLen = CFDataGetLength(imageData);
    UInt8 *buffer = malloc(dataLen);
    CFDataGetBytes(imageData, CFRangeMake(0, dataLen), buffer);

    CVPixelBufferRef returnBuffer;
    CVReturn result = CVPixelBufferCreateWithBytes(NULL, width, height, kCVPixelFormatType_32BGRA, buffer, bytesPerRow, nil, nil, nil, &returnBuffer);
    if (result == kCVReturnSuccess) {
        return returnBuffer;
    }
    return NULL;
    
//    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//                             [NSNumber numberWithBool:NO], kCVPixelBufferCGImageCompatibilityKey,
//                             [NSNumber numberWithBool:NO], kCVPixelBufferCGBitmapContextCompatibilityKey,
//                             nil];
//
//    CVPixelBufferRef pxbuffer = NULL;
//
//    CGFloat frameWidth = 512;//CGImageGetWidth(image);
//    CGFloat frameHeight = 512;//CGImageGetHeight(image);
//
//    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                          frameWidth,
//                                          frameHeight,
//                                          kCVPixelFormatType_32BGRA,
//                                          (__bridge CFDictionaryRef) options,
//                                          &pxbuffer);
//
//    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
//
//    CVPixelBufferLockBaseAddress(pxbuffer, 0);
//    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
//    NSParameterAssert(pxdata != NULL);
//
//    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
//
//    CGContextRef context = CGBitmapContextCreate(pxdata,
//                                                 frameWidth,
//                                                 frameHeight,
//                                                 8,
//                                                 CVPixelBufferGetBytesPerRow(pxbuffer),
//                                                 rgbColorSpace,
//                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
//    NSParameterAssert(context);
//    CGContextConcatCTM(context, CGAffineTransformIdentity);
//    CGContextDrawImage(context, CGRectMake(0,
//                                           0,
//                                           frameWidth,
//                                           frameHeight),
//                       image);
//    CGColorSpaceRelease(rgbColorSpace);
//    CGContextRelease(context);
//
//    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
//    CVPixelBufferRetain(pxbuffer);
//    return pxbuffer;
}

- (void)dealloc {
    
}
@end

const NSString *const GLTexturePluginName = @"me.ht/gltexture";

@implementation GLTexturePlugin {
    GLTexture *texture;
    NSObject<FlutterPluginRegistrar> *_registrar;
    NSObject<FlutterTextureRegistry> *textureRegistry;
    FlutterMethodChannel *gltextureChannel;
    int64_t textureID;
    CADisplayLink *displayLink;
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    if (self = [super init]) {
        _registrar = registrar;
        textureRegistry = [registrar textures];
        texture = [GLTexture new];
        gltextureChannel = [FlutterMethodChannel
                            methodChannelWithName:(NSString *)GLTexturePluginName
                            binaryMessenger:[registrar messenger]];
        [gltextureChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            if ([call.method isEqualToString:@"create"]) {
                textureID = [textureRegistry registerTexture:texture];
                result(@(textureID));
            }
        }];
        
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(ticked:)];
        [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)ticked:(CADisplayLink *)displayLink {
    [textureRegistry textureFrameAvailable:textureID];
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    static GLTexturePlugin *plugin = nil;
    plugin = [GLTexturePlugin.alloc initWithRegistrar:registrar];
}
@end
