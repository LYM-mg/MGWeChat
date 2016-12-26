//
//  ShakeVC.m
//  MGWeChat
//
//  Created by ming on 16/8/18.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ShakeVC.h"
#import <AudioToolbox/AudioToolbox.h>

#import "MGShakeBottomView.h"

#pragma mark - define
#define kVoiceRecorderTotalTime 60.0

// iPad
#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIs_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhone_6 (kIs_iPhone && MDK_SCREEN_HEIGHT == 667.0)
#define kIs_iPhone_6P (kIs_iPhone && MDK_SCREEN_HEIGHT == 736.0)

#define kXHSelectedButtonSpacing (kIsiPad ? 80 : 40)

@interface ShakeVC ()<MGShakeBottomViewDelegate>
{
    SystemSoundID shakingSoundIDBegan;
    SystemSoundID shakingSoundIDEnd;
}
/** 上面的图片 */
@property (nonatomic, strong) UIImageView *shakeUpImageView;
/** 上面的Line的图片 */
@property (nonatomic, strong) UIImageView *shakeUpLineImageView;

/** 下面的图片 */
@property (nonatomic, strong) UIImageView *shakeDownImageView;
/** 下面的Line的图片 */
@property (nonatomic, strong) UIImageView *shakeDownLineImageView;

/** 背景图片 */
@property (nonatomic, strong) UIImageView *shakeBackgroundImageView;

/** 动画的摇动的距离 */
@property (nonatomic, assign) CGFloat animationDistans;
/** 底部的view */
@property (nonatomic, weak) MGShakeBottomView *shakeBottomView;
@end

@implementation ShakeVC

#pragma mark - lazy
- (UIImageView *)shakeUpImageView {
    if (!_shakeUpImageView) {
        _shakeUpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height / 3)];
        _shakeUpImageView.backgroundColor = self.view.backgroundColor;
        _shakeUpImageView.image = [UIImage imageNamed:@"Shake_Logo_Up"];
        _shakeUpImageView.contentMode = UIViewContentModeBottom;
        
        [_shakeUpImageView addSubview:self.shakeUpLineImageView];
    }
    return _shakeUpImageView;
}

- (UIImageView *)shakeDownImageView {
    if (!_shakeDownImageView) {
        _shakeDownImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shakeUpImageView.frame), self.shakeUpImageView.width, self.view.height - self.shakeUpImageView.height)];
        _shakeDownImageView.backgroundColor = self.view.backgroundColor;
        _shakeDownImageView.userInteractionEnabled = YES;
        _shakeDownImageView.image = [UIImage imageNamed:@"Shake_Logo_Down"];
        _shakeDownImageView.contentMode = UIViewContentModeTop;
        
        [_shakeDownImageView addSubview:self.shakeDownLineImageView];
    }
    return _shakeDownImageView;
}

- (UIImageView *)shakeUpLineImageView {
    if (!_shakeUpLineImageView) {
        _shakeUpLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_shakeUpImageView.frame) - 3, self.view.width, 10)];
        _shakeUpLineImageView.image = [UIImage imageNamed:@"Shake_Line_Up"];
        _shakeUpLineImageView.hidden = YES;
    }
    return _shakeUpLineImageView;
}

- (UIImageView *)shakeDownLineImageView {
    if (!_shakeDownLineImageView) {
        _shakeDownLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -7, self.view.width, 10)];
        _shakeDownLineImageView.image = [UIImage imageNamed:@"Shake_Line_Down"];
        _shakeDownLineImageView.hidden = YES;
    }
    return _shakeDownLineImageView;
}

- (UIImageView *)shakeBackgroundImageView {
    if (!_shakeBackgroundImageView) {
        _shakeBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.shakeUpImageView.frame) - self.animationDistans, CGRectGetWidth(self.view.bounds), self.animationDistans * 2)];
        _shakeBackgroundImageView.image = [UIImage imageNamed:@"AlbumHeaderBackgrounImage.jpg"];
    }
    return _shakeBackgroundImageView;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    /// 设置主界面
    [self setUpMainView];
    
    /// 开启摇一摇功能
    //想摇你的手机嘛？就写在这，然后，然后，没有然后了
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
}

