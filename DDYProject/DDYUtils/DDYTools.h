//
//  DDYTools.h
//  DDYProject
//
//  Created by starain on 15/8/8.
//  Copyright © 2015年 Starain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDYTools : NSObject

/** 磁盘总空间 */
+ (CGFloat)allSizeOfDiskMbytes;

/** 磁盘可用空间 */
+ (CGFloat)freeSizeOfDiskMBytes;

@end
