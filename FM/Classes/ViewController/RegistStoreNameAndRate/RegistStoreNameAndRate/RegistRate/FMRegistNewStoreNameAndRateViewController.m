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

@property (weak, nonatomic) IBOutlet UITextField *storeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *rateTextField;
@property (weak, nonatomic) IBOutlet UITextField *feeTextField;
@property(nonatomic,strong) UITapGestureRecognizer *singleTap;

@end

@implementation FMRegistNewStoreNameAndRateViewController

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
    
    //ビューの初期化時にジェスチャをself.viewに登録
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
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

    [FMDBManager registStoreName:storeName rate:rate fee:fee];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
