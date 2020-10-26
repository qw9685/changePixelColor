//
//  ViewController.m
//  视频加载背景透明GIF
//
//  Created by upex on 2020/10/22.
//  Copyright © 2020 upex. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+pixel.h"
#import "colorCollectionView.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView* imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    
    UIImage* image = [UIImage imageNamed:@"蓝色"];
    self.imageView.image = image;
    
    
    NSMutableArray* colors = [UIColor getPixelColorsWithImage:image];

    //去重
    NSSet* set = [NSSet setWithArray:colors];
    NSArray* arr = [set allObjects];
    
    colorCollectionView* collectionView = [[colorCollectionView alloc] init];
    collectionView.arr = arr;
    [collectionView show];
    collectionView.clickBlock = ^(UIColor * _Nonnull color) {
        self.imageView.image = [UIColor changePixelColorsWithImage:self.imageView.image colors:@[color] toColor:[UIColor orangeColor]];
    };
}

@end











