//
//  DDYProxy.h
//  DDYProject
//
//  Created by BiliBili on 15/9/15.
//  Copyright © 2015年 Starain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDYProxy : NSProxy

@property (nonatomic, weak, readonly) id target;

+ (instancetype)proxyWithTarget:(id)target;

@end
