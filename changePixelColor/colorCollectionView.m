//
//  colorCollectionView.m
//  视频加载背景透明GIF
//
//  Created by upex on 2020/10/23.
//  Copyright © 2020 upex. All rights reserved.
//

#import "colorCollectionView.h"
#import "AppDelegate.h"
#import "ccCollectionView.h"

@interface colorCollectionView ()

@property (nonatomic, strong) ccCollectionView *collectionView;

@end

@implementation colorCollectionView

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWith  [UIScreen mainScreen].bounds.size.width

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
        [window addSubview:self.collectionView];
        [self hide];
    }
    return self;
}

- (void)show{
    self.collectionView.hidden = NO;
}

- (void)hide{
    self.collectionView.hidden = YES;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    [self.collectionView cc_reload];
}

-(ccCollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[ccCollectionView alloc] initCollectionViewWithItemClass:[UICollectionViewCell class] headClass:nil footClass:nil];
        _collectionView.frame = CGRectMake(0, 0, 100, kScreenHeight);

        _collectionView.collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.layout.minimumInteritemSpacing = 5.0;
        _collectionView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView.cc_CollectionDidSelectRowAtIndexPath(^(NSIndexPath * _Nonnull indexPath, UICollectionView * _Nonnull collectionView) {
            if (self.clickBlock) {
                self.clickBlock(self.arr[indexPath.item]);
            }
        }).cc_CollectionNumberOfRows(^NSInteger(NSInteger section, UICollectionView * _Nonnull collectionView) {
            return self.arr.count;
        }).cc_sizeForItemAtIndexPath(^CGSize(UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
            
            return CGSizeMake(30, 30);
            
        }).cc_CollectionViewForCell(^UICollectionViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, UICollectionView * _Nonnull collectionView) {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
            cell.contentView.backgroundColor = self.arr[indexPath.item];
            return cell;
        });
    }
    
    return _collectionView;
}

@end


