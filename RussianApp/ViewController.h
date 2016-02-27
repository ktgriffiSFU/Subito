//
//  ViewController.h
//  RussianApp
//
//  Created by Kyle Griffith on 2016-02-24.
//  Copyright © 2016 Kyle Griffith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)pickerAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *whatLabel;


//What Что needed
//When Когда needed
@property (weak, nonatomic) IBOutlet UITextField *whereField;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;

- (IBAction)infoButton:(UIButton *)sender;
- (IBAction)submitButton:(UIButton *)sender;

@end

NSMutableData *responseData;