//
//  SafeObject.m
//  UIViewSnapshot
//
//  Created by Kenvin on 16/12/18.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "NSObject+SOObject.h"
#import <objc/runtime.h>

@implementation NSObject(SOObject)

-(BOOL)smk_isNotEmpty{
    
    return !(self == nil
             || ([self respondsToSelector:@selector(length)]
                 && [(NSData *)self length] == 0)
             || ([self respondsToSelector:@selector(count)]
                 && [(NSArray *)self count] == 0));
   
};

- (void)smk_setAssociateValue:(id)value withKey:(void *)key{
    
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)smk_setAssociateWeakValue:(id)value withKey:(void *)key{
    
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)smk_setAssociateCopyValue:(id)value withKey:(void *)key{
    
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)smk_associatedValueForKey:(void *)key{
    
    return objc_getAssociatedObject(self, key);
}


@end

