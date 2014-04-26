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
    int registShopDataCount;
}

@end

@implementation FMStoreNameAndRateTableViewViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray * registShopData = [FMDBManager selectAllSettingShopData];
    NSLog(@"array = %d", registShopData.count);
    registShopDataCount = registShopData.count;
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FMRegistShopTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"registShopCell"];
    UINib *nib = [UINib nibWithNibName:@"FMRegistShopTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/**
 * セクション数を返すデリゲートメソッド
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;	// 0 -> 1 に変更
}
/**
 * 登録してある店舗の数だけ返す // 未実装///////
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return registShopDataCount;	// 0 -> 10 に変更
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
    //dequeueReusableCellWithIdentifierに識別文字列を渡すことでインスタンスを取得できるようにする
    FMRegistShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.registShopLabel.text = @"ああああ";
    
    return cell;
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (cell == nil) {
//        // 再利用時のセルの識別文字列を指定
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row]; // 何番目のセルかを表示させました
//    return cell;
}


@end
