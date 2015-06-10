//
//  InterfaceController.m
//  TheBeam WatchKit Extension
//
//  Created by 大畅 on 15/6/9.
//  Copyright (c) 2015年 Dachang. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
{
    BOOL lightIsOn;
}
@property (strong, nonatomic) IBOutlet WKInterfaceImage *lightIndensityIndicator;
@property (strong, nonatomic) IBOutlet WKInterfaceSlider *lightIndensitySlider;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *powerButton;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *lightModeButton;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *colorPickButton;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *lightIndensityLabel;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    lightIsOn = NO;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)powerButtonPressed {
    lightIsOn = !lightIsOn;
    if (lightIsOn) {
        [_powerButton setTitle:@"关闭"];
        [_lightModeButton setHidden:NO];
        [_colorPickButton setHidden:NO];
    } else {
        [_powerButton setTitle:@"开启"];
        [_lightModeButton setHidden:YES];
        [_colorPickButton setHidden:YES];
    }
}

- (IBAction)sliderValueChanged:(float)value {
    [_lightIndensityIndicator setAlpha:value / 100];
    [_lightIndensityLabel setText:[NSString stringWithFormat:@"灯光强度  %.0f",value]];
}

@end



