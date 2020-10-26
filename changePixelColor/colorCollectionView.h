//
//  colorCollectionView.h
//  视频加载背景透明GIF
//
//  Created by upex on 2020/10/23.
//  Copyright © 2020 upex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface colorCollectionView : NSObject

@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void(^clickBlock)(UIColor* color);

- (void)show;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
