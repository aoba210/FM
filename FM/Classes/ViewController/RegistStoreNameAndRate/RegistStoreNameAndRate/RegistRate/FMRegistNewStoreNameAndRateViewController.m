//
//  FMRegistNewStoreNameAndRateViewController.m
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import "FMRegistNewStoreNameAndRateViewController.h"
#import "FMDBManager.h"

@interface FMRegistNewStoreNameAndRateViewController ()
{
}

@property(nonatomic,strong) UITapGestureRecognizer *singleTap;

@end

@implementation FMRegistNewStoreNameAndRateViewController
@synthesize updateShopSettingDataEntity;
@synthesize shopNameText;
@synthesize rateText;
@synthesize feeText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //キーボードを閉じるためにビューの初期化時にジェスチャをself.viewに登録
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.storeNameTextField.text = shopNameText;
    self.rateTextField.text = rateText;
    self.feeTextField.text = feeText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * シングルタップされたらresignFirstResponderでキーボードを閉じる
 */
-(void)onSingleTap:(UITapGestureRecognizer *)recognizer{
    [self.storeNameTextField resignFirstResponder];
    [self.rateTextField resignFirstResponder];
    [self.feeTextField resignFirstResponder];
}

/**
 * キーボードを表示していない時は、他のジェスチャに影響を与えないように無効化しておく。
 */
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        // キーボード表示中のみ有効
        if (self.storeNameTextField.isFirstResponder) {
            return YES;
        } else if (self.rateTextField.isFirstResponder) {
            return YES;
        } else if (self.feeTextField.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

/**
 * 入力した店舗名/レート/場代を保存します
 */
- (IBAction)saveStoreNameAndRateAndFeeAction:(id)sender {
    
    NSString * storeName = self.storeNameTextField.text;
    float floatRate = [self.rateTextField.text floatValue];
    NSNumber * rate = [NSNumber numberWithFloat:floatRate];    
    int intFee = [self.feeTextField.text intValue];
    NSNumber * fee = [NSNumber numberWithInt:intFee];
    
    // 店舗設定を新規追加するとき
    if (!shopNameText && !rateText && !feeText) {
        [FMDBManager registStoreName:storeName rate:rate fee:fee];
    }
    // 店舗設定を更新するとき
    else {
        [FMDBManager updateShopSettingData:updateShopSettingDataEntity storeName:storeName rate:rate fee:fee];
    }
    
    
    // alert
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"店舗設定"
                          message:@"店舗設定を保存しました。"
                          delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil
                          ];
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
