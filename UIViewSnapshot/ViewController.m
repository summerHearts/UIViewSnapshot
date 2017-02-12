//
//  ViewController.m
//  UIViewSnapshot
//
//  Created by Kenvin on 16/12/18.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+Snapshot.h"
#import "HotelDetailController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //修复头部视图偏移的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel * headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerView.text = @"SNKSKALSKASLLALSLASLLSSSASJASJASK";
    headerView.contentMode = UIViewContentModeCenter;
    headerView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = headerView;
    
    UILabel * footerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    footerView.text = @"SNKSKALSKASLLALSLASLLSSSASJASJASK";
    footerView.contentMode = UIViewContentModeCenter;
    footerView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = footerView;
    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 500, 100, 40)];
    
    [button setTitle:@"点击截图" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(snapshotBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"区头:%ld",section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"区尾:%ld",section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"UITableViewCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Section:%ld Row:%ld",indexPath.section, indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelDetailController *hotelDetailController = [[HotelDetailController alloc]init];
    [self.navigationController pushViewController:hotelDetailController animated:YES];
}

- (void)snapshotBtn:(UIButton *)sender {
    //截图   需要头部视图
    [self.tableView smk_setAssociateCopyValue:@"YES" withKey:@"isShotHeaderView"];
    [self.tableView smk_setAssociateCopyValue:@"YES" withKey:@"isShotFooterView"];

    UIImage * snapshotImg = [self.tableView screenshot];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    //仅获取绘制部分
    //    UIImage * snapshotImg = [self screenshot];
    
    //保存相册
    UIImageWriteToSavedPhotosAlbum(snapshotImg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    NSLog(@"-------保存相册---------");
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        NSLog(@"-------保存成功---------");
    }else{
        NSLog(@"-------保存失败---------");
    }
}

//普通系统截屏，仅获取绘制部分
- (UIImage *)screenshot{
    UIGraphicsBeginImageContextWithOptions(self.tableView.frame.size, NO, [UIScreen mainScreen].scale);
    CGRect tableViewFrame = self.tableView.frame;
    self.tableView.frame = CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.contentSize.height);
    [self.tableView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.tableView.frame = tableViewFrame;
    
    return image;
}

@end
