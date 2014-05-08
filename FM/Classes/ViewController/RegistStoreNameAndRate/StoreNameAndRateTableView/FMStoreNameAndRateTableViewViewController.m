//
//  FMStoreNameAndRateTableViewViewController.m
//  FM
//
//  Created by T.N on 2014/01/19.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import "FMStoreNameAndRateTableViewViewController.h"
#import "FMDBManager.h"
#import "FMRegistShopTableViewCell.h"

@interface FMStoreNameAndRateTableViewViewController ()
{
    NSArray *registShopDataArray;
    ShopSettingDataEntity *shopSettingDataEntity;
}

@end

@implementation FMStoreNameAndRateTableViewViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"FMRegistShopTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    registShopDataArray = [FMDBManager selectAllSettingShopData];
//    NSLog(@"name = %@", shopSettingDataEntity.fee);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

/**
 * セクション数を返すデリゲートメソッド
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 * 登録してある店舗の数だけ返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return registShopDataArray.count;
}

/**
 * セルの高さを返すデリゲートメソッド
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

/**
 * セル内処理を記述
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FMRegistShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    shopSettingDataEntity = [registShopDataArray objectAtIndex:indexPath.row];
    cell.registShopLabel.text = shopSettingDataEntity.storeName;
    
    return cell;
}


@end
