//
//  UITableView+Snapshot.h
//  UIViewSnapshot
//
//  Created by Kenvin on 16/12/18.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+SOObject.h"


@interface UIImage (MosaicImage)


+ (UIImage *)mosaicImageFromArray:(NSArray *)imagesArray;


+ (CGSize)getMosaicImageSizeFromImagesArray:(NSArray *)imagesArray;

@end


@interface UITableView (Snapshot)


- (UIImage *)screenshot;

@end
