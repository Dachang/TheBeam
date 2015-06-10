//
//  DynamicColorViewController.h
//  The Beam
//
//  Created by 大畅 on 15/6/7.
//  Copyright (c) 2015年 Dachang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();

@interface DynamicColorViewController : UIViewController

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) UIButton *enterButton;

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;

@property (nonatomic, strong) NSArray *backgroundImageNames;
@property (nonatomic, strong) NSArray *coverImageNames;


- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames;


- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button;

@end
