//
//  InterfaceController.m
//  KaziMyFox WatchKit Extension
//
//  Created by Madjid KAZI-TANI on 20/07/2015.
//  Copyright (c) 2015 Madjid KAZI-TANI. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController {
    bool wait;
}

@synthesize token, defaults;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.kzmyfox.watchkitappsettings"];
    [self gettoken];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)getstatus {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.myfox.me:443/v2/site/%@/security/get?access_token=%@", [defaults objectForKey:@"site"], self.token]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *e = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
        
        self.status = [JSON[@"payload"][@"status"] longValue];
        
        if(self.status == 1){
            [self.statusbutton setBackgroundColor:[UIColor colorWithRed:(2/255.0) green:(198/255.0) blue:(113/255.0) alpha:1]];
            [self.statusLabel setTextColor:[UIColor colorWithRed:(2/255.0) green:(198/255.0) blue:(113/255.0) alpha:1]];
            [self.statusLabel setText:@"  Deactivated"];
            [self.firstbutton setBackgroundColor:[UIColor redColor]];
            [self.firstbutton setTitle:@"Activate"];
            [self.secondbutton setBackgroundColor:[UIColor orangeColor]];
            [self.secondbutton setTitle:@"Activate Partially"];
        } else if(self.status == 2){
            [self.statusbutton setBackgroundColor:[UIColor orangeColor]];
            [self.statusLabel setTextColor:[UIColor orangeColor]];
            [self.statusLabel setText:@"  Partially"];
            [self.firstbutton setBackgroundColor:[UIColor colorWithRed:(2/255.0) green:(198/255.0) blue:(113/255.0) alpha:1]];
            [self.firstbutton setTitle:@"Deactivate"];
            [self.secondbutton setBackgroundColor:[UIColor redColor]];
            [self.secondbutton setTitle:@"Activate"];
        } else if(self.status == 4){
            [self.statusbutton setBackgroundColor:[UIColor redColor]];
            [self.statusLabel setTextColor:[UIColor redColor]];
            [self.statusLabel setText:@"  Activated"];
            [self.firstbutton setBackgroundColor:[UIColor colorWithRed:(2/255.0) green:(198/255.0) blue:(113/255.0) alpha:1]];
            [self.firstbutton setTitle:@"Deactivate"];
            [self.secondbutton setBackgroundColor:[UIColor orangeColor]];
            [self.secondbutton setTitle:@"Activate Partially"];
        }
    }];
    
    [dataTask resume];
}

- (IBAction)FirstbuttonAction {
    [self gettoken];
    while (wait) {
        //do nothing
    }
    if(self.status == 1){
        [self Activate];
    } else if(self.status == 2){
        [self DeaActivate];
    } else if(self.status == 4){
        [self DeaActivate];
    }
}

- (IBAction)SecondbuttonAction {
    [self gettoken];
    while (wait) {
        //do nothing
    }
    if(self.status == 1){
        [self ActivatePartially];
    } else if(self.status == 2){
        [self Activate];
    } else if(self.status == 4){
        [self ActivatePartially];
    }
}

- (void)Activate {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.myfox.me/v2/site/%@/security/set/armed?access_token=%@", [defaults objectForKey:@"site"], self.token]];
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self getstatus];
    }];
    [dataTask resume];
    
}

- (void)ActivatePartially {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.myfox.me/v2/site/%@/security/set/partial?access_token=%@", [defaults objectForKey:@"site"], self.token]];
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self getstatus];
    }];
    [dataTask resume];
}

- (void)DeaActivate {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.myfox.me/v2/site/%@/security/set/disarmed?access_token=%@", [defaults objectForKey:@"site"], self.token]];
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self getstatus];
    }];
    [dataTask resume];
}

- (void) gettoken{
    NSString* content = [NSString stringWithFormat:@"&grant_type=%@&client_id=%@&client_secret=%@&username=%@&password=%@", @"password",  [defaults objectForKey:@"client_id"], [defaults objectForKey:@"client_secret"], [defaults objectForKey:@"email"], [defaults objectForKey:@"password"]];
    NSURL* url = [NSURL URLWithString:@"https://api.myfox.me/oauth2/token"];
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[content dataUsingEncoding: NSASCIIStringEncoding]];
    
    wait = true;
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *e = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
        
        self.token = JSON[@"access_token"];
        [self getstatus];
        wait = false;
    }];
    
    [dataTask resume];
    
}

@end



