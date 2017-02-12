//
//  HotelDetailController.m
//  UIViewSnapshot
//
//  Created by Kenvin on 16/12/18.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "HotelDetailController.h"
#import "UIScrollView+Snapshot.h"
@interface HotelDetailController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation HotelDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    UIImageView* imageViewA = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"timg.jpg"]];
    imageViewA.frame = CGRectMake(0, 0*[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_scrollView addSubview: imageViewA];
    
    UIImageView* imageViewB = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"timg1.jpg"]];
    imageViewB.frame = CGRectMake(0, 1*[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_scrollView addSubview: imageViewB];
    
    UIImageView* imageViewC = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"timg2.jpg"]];
    imageViewC.frame = CGRectMake(0, 2*[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_scrollView addSubview: imageViewC];
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 3*[UIScreen mainScreen].bounds.size.height);
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 800, 100, 40)];
    
    [button setTitle:@"点击截图" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(snapshotView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:button];
}

- (void)snapshotView:(UIButton *)button{
    [self.scrollView  snapshot];
}

@end
