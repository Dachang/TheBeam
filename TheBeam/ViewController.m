//
//  ViewController.m
//  TheBeam
//
//  Created by 大畅 on 15/6/7.
//  Copyright (c) 2015年 Dachang. All rights reserved.
//

#import "ViewController.h"
#import "DynamicColorViewController.h"

#define UI_RESIZE_FACTOR [UIScreen mainScreen].bounds.size.width / 414.f

@interface ViewController ()
{
    BOOL isPowerOn;
    NSInteger selectedMode;
    NSInteger lightIndensity;
    
    NSArray *modeButtonSelectedImageArray, *modeButtonUnselectedImageArray;
    NSArray *modeButtonArray;
}
@property (nonatomic, strong) DynamicColorViewController *colorScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetUp];
    [self loadColorScrollView];
    [self setUpUIView];
    [self setUpSliderView];
}

- (void)basicSetUp {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    modeButtonArray = @[_modeWorkButton, _modeEntertainmentButton, _modeCinemaButton, _modeSleepButton];
    modeButtonSelectedImageArray = @[@"mode_work_on",@"mode_entertainment_on",@"mode_cinema_on",@"mode_sleep_on"];
    modeButtonUnselectedImageArray = @[@"mode_work_off",@"mode_entertainment_off",@"mode_cinema_off",@"mode_sleep_off"];
    
    isPowerOn = NO;
    selectedMode = 0;
    lightIndensity = [UIScreen mainScreen].brightness * 100;
}

