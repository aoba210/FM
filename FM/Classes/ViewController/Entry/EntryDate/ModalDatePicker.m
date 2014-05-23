//
//  ModalDatePicker.m
//  FM
//
//  Created by T.N on 2014/05/13.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import "ModalDatePicker.h"

@interface ModalDatePicker ()

@end

@implementation ModalDatePicker
@synthesize picker = _picker, delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"ModalDatePicker" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)viewDidAppear:(BOOL)animated {
//    if (self.dispDate != nil) {
//        [self.picker setDate:self.dispDate];
//    }
//}
//
//- (void)viewDidUnload
//{
//    [self setPicker: nil];
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)okClicked:(id)sender {
    [_delegate didCommitButtonClicked:self selectedDate:_picker.date];
}

- (IBAction)cancelClicked:(id)sender {
    [_delegate didCancelButtonClicked:self];
}

@end
