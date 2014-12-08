//
//  ViewController.m
//  MMQrekiSample
//
//  Created by MasashiMizuno on 2014/12/08.
//  Copyright (c) 2014年 水野 真史. All rights reserved.
//

#import "ViewController.h"
#import "MMQreki.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSString *selectedDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    [self.datePicker addTarget:self
                   action:@selector(datePickerValueChanged:)
         forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)datePickerValueChanged:(UIDatePicker *)sender {
    self.selectedDate = [self.dateFormatter stringFromDate:sender.date];
}
- (IBAction)pushOldCalButton:(id)sender {
    
    MMQreki *qreki = [[MMQreki alloc] init];
    NSString *qrekiString = [qreki getNewToOldCalender:self.selectedDate];
    
    [[[UIAlertView alloc] initWithTitle:@"旧暦" message:qrekiString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (IBAction)pushRokuyoButton:(id)sender {
    
    MMQreki *qreki = [[MMQreki alloc] init];
    NSString *qrekiString = [qreki getRokuyo:self.selectedDate];
    
    [[[UIAlertView alloc] initWithTitle:@"六曜" message:qrekiString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
