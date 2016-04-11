//
//  WNXStage08ViewController.m
//  Hardest
//
//  Created by sfbest on 16/4/11.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXStage08ViewController.h"
#import "WNXStage08PeopleView.h"
#import "WNXScoreboardCountView.h"

@interface WNXStage08ViewController ()

@property (nonatomic, strong) WNXStage08PeopleView *photoView;

@end

@implementation WNXStage08ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildStageInfo];
}

- (void)buildStageInfo {
    UIImageView *bgImageIV = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 0, ScreenWidth + 40, ScreenHeight)];
    bgImageIV.image = [UIImage imageNamed:@"02_background01-iphone4"];
    [self.view insertSubview:bgImageIV belowSubview:self.redButton];
    
    self.photoView = [WNXStage08PeopleView viewFromNib];
    self.photoView.frame = CGRectMake(0, ScreenHeight - self.redButton.frame.size.height - self.photoView.frame.size.height, ScreenWidth, self.photoView.frame.size.height);
    [self.view insertSubview:self.photoView aboveSubview:self.redButton];
    
    [self setButtonImage:[UIImage imageNamed:@"02_camera-iphone4"] contenEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    
    [self bringPauseAndPlayAgainToFront];
    
    [self setPhotoViewBlock];
    
    for (UIButton *btn in self.buttons) {
        [btn addTarget:self action:@selector(cameraClick:) forControlEvents:UIControlEventTouchDown];
    }
}

- (void)cameraClick:(UIButton *)sender {
    if ([self.photoView takePhotoWithIndex:((int)sender.tag - 100)]) {
        [((WNXScoreboardCountView *)self.countScore) hit];
    } else {
        [self setButtonsIsActivate:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showGameFail];
        });
    }
}

- (void)setPhotoViewBlock {
    __weak typeof(self) weakSelf = self;
    self.photoView.startTakePhoto = ^{
        [weakSelf setButtonsIsActivate:YES];
    };
    
    self.photoView.shopTakePhoto = ^{
        [weakSelf setButtonsIsActivate:NO];
    };
    
    self.photoView.nextTakePhoto = ^(BOOL isPass){
        if (!isPass) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.photoView showModel];
            });
        } else {
            [weakSelf showResultControllerWithNewScroe:[((WNXScoreboardCountView *)weakSelf.countScore).countLabel.text intValue] unit:@"PTS" stage:weakSelf.stage isAddScore:YES];
        }
    };
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    [self setButtonsIsActivate:NO];
    [self.photoView showModel];
}



@end