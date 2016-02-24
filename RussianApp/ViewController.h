//
//  ViewController.h
//  RussianApp
//
//  Created by Kyle Griffith on 2016-02-24.
//  Copyright © 2016 Kyle Griffith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView       *picker;
}
@property (nonatomic, retain) IBOutlet UIPickerView *picker;

@property (weak, nonatomic) IBOutlet UILabel *whatLabel;


//What Что needed
//When Когда needed
@property (weak, nonatomic) IBOutlet UITextField *where;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIImageView *appLogo;
- (IBAction)infoButton:(UIButton *)sender;
- (IBAction)submitButton:(UIButton *)sender;

@end

