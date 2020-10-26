//
//  UIColor+pixel.m
//  视频加载背景透明GIF
//
//  Created by upex on 2020/10/23.
//  Copyright © 2020 upex. All rights reserved.
//

#import "UIColor+pixel.h"


@implementation UIColor (pixel)

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )

//获取图片所有像素点颜色
+ (NSMutableArray<UIColor*> *)getPixelColorsWithImage:(UIImage*)image
{
    UInt32 * inputPixels;
    
    // 分配内存
    CGImageRef inputCGImage = [image CGImage];
    NSUInteger imageWidth = CGImageGetWidth(inputCGImage);
    NSUInteger imageHeight = CGImageGetHeight(inputCGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bitsPerComponent = 8;
    
    NSUInteger inputBytesPerRow = bytesPerPixel * imageWidth;//每行字节数
    
    inputPixels = (UInt32 *)calloc(imageHeight * imageWidth, sizeof(UInt32));//内存空间首个像素
    
    // 创建context
    CGContextRef context = CGBitmapContextCreate(inputPixels, imageWidth, imageHeight, bitsPerComponent, inputBytesPerRow, colorSpace,kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    NSMutableArray* arr = [NSMutableArray array];
    // 遍历像素
    for (NSUInteger j = 0; j < imageHeight; j++) {
        for (NSUInteger i = 0; i < imageWidth; i++) {
            UInt32 * currentPixel = inputPixels + (j * imageWidth) + i;
            UInt32 color = *currentPixel;
            UInt32 red,green,blue,alpha;
            red=R(color);green=G(color);blue=B(color);alpha=A(color);
            [arr addObject:[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0]];
        }
    }
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    free(inputPixels);
    return arr;
}

//更改图片像素点颜色
+ (UIImage*)changePixelColorsWithImage:(UIImage*)image colors:(NSArray<UIColor*>*)colors toColor:(UIColor*)toColor
{
    UInt32 * inputPixels;
    
    // 分配内存
    CGImageRef inputCGImage = [image CGImage];
    NSUInteger imageWidth = CGImageGetWidth(inputCGImage);
    NSUInteger imageHeight = CGImageGetHeight(inputCGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bitsPerComponent = 8;
    
    NSUInteger inputBytesPerRow = bytesPerPixel * imageWidth;//每行字节数
    
    inputPixels = (UInt32 *)calloc(imageHeight * imageWidth, sizeof(UInt32));//内存空间首个像素
    
    // 创建context
    CGContextRef context = CGBitmapContextCreate(inputPixels, imageWidth, imageHeight, bitsPerComponent, inputBytesPerRow, colorSpace,kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    for (NSUInteger j = 0; j < imageHeight; j++) {
        for (NSUInteger i = 0; i < imageWidth; i++) {
            UInt32 * currentPixel = inputPixels + (j * imageWidth) + i;
            UInt32 color = *currentPixel;
            UInt32 br = 0,red,green,blue,alpha;
            red=R(color); green=G(color); blue=B(color); alpha=A(color);
            
            [colors enumerateObjectsUsingBlock:^(UIColor* newColor, NSUInteger idx, BOOL * _Nonnull stop) {
                const CGFloat *components = CGColorGetComponents(newColor.CGColor);
                if(red == components[0] * 255.0 && green == components[1] * 255.0 && blue == components[2] * 255.0){
                    const CGFloat *components = CGColorGetComponents(toColor.CGColor);
                    int red = components[0] * 255.0;
                    int green = components[1] * 255.0;
                    int blue = components[2] * 255.0;
                    int alpha = components[3] * 255.0;
                    *currentPixel = RGBAMake(red,green,blue, alpha);
                    *stop = YES;
                    return ;
                }
            }];
        }
    }
        
    //转换UIImage
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage * newImage = [UIImage imageWithCGImage:newCGImage];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    free(inputPixels);
    
    return newImage;
}

@end
