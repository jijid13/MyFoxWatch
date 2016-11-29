//
//  InterfaceController.h
//  KaziMyFox WatchKit Extension
//
//  Created by Madjid KAZI-TANI on 20/07/2015.
//  Copyright (c) 2015 Madjid KAZI-TANI. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property(nonatomic, retain) NSString *token;
@property(nonatomic, retain) NSUserDefaults *defaults;
@property long status;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *statusbutton;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *firstbutton;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *secondbutton;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *statusLabel;

@end
