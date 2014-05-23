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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)okClicked:(id)sender {
    [_delegate didCommitButtonClicked:self selectedDate:_picker.date];
}

- (IBAction)cancelClicked:(id)sender {
    [_delegate didCancelButtonClicked:self];
}

@end