- (void)loadColorScrollView {
    NSArray *coverImageNames = @[@"", @"", @"", @"", @""];
    NSArray *backgroundImageNames = @[@"greenColorBackground", @"purpleColorBackground", @"orangeColorBackground",  @"blueColorBackground",  @"yellowColorBackground"];
    self.colorScrollView = [[DynamicColorViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
    
    [self.view addSubview:self.colorScrollView.view];
}

- (void)setUpUIView {
    _lightCondenseIndicatorLabel.text = @"灯光关闭";
    _lightCondenseIndicatorLabel.textColor = [UIColor blackColor];
    _LightCondenseLabel.text = @"0";
    _LightCondenseLabel.textColor = [UIColor blackColor];
    
    _modeWorkButton.alpha = _modeEntertainmentButton.alpha = _modeCinemaButton.alpha = _modeSleepButton.alpha = 0.2f;
    _modeWorkButton.userInteractionEnabled = _modeEntertainmentButton.userInteractionEnabled = _modeCinemaButton.userInteractionEnabled = _modeSleepButton.userInteractionEnabled = NO;
    
    _colorScrollView.view.transform = CGAffineTransformMakeScale(0.0, 0.0);

    [self.view bringSubviewToFront:_LightCondenseLabel];
    [self.view bringSubviewToFront:_lightCondenseIndicatorLabel];
    [self.view bringSubviewToFront:_powerButton];
    [self.view bringSubviewToFront:_modeWorkButton];
    [self.view bringSubviewToFront:_modeEntertainmentButton];
    [self.view bringSubviewToFront:_modeCinemaButton];
    [self.view bringSubviewToFront:_modeSleepButton];
    [self.view bringSubviewToFront:_lightIndenseSlider];
    
    for (UIButton *btn in modeButtonArray) {
        [btn setExclusiveTouch:YES];
    }
}

- (void)setUpSliderView {
    CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI_2);
    _lightIndenseSlider.transform = trans;
    
    UIImage *thumbImage = [UIImage imageNamed:@"lightSliderThumb"];
    [_lightIndenseSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    [_lightIndenseSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    
    UIImage *leftTrack = [UIImage imageNamed:@"singularSliderTrack"];
    UIImage *rightTrack = [UIImage imageNamed:@"singularSliderTrack"];
    UIImage *nonStretchLeftTrack = [leftTrack resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    [_lightIndenseSlider setMinimumTrackImage:nonStretchLeftTrack forState:UIControlStateNormal];
    [_lightIndenseSlider setMaximumTrackImage:rightTrack forState:UIControlStateNormal];
    
    [_lightIndenseSlider addTarget:self action:@selector(adjustLabelForSlider:withEvent:) forControlEvents:UIControlEventValueChanged];
    
    _lightIndenseSlider.value = [UIScreen mainScreen].brightness;
    _lightIndenseSlider.alpha = 0;
    _lightIndenseSlider.userInteractionEnabled = NO;
}

#pragma mark - IBOutlets
- (IBAction)powerButtonPressed:(id)sender {
    _powerButton.userInteractionEnabled = NO;
    isPowerOn = !isPowerOn;
    if (isPowerOn) {
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:2.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            _colorScrollView.view.alpha = 1.0;
            _colorScrollView.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            _modeWorkButton.alpha = _modeEntertainmentButton.alpha = _modeCinemaButton.alpha = _modeSleepButton.alpha = 1.f;
            
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished){
            _modeWorkButton.userInteractionEnabled = _modeEntertainmentButton.userInteractionEnabled = _modeCinemaButton.userInteractionEnabled = _modeSleepButton.userInteractionEnabled = YES;
            _powerButton.userInteractionEnabled = YES;
        }];
        
        _lightCondenseIndicatorLabel.text = @"当前亮度";
        _lightCondenseIndicatorLabel.textColor = [UIColor whiteColor];
        _LightCondenseLabel.text = [NSString stringWithFormat:@"%ld",lightIndensity];
        _LightCondenseLabel.textColor = [UIColor whiteColor];
        
        _lightIndenseSlider.alpha = 1;
        _lightIndenseSlider.userInteractionEnabled = YES;
        
        [self updateModeButtonAppearanceWithSelectedMode:selectedMode];
    } else {
        [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            _colorScrollView.view.alpha = 0.0;
            
            _modeWorkButton.alpha = _modeEntertainmentButton.alpha = _modeCinemaButton.alpha = _modeSleepButton.alpha = 0.2f;
            
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished){
            _colorScrollView.view.transform = CGAffineTransformMakeScale(0.0, 0.0);
            _modeWorkButton.userInteractionEnabled = _modeEntertainmentButton.userInteractionEnabled = _modeCinemaButton.userInteractionEnabled = _modeSleepButton.userInteractionEnabled = NO;
             _powerButton.userInteractionEnabled = YES;
        }];
        
        _lightCondenseIndicatorLabel.text = @"灯光关闭";
        _lightCondenseIndicatorLabel.textColor = [UIColor blackColor];
        _LightCondenseLabel.text = @"0";
        _LightCondenseLabel.textColor = [UIColor blackColor];
        
        _lightIndenseSlider.alpha = 0;
        _lightIndenseSlider.userInteractionEnabled = NO;
        
        [self resetModeButtonAppearance];
    }
}

- (IBAction)modeButtonPressed:(id)sender {
    for (int i = 0; i < 4; i++) {
        if (i != [sender tag]) {
            [[modeButtonArray objectAtIndex:i] setImage:[UIImage imageNamed:[modeButtonUnselectedImageArray objectAtIndex:i]] forState:UIControlStateNormal];
            [[modeButtonArray objectAtIndex:i] setUserInteractionEnabled:NO];
        } else {
            UIButton *tempButton = [[UIButton alloc] initWithFrame:[[modeButtonArray objectAtIndex:i] frame]];
            [tempButton setImage:[UIImage imageNamed:[modeButtonSelectedImageArray objectAtIndex:i]] forState:UIControlStateNormal];
            [tempButton setAlpha:0.0];
            [self.view addSubview:tempButton];
            
            [UIView animateWithDuration:0.3 animations:^{
                [[modeButtonArray objectAtIndex:i] setAlpha:0.0];
                [tempButton setAlpha:1.0];
            }completion:^(BOOL finished){
                if (finished) {
                    [[modeButtonArray objectAtIndex:i] setAlpha:1.0];
                    [[modeButtonArray objectAtIndex:i] setImage:[UIImage imageNamed:[modeButtonSelectedImageArray objectAtIndex:i]] forState:UIControlStateNormal];
                    [tempButton removeFromSuperview];
                    for (int j = 0; j < 4; j++) {
                        if (j != i) {
                            [[modeButtonArray objectAtIndex:j] setUserInteractionEnabled:YES];
                        }
                    }
                }
            }];
        }
    }
    
    selectedMode = [sender tag];
}

#pragma mark - Target Selector
- (void)adjustLabelForSlider:(UISlider *)sender withEvent:(UIEvent*)e {
    _LightCondenseLabel.text = [NSString stringWithFormat:@"%.0f",sender.value * 100];
    [UIScreen mainScreen].brightness = sender.value;
    
    UITouch *touch = [e.allTouches anyObject];
    if (touch.phase != UITouchPhaseMoved && touch.phase != UITouchPhaseBegan) {
        lightIndensity = [_LightCondenseLabel.text integerValue];
    }
}

#pragma mark - Utilities
- (void)updateModeButtonAppearanceWithSelectedMode:(NSInteger)mode {
    for (int i = 0; i < 4; i++) {
        if (i != mode) {
            [[modeButtonArray objectAtIndex:i] setImage:[UIImage imageNamed:[modeButtonUnselectedImageArray objectAtIndex:i]] forState:UIControlStateNormal];
        } else {
            [[modeButtonArray objectAtIndex:i] setImage:[UIImage imageNamed:[modeButtonSelectedImageArray objectAtIndex:i]] forState:UIControlStateNormal];
        }
    }
}

- (void)resetModeButtonAppearance {
    for (int i = 0; i < 4; i++) {
        [[modeButtonArray objectAtIndex:i] setImage:[UIImage imageNamed:[modeButtonUnselectedImageArray objectAtIndex:i]] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
