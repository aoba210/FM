//
//  FMDBManager.m
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import "FMDBManager.h"
#import "CoreDataManager.h"
#import "ShopSettingData.h"
#import "PlayData.h"

static NSString *const kDBName = @"FMModel";
static NSString *const kShopSettingDataTableName = @"ShopSettingData";

@implementation FMDBManager


/**
 * 店舗名/レート/場代を登録
 */
+ (void)registStoreName:(NSString *)storeName rate:(NSNumber *)rate fee:(NSNumber *)fee
{
    CoreDataManager *coreDataManager = [CoreDataManager getInstance:kDBName];
    ShopSettingData *shopSettingData = (ShopSettingData *)[coreDataManager new:kShopSettingDataTableName];
    [shopSettingData setStoreName:storeName];
    [shopSettingData setFee:fee];
    [shopSettingData setRate:rate];
    [coreDataManager save];
}

/**
 * 店舗設定データを検索
 */
+ (NSArray *)selectAllSettingShopData
{
    CoreDataManager *coreDataManager = [CoreDataManager getInstance:kDBName];
    NSArray *playerDataArray = [coreDataManager select:kShopSettingDataTableName where:nil];
    
    return playerDataArray;
}

@end
