//
//  UIScrollView+Snapshot.m
//  UIViewSnapshot
//
//  Created by Kenvin on 16/12/18.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "UIScrollView+Snapshot.h"

@implementation UIScrollView (Snapshot)

- (void)snapshot{
    UIImage* image = nil;
    
    UIGraphicsBeginImageContext(self.contentSize);
    
    CGPoint savedContentOffset = self.contentOffset;
    CGRect savedFrame = self.frame;
    
    self.contentOffset = CGPointZero;
    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    
    [self.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    self.contentOffset = savedContentOffset;
    self.frame = savedFrame;
    
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        NSLog(@"-------保存相册---------");
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        NSLog(@"-------保存成功---------");
    }else{
        NSLog(@"-------保存失败---------");
    }
}

@end
