//
//  LightModeInterfaceController.m
//  TheBeam
//
//  Created by 大畅 on 15/6/9.
//  Copyright (c) 2015年 Dachang. All rights reserved.
//

#import "LightModeInterfaceController.h"

@interface LightModeInterfaceController ()
{
    NSInteger currentMode;
}
@property (strong, nonatomic) IBOutlet WKInterfaceButton *modeWorkButton;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *modeEntertainmentButton;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *modeCinemaButton;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *modeSleepButton;

@end

@implementation LightModeInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    currentMode = 0;
    [_modeWorkButton setBackgroundImageNamed:@"wkModeWorkSelect"];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)modeWorkButtonPressed {
    if (currentMode != 0) {
        [_modeWorkButton setBackgroundImageNamed:@"wkModeWorkSelect"];
    }
    [_modeEntertainmentButton setBackgroundImageNamed:@"wkModeEntertainment"];
    [_modeCinemaButton setBackgroundImageNamed:@"wkModeCinema"];
    [_modeSleepButton setBackgroundImageNamed:@"wkModeSleep"];
    currentMode = 0;
}

- (IBAction)modeEntertainmentButtonPressed {
    if (currentMode != 1) {
        [_modeEntertainmentButton setBackgroundImageNamed:@"wkModeEntertainmentSelect"];
    }
    [_modeWorkButton setBackgroundImageNamed:@"wkModeWork"];
    [_modeCinemaButton setBackgroundImageNamed:@"wkModeCinema"];
    [_modeSleepButton setBackgroundImageNamed:@"wkModeSleep"];
    currentMode = 1;
}

- (IBAction)modeCinemaButtonPressed {
    if (currentMode != 2) {
        [_modeCinemaButton setBackgroundImageNamed:@"wkModeCinemaSelect"];
    }
    [_modeWorkButton setBackgroundImageNamed:@"wkModeWork"];
    [_modeEntertainmentButton setBackgroundImageNamed:@"wkModeEntertainment"];
    [_modeSleepButton setBackgroundImageNamed:@"wkModeSleep"];
    currentMode = 2;
}

- (IBAction)modeSleepButtonPressed {
    if (currentMode != 3) {
        [_modeSleepButton setBackgroundImageNamed:@"wkModeSleepSelect"];
    }
    [_modeWorkButton setBackgroundImageNamed:@"wkModeWork"];
    [_modeEntertainmentButton setBackgroundImageNamed:@"wkModeEntertainment"];
    [_modeCinemaButton setBackgroundImageNamed:@"wkModeCinema"];
    currentMode = 3;
}



@end



