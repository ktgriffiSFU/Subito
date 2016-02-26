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
NSString *serviceChoice;
NSString *dateChoice;
NSString *whereString;
NSString *nameString;
NSString *phoneString;
NSString *emailString;
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

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
-(void)dismissKeyboard {
    [whereField resignFirstResponder];
    [name resignFirstResponder];
    [email resignFirstResponder];
    [phone resignFirstResponder];
    [datePicker resignFirstResponder];
    


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

    
    [self sendToForm];


}
-(bool)CheckStringSize : (NSString *)inputString{
    if (inputString.length>0) {
        return true;
    }else{
        return false;
    }
    
}

-(void)sendToForm{
    whereString = whereField.text;
    nameString=name.text;
    phoneString=phone.text;
    emailString=email.text;
    dateChoice = dateLabel.text;
    serviceChoice = whatLabel.text;
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:@"https://docs.google.com/forms/d/1jeyxQYlgIUylhXnZZEcy6BC2dx_2AUB3qSNuCqFHUDU/formResponse"];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    //initialize a post data
    NSString *postData = [NSString stringWithFormat:@"entry.1550955212=%@&entry.935955213=%@&entry.1547576233=%@&entry.202631922=%@&entry.1387567225=%@&entry.1031369018=%@",serviceChoice,dateChoice,whereString,emailString,phoneString,nameString];    //set request content type we MUST set this value.
    [request setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
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
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
    NSLog(@"Connection did recieve response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
    NSLog(@"Connection did recieve data");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"RESPONSE: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"CONNECTION ERROR: %@", [error localizedDescription]);
}
@end
