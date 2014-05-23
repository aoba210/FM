//
//  FMEntryDateViewController.m
//  FM
//
//  Created by T.N on 2014/01/19.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import "FMEntryDateViewController.h"
#import "ModalDatePicker.h"
#import "FMAppDelegate.h"

@interface FMEntryDateViewController ()<UITextFieldDelegate, ModalDatePickerDelegate>
{
    BOOL isDispDatePicker;
    ModalDatePicker *datePickerViewController;
}

- (IBAction)okButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

@end

@implementation FMEntryDateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dateTextField.delegate = self;
    isDispDatePicker = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * textFieldを押下した時の処理
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL ret = YES;
    
    // datePickerが出ていればdatePickerを隠す
    if (isDispDatePicker) {
        [self hideModal:datePickerViewController.view];
        datePickerViewController.delegate = nil;
    }
        
    // datepickerがまだ出ていなければ出す
    if (!isDispDatePicker) {
        UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        datePickerViewController = [myStoryBoard instantiateViewControllerWithIdentifier:@"ID_DatePickerViewController"];
        datePickerViewController.delegate = self;
        [self showModal:datePickerViewController.view];
        isDispDatePicker = YES;
        ret = NO;
    }
    return ret;
}


/**
 * modalを隠す
 */
- (void)showModal:(UIView *)modalView
{
    UIWindow *mainWindow = (((FMAppDelegate *) [UIApplication sharedApplication].delegate).window);
    CGPoint middleCenter = modalView.center;
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width * 0.5f, offSize.height * 1.5f);
    modalView.center = offScreenCenter;
    [mainWindow addSubview:modalView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    modalView.center = middleCenter;
    [UIView commitAnimations];
}

/**
 * modalを出す
 */
- (void)hideModal:(UIView*)modalView
{
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width * 0.5f, offSize.height * 1.5f);
    [UIView beginAnimations:nil context:(__bridge_retained void *)(modalView)];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideModalEnded:finished:context:)];
    modalView.center = offScreenCenter;
    [UIView commitAnimations];
}

/**
 * modalが出終わった時の処理
 */
- (void)hideModalEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIView *modalView = (__bridge_transfer UIView *)context;
    [modalView removeFromSuperview];
    isDispDatePicker = NO;
}

/**
 * datePickerのOKボタン押下時の処理
 */
-(void)didCommitButtonClicked:(ModalDatePicker *)controller selectedDate:(NSDate *)selectedDate
{
    [self hideModal:controller.view];
    controller.delegate = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    self.dateTextField.text = [formatter stringFromDate:selectedDate];
}

/**
 * datePickerのcancelボタン押下時の処理
 */
-(void)didCancelButtonClicked:(ModalDatePicker *)controller
{
    [self hideModal:controller.view];
    controller.delegate = nil;
}

- (IBAction)okButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end