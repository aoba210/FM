//
//  FMRegistNewStoreNameAndRateViewController.h
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDBManager.h"

@interface FMRegistNewStoreNameAndRateViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *storeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *rateTextField;
@property (weak, nonatomic) IBOutlet UITextField *feeTextField;

@property (nonatomic) ShopSettingDataEntity *updateShopSettingDataEntity;
@property (nonatomic) NSString *shopNameText;
@property (nonatomic) NSString *rateText;
@property (nonatomic) NSString *feeText;

@end
