//
//  ViewController.h
//  TheBeam
//
//  Created by 大畅 on 15/6/7.
//  Copyright (c) 2015年 Dachang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *LightCondenseLabel;
@property (strong, nonatomic) IBOutlet UILabel *lightCondenseIndicatorLabel;
@property (strong, nonatomic) IBOutlet UIButton *powerButton;
@property (strong, nonatomic) IBOutlet UIButton *modeWorkButton;
@property (strong, nonatomic) IBOutlet UIButton *modeEntertainmentButton;
@property (strong, nonatomic) IBOutlet UIButton *modeCinemaButton;
@property (strong, nonatomic) IBOutlet UIButton *modeSleepButton;
@property (strong, nonatomic) IBOutlet UISlider *lightIndenseSlider;

@end

