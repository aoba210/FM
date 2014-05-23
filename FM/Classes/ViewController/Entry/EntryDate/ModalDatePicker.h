//
//  ModalDatePicker.h
//  FM
//
//  Created by T.N on 2014/05/13.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalDatePicker;

@protocol ModalDatePickerDelegate

- (void)didCommitButtonClicked:(ModalDatePicker *)controller selectedDate:(NSDate *)selectedDate;
- (void)didCancelButtonClicked:(ModalDatePicker *)controller;

@end

@interface ModalDatePicker : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
@property (nonatomic, assign) id<ModalDatePickerDelegate> delegate;

- (IBAction)okClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;

@end
