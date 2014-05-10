//
//  FMDBManager.h
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopSettingDataEntity.h"
#import "PlayDataEntity.h"

@interface FMDBManager : NSObject

+ (void)registStoreName:(NSString *)storeName rate:(NSString *)rate fee:(NSNumber *)fee;
+ (NSArray *)selectAllSettingShopData;
+ (void)updateShopSettingData:(ShopSettingDataEntity *)shopSettingDataEntity storeName:(NSString *)storeName rate:(NSString *)rate fee:(NSNumber *)fee;

@end
