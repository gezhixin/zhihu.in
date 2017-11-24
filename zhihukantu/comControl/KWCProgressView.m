//
//  KWCProgressView.m
//  KW2496
//
//  Created by 葛枝鑫 on 2017/3/30.
//  Copyright © 2017年 www.kuwo.cn. All rights reserved.
//

#import "KWCProgressView.h"
#import <YYCategories/YYCategories.h>

@interface KWCProgressView () {
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}




@end

@implementation KWCProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _trackLayer = [CAShapeLayer new];
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = nil;
        _trackLayer.frame = self.bounds;
        
        _progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.frame = self.bounds;
        
        self.progressWidth = 1;
        self.trackColor = [UIColor colorWithRGB:0x0 alpha:0.35];
        self.progressColor = [UIColor colorWithRGB:0x0 alpha:0.85];
        self.progress = 0;
        self.track = 1;
    }
    return self;
}

- (void)setTrack:(CGFloat)track
{
    _track = MAX(0, MIN(1, track));;
    _trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:self.width / 2 - _progressWidth startAngle:0 - M_PI_2 endAngle:M_PI * 2 * _track - M_PI_2 clockwise:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        _trackLayer.path = _trackPath.CGPath;
    });
}

- (void)setProgress:(CGFloat)progress
{
    if (fabs(_progress - progress) < 0.1) {
        return;
    }
    _progress = MAX(0, MIN(1, progress));
    _progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                                                   radius:self.width / 2 - _progressWidth
                                               startAngle:0 - M_PI_2
                                                 endAngle:M_PI * 2 * _progress - M_PI_2
                                                clockwise:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        _progressLayer.path = _progressPath.CGPath;
    });
}


- (void)setProgressWidth:(float)progressWidth
{
    _progressWidth = progressWidth;
    _trackLayer.lineWidth = _progressWidth;
    _progressLayer.lineWidth = _progressWidth;
}

- (void)setTrackColor:(UIColor *)trackColor
{
    _trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressLayer.strokeColor = progressColor.CGColor;
}



@end
