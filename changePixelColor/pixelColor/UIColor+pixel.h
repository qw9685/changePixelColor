//
//  UIColor+pixel.h
//  视频加载背景透明GIF
//
//  Created by upex on 2020/10/23.
//  Copyright © 2020 upex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (pixel)

//获取图片所有像素点颜色
+ (NSMutableArray<UIColor*> *)getPixelColorsWithImage:(UIImage*)image;

//更改图片像素点颜色
+ (UIImage*)changePixelColorsWithImage:(UIImage*)image colors:(NSArray<UIColor*>*)colors toColor:(UIColor*)toColor;

@end

NS_ASSUME_NONNULL_END
