//
//  LottieView.m
//  VioWpaper
//
//  Created by lujh on 2018/8/7.
//  Copyright © 2018年 Vio Wpaper. All rights reserved.
//

#import "LottieView.h"
#import <Lottie/Lottie.h>
@interface LottieView ()

@property (nonatomic,strong) LOTAnimationView *animView;

@end
@implementation LottieView

- (instancetype)initWithFrame:(CGRect)frame animationJson:(NSString*)animationJson
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setupAnimationViewWithanimationJson:animationJson];
    }
    
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

- (void)setupAnimationViewWithanimationJson:(NSString*)animationJson
{
    self.animView = [LOTAnimationView animationNamed:animationJson];
    self.animView.frame = self.bounds;
    [self addSubview:self.animView];
    self.animView.loopAnimation = YES;
    [self.animView play];
}

-(void)dealloc{
    
}
@end
