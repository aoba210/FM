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
#import "FMRegistNewStoreNameAndRateViewController.h"

@interface FMStoreNameAndRateTableViewViewController ()
{
    NSArray *registShopDataArray;
    ShopSettingDataEntity *shopSettingDataEntity;
}
@property (nonatomic) NSString *shopNameText;
@property (nonatomic) NSString *rateText;
@property (nonatomic) NSString *feeText;

@end

@implementation FMStoreNameAndRateTableViewViewController
@synthesize shopNameText;
@synthesize rateText;
@synthesize feeText;

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
    //TableViewCellのハイライトを消す。
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    
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
    NSString *storeName = shopSettingDataEntity.storeName;
    NSString *rate = [shopSettingDataEntity.rate stringValue];
    NSString *labelText = [NSString stringWithFormat:@"%@ %@", storeName, rate];
    cell.registShopLabel.text = labelText;
    
    return cell;
}

/**
 * Cell が選択された時
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath{
    ShopSettingDataEntity *selectShopSettingDataEntity = [registShopDataArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toFMRegistNewStoreNameAndRateViewController" sender:selectShopSettingDataEntity];
}

/**
 * Segue で次の ViewController へ移行するときに選択されたCellの画像情報を渡す
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toFMRegistNewStoreNameAndRateViewController"]) {
        FMRegistNewStoreNameAndRateViewController *registStoreNameAndRateViewController =[segue destinationViewController];
        registStoreNameAndRateViewController.shopNameText = [sender valueForKey:@"storeName"];
        registStoreNameAndRateViewController.rateText = [[sender valueForKey:@"rate"] stringValue];
        registStoreNameAndRateViewController.feeText = [[sender valueForKey:@"fee"] stringValue];
     }
}

@end
