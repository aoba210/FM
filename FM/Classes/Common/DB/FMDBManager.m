//
//  FMDBManager.m
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import "FMDBManager.h"
#import "CoreDataManager.h"

static NSString *const kDBName = @"FMModel";
static NSString *const kPlayDataTableName = @"PlayDataEntity";
static NSString *const kShopSettingDataTableName = @"ShopSettingDataEntity";

@implementation FMDBManager


/**
 * 店舗名/レート/場代を登録
 */
+ (void)registStoreName:(NSString *)storeName rate:(NSString *)rate fee:(NSNumber *)fee
{
    CoreDataManager *coreDataManager = [CoreDataManager getInstance:kDBName];
    ShopSettingDataEntity *shopSettingData = (ShopSettingDataEntity *)[coreDataManager new:kShopSettingDataTableName];
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
    NSArray *settingShopDataArray = [coreDataManager select:kShopSettingDataTableName where:nil];
    return settingShopDataArray;
}

/**
 * 店舗設定データを更新
 */
+ (void)updateShopSettingData:(ShopSettingDataEntity *)shopSettingDataEntity storeName:(NSString *)storeName rate:(NSString *)rate fee:(NSNumber *)fee
{
    CoreDataManager *coreDataManager = [CoreDataManager getInstance:kDBName];
    shopSettingDataEntity.storeName = storeName;
    shopSettingDataEntity.rate = rate;
    shopSettingDataEntity.fee = fee;
    [coreDataManager save];
}

@end
