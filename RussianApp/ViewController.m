//
//  ViewController.m
//  RussianApp
//
//  Created by Kyle Griffith on 2016-02-24.
//  Copyright © 2016 Kyle Griffith. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize whereField;
@synthesize name;
@synthesize phone;
@synthesize email;
@synthesize picker,datePicker;
@synthesize whatLabel,dateLabel;
NSArray *services;
- (void)viewDidLoad {
    [super viewDidLoad];
    picker.hidden=YES;
    datePicker.hidden=YES;
    services = [[NSArray alloc] initWithObjects:
                         @"Маникюр/ Педикюр", @"Домашняя уборка", @"Услуги курьера",
                         @"Доктор на дом", @"Личный тренер",@"Мастер на все руки",@"Массаж", nil];
    whatLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whatLabelTapped)];
    [whatLabel addGestureRecognizer:tapGesture];
    
    dateLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * dateTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateLabelTapped)];
    [dateLabel addGestureRecognizer:dateTapGesture];

    
}

-(void)whatLabelTapped{
    if (datePicker.hidden == NO) {
        datePicker.hidden = YES;
    }
    if (picker.hidden==YES) {
        picker.hidden=NO;
    }else{
        picker.hidden=YES;
    }
}
-(void)dateLabelTapped{
    if (picker.hidden ==NO) {
        picker.hidden =YES;
    }
    if (datePicker.hidden==YES) {
        datePicker.hidden=NO;
    }else{
        datePicker.hidden=YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)infoButton:(UIButton *)sender {
}

- (IBAction)submitButton:(UIButton *)sender {
    NSString *whereString = whereField.text;
    NSString *nameString=name.text;
    NSString *phoneString=phone.text;
    NSString *emailString=email.text;
    //Check all fields have been filled
    if (![self CheckStringSize:whereString :0]) {
        [self Alert:@"Indicate where you want the service"];
        return;
    }
    if (![self CheckStringSize:nameString :0]) {
        [self Alert:@"Please tell us your name"];
        return;
    }
    if (![self CheckStringSize:phoneString :9]) {
        [self Alert:@"Please enter a valid number"];
        return;
    }
    if (![self CheckStringSize:emailString :3]) {
        [self Alert:@"Please enter a valid email"];
        return;
    }
    if(![emailString containsString:@"@"]) {
        [self Alert:@"Please enter a valid email"];
        return;
    }
    
    [self sendToForm];

}
-(bool)CheckStringSize : (NSString *)inputString:(int *)size{
    if (inputString.length>size) {
        return true;
    }else{
        return false;
    }
    
}
-(void)sendToForm{
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:@"https://docs.google.com/forms/d/1yffvViDKq7BHALtC7Om-ceFLWT5hb_cM9sBqndHG3aU/formResponse"];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    //initialize a post data
    NSString *postData = @"entry.154268020=iOS&entry.940479455=vajhcsd&entry.247556683=BJKSVDB";
    //set request content type we MUST set this value.
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //set post data of request
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //start the connection
    [connection start];
}
- (void) Alert:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alert show];
    
}
#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [services count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [services objectAtIndex:row];
}
#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSString *whatString =[services objectAtIndex:row];
    whatLabel.text = whatString;
}

- (IBAction)pickerAction:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];

    NSString *formatedDate = [dateFormatter stringFromDate:self.datePicker.date];
    self.dateLabel.text =formatedDate;
}

@end
