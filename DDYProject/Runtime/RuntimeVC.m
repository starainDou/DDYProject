//
//  RuntimeVC.m
//  DDYProject
//
//  Created by starain on 15/8/26.
//  Copyright © 2015年 Starain. All rights reserved.
//

#import "RuntimeVC.h"
#import <objc/runtime.h>

@interface RuntimeVC ()

@end

@implementation RuntimeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    NSString *str = @"UIAlertView";
    NSString *str = @"UIScrollView";
    
    [self getIvarListOfClass:str];
    
    [self getPropertiesOfClass:str];
    
    [self getMethodsOfClass:str];
    
    [self getClassMethodsOfClass:str];
    
    [self getProtocolsOfClass:str];
}
#pragma mark 获取一个类的属性列表
- (void)getPropertiesOfClass:(NSString *)classString {
    Class class = NSClassFromString(classString);
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList(class, &count);
    for(int i = 0;i < count;i ++)
    {
        objc_property_t property = propertys[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSLog(@"uialertion.property = %@",propertyName);
    }
}
#pragma mark 获取一个类的成员变量列表
- (void)getIvarListOfClass:(NSString *)classString {
    Class class = NSClassFromString(classString);
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(class, &count);
    for(int i =0;i < count;i ++)
    {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"uialertion.ivarName = %@   type = %s",ivarName,type);
    }
}

#pragma mark 获取一个类的所有方法
- (void)getMethodsOfClass:(NSString *)classString {
    Class class = NSClassFromString(classString);
    unsigned int count = 0;
    Method *methods = class_copyMethodList(class, &count);
    for (int i = 0; i < count; i++) {
        SEL sel = method_getName(methods[i]);
        NSLog(@"Methods = %@",NSStringFromSelector(sel));
    }
    
    free(methods);
}

#pragma mark 获取一个类的所有类方法
- (void)getClassMethodsOfClass:(NSString *)classString {
    Class class = NSClassFromString(classString);
    unsigned int count = 0;
    Method *classMethods = class_copyMethodList(objc_getMetaClass(class_getName(class)), &count);
    for (int i = 0; i < count; i++) {
        SEL sel = method_getName(classMethods[i]);
        NSLog(@"Class Methods = %@",NSStringFromSelector(sel));
    }
}

#pragma mark 获取协议列表
- (void)getProtocolsOfClass:(NSString *)classString {
    Class class = NSClassFromString(classString);
    unsigned int count;
    __unsafe_unretained Protocol **protocols = class_copyProtocolList(class, &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *name = protocol_getName(protocols[i]);
        printf("Protocols = %s\n",name);
    }
}

@end
