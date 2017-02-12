//
//  UITableView+Snapshot.m
//  UIViewSnapshot
//
//  Created by Kenvin on 16/12/18.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "UITableView+Snapshot.h"


@implementation UIImage (MosaicImage)

+ (UIImage *)mosaicImageFromArray:(NSArray *)imagesArray {
    UIImage *image = nil;
    CGSize totalImageSize = [self getMosaicImageSizeFromImagesArray:imagesArray];
    UIGraphicsBeginImageContextWithOptions(totalImageSize, NO, 0.f);

    int imageOffset = 0;
    for (UIImage *img in imagesArray) {
        [img drawAtPoint:CGPointMake(0, imageOffset)];
        imageOffset += img.size.height;
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGSize)getMosaicImageSizeFromImagesArray:(NSArray *)imagesArray{
    CGSize totalSize = CGSizeZero;
    for (UIImage *img in imagesArray) {
        CGSize imgSize = [img size];
        totalSize.height += imgSize.height;
        totalSize.width = MAX(totalSize.width, imgSize.width);
    }
    return totalSize;
}

@end


@implementation UITableView (Snapshot)

- (UIImage *)screenshot {
    
    NSMutableArray *screenshots = [NSMutableArray array];
    
    NSString * isShotHeaderView = [self smk_associatedValueForKey:@"isShotHeaderView"];
    
    if ([isShotHeaderView isEqualToString:@"YES"]){
        UIImage *headerScreenshot = [self screenshotOfHeaderView];
        [screenshots addObject:headerScreenshot];
    }
    
    for (int section=0; section<self.numberOfSections; section++) {
        
        UIImage *headerScreenshot = [self screenshotOfHeaderViewAtSection:section];
        if (headerScreenshot) [screenshots addObject:headerScreenshot];
        
        for (int row=0; row<[self numberOfRowsInSection:section]; row++) {
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UIImage *cellScreenshot = [self screenshotOfCellAtIndexPath:cellIndexPath];
            if (cellScreenshot) [screenshots addObject:cellScreenshot];
        }
        
        UIImage *footerScreenshot = [self screenshotOfFooterViewAtSection:section];
        if (footerScreenshot) [screenshots addObject:footerScreenshot];
    }

    NSString *isShotFooterView = [self smk_associatedValueForKey:@"isShotFooterView"];

    if (isShotFooterView){
        UIImage *footerScreenshot = [self screenshotOfFooterView];
        [screenshots addObject:footerScreenshot];
    }
    
    return [UIImage mosaicImageFromArray:screenshots];
}

-(UIImage *)screenshotOfHeaderView {
    [self beginUpdates];
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self endUpdates];
    return [self screenShotWithShotView:self.tableHeaderView];
}

-(UIImage *)screenshotOfFooterView {
    return [self screenShotWithShotView:self.tableFooterView];
}

-(UIImage *)screenshotOfHeaderViewAtSection:(NSInteger)section {
    return [self screenShotWithShotView:[self headerViewForSection:section]];
}

-(UIImage *)screenshotOfFooterViewAtSection:(NSInteger)section {
    return [self screenShotWithShotView:[self footerViewForSection:section]];
}

-(UIImage *)screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    [self beginUpdates];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self endUpdates];
    //滚动到相应行截图
    return [self screenShotWithShotView:cell];
}

-(UIImage *)screenShotWithShotView:(UIView *)shotView {
    UIGraphicsBeginImageContextWithOptions(shotView.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [shotView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
