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

- (void)viewDidLoad {
    [super viewDidLoad];
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
@end