- (void)setUpMainView {
    self.title = NSLocalizedStringFromTable(@"Shake", @"MessageDisplayKitString", @"摇一摇");
    
    self.animationDistans = kIsiPad ? 230 : 150;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.102 green:0.102 blue:0.114 alpha:1.000];
    
    [self.view addSubview:self.shakeUpImageView];
    [self.view addSubview:self.shakeDownImageView];
    
    [self.view addSubview:self.shakeBackgroundImageView];
    [self.view sendSubviewToBack:self.shakeBackgroundImageView];
    
    
    MGShakeBottomView *shakeBottomView = [[MGShakeBottomView alloc] init];
    shakeBottomView.delegate = self;
    [self.view addSubview:shakeBottomView];
    self.shakeBottomView = shakeBottomView;
    [shakeBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        make.height.equalTo(@50);
        make.width.equalTo(@(self.view.width - 80));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

#pragma mark - MGShakeBottomViewDelegate
- (void)shakeBottomView:(MGShakeBottomView *)shakeBottomView withShakeButtonType:(MGShakeButtonType)type{
    switch (type) {
        case MGShakePeopleButton: // 人
            
            break;
        case MGShakeMusicButton:  // 声音
            
            break;
            
        case MGShakeTvButton: // 电视
            
            break;
        default:
            break;
    }
}

#pragma mark - Animation Delegate
- (void)animationDidStart:(CAAnimation *)anim {
    self.shakeUpLineImageView.hidden = NO;
    self.shakeDownLineImageView.hidden = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.shakeUpLineImageView.hidden = flag;
    self.shakeDownLineImageView.hidden = flag;
    if (flag) {
        [self pullServerNearUsers];
    }
}

/**
 *  获取附近的用户
 */
- (void)pullServerNearUsers {
    
}

#pragma mark - Event Delegate
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(motion == UIEventSubtypeMotionShake) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shake_sound_male.wav" ofType:@""]]), &shakingSoundIDBegan);
        
        // 播放声音
        AudioServicesPlaySystemSound(shakingSoundIDBegan);
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        // 真实一点的摇动动画
        [self shaking];
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(motion == UIEventSubtypeMotionShake) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 播放声音
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shake_match.wav" ofType:@""]]), &shakingSoundIDEnd);
            
            AudioServicesPlaySystemSound(shakingSoundIDEnd);
//            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        });
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(motion == UIEventSubtypeMotionShake) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shake_nomatch.wav" ofType:@""]]), &shakingSoundIDEnd);
        
        // 播放声音
        AudioServicesPlaySystemSound(shakingSoundIDEnd);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}


#pragma mark - 摇一摇
/**
 *  摇一摇
 */
- (void)shaking {
    // 1.上边的图片
    CABasicAnimation *shakeUpImageViewAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeUpImageViewAnimation.fromValue = 0;
    shakeUpImageViewAnimation.toValue = [NSNumber numberWithFloat:-self.animationDistans];
    shakeUpImageViewAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    shakeUpImageViewAnimation.duration = 0.4;
    shakeUpImageViewAnimation.removedOnCompletion = NO;
    shakeUpImageViewAnimation.fillMode = kCAFillModeBoth;
    shakeUpImageViewAnimation.autoreverses = YES;
    
    // 2.下边的图片
    CABasicAnimation *shakeDownImageViewAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeDownImageViewAnimation.delegate = self;
    shakeDownImageViewAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    shakeDownImageViewAnimation.fromValue = 0;
    shakeDownImageViewAnimation.toValue = [NSNumber numberWithFloat:self.animationDistans];
    shakeDownImageViewAnimation.duration = 0.4;
    shakeDownImageViewAnimation.removedOnCompletion = NO;
    shakeDownImageViewAnimation.autoreverses = YES;
    shakeDownImageViewAnimation.fillMode = kCAFillModeBoth;
    
    [self.shakeUpImageView.layer addAnimation:shakeUpImageViewAnimation forKey:@"shakeUpImageViewAnimationKey"];
    [self.shakeDownImageView.layer addAnimation:shakeDownImageViewAnimation forKey:@"shakeDownImageViewAnimationKey"];
}


@end
