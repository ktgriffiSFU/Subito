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
@synthesize where;
@synthesize name;
@synthesize phone;
@synthesize email;
@synthesize picker;
@synthesize whatLabel;
NSArray *services;
- (void)viewDidLoad {
    [super viewDidLoad];
    picker.hidden=YES; 
    services = [[NSArray alloc] initWithObjects:
                         @"Маникюр/ Педикюр", @"Домашняя уборка", @"Услуги курьера",
                         @"Доктор на дом", @"Личный тренер",@"Мастер на все руки",@"Массаж", nil];
    whatLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whatLabelTapped)];
    [whatLabel addGestureRecognizer:tapGesture];
}

-(void)whatLabelTapped{
    picker.hidden=NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)infoButton:(UIButton *)sender {
}

- (IBAction)submitButton:(UIButton *)sender {
    NSString *whereString = where.text;
    NSString *nameString=name.text;
    NSString *phoneString=phone.text;
    NSString *emailString=email.text;
    int numberLength=10;
    //Check values
    
    
    
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

- (void) Alert: (NSString*)title :(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
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

@end
