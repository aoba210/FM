//
//  FMDBManager.h
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject

+ (void)registStoreName:(NSString *)storeName rate:(NSNumber *)rate fee:(NSNumber *)fee;
+ (NSArray *)selectAllSettingShopData;

@end
