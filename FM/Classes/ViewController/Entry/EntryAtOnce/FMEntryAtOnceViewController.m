//
//  FMEntryAtOnceViewController.m
//  FM
//
//  Created by T.N on 2014/01/19.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import "FMEntryAtOnceViewController.h"

@interface FMEntryAtOnceViewController ()

@end

@implementation FMEntryAtOnceViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 4;	// 0 -> 1 に変更
}

/**
 * セクションの設定
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //    return [[NSString alloc]initWithFormat:@"Section %ld", (long)section];
    switch (section) {
        case 0:
            return @"日付";
            break;
        case 1:
            return @"店舗名";
            break;
        case 2:
            return @"着順";
            break;
        case 3:
            return @"収支合計";
            break;
    }
    return nil;
    
}

/**
 * デフォルトのセルの数を返すデリゲートメソッド
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 1;	// 0 -> 10 に変更
}

/**
 * セルの高さを返すデリゲートメソッド
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44; // デフォルト値をセット
}
/**
 * セル内処理
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //dequeueReusableCellWithIdentifierに識別文字列を渡すことでインスタンスを取得できるようにする
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"EntryDateCell"];
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"EntryStoreNameCell"];
    } else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"EntryArrivalCell"];
    } else if (indexPath.section == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"EntryIncomeAndExpenditureCell"];
    }
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
