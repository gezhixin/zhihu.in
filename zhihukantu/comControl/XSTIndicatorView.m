//
//  XSTIndicatorView.m
//  xiaoshutong
//
//  Created by 葛枝鑫 on 2017/4/24.
//  Copyright © 2017年 葛枝鑫. All rights reserved.
//

#import "XSTIndicatorView.h"
#import <pop/pop.h>

@interface XSTIndicatorView () {
    CAShapeLayer *_animationLayer;
    CADisplayLink *_link;
    
    CGFloat _startAngle;
    CGFloat _endAngle;
    CGFloat _progress;
}

@end

@implementation XSTIndicatorView

- (void)setColor:(UIColor *)color {
    _color = color;
    _animationLayer.strokeColor = _color.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    _animationLayer.lineWidth = _lineWidth;
}

- (void)setAnimated:(BOOL)animated {
    _animated = animated;
    if (animated) {
        [self _start];
    } else {
        [self _hide];
    }
}

-(void)_start{
    _link.paused = false;
}

-(void)_hide{
    _link.paused = true;
    _progress = 0;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.lineWidth = 4;
        self.color = [UIColor redColor];
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    _animationLayer = [CAShapeLayer layer];
    _animationLayer.bounds = CGRectMake(0, 0, self.width, self.height);
    _animationLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
    _animationLayer.fillColor = [UIColor clearColor].CGColor;
    _animationLayer.strokeColor = _color.CGColor;
    _animationLayer.lineWidth = _lineWidth;
    _animationLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_animationLayer];
    
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link.paused = true;
    
}

-(void)displayLinkAction{
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimationLayer];
}

-(void)updateAnimationLayer{
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 +_progress * M_PI * 2;
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress)/0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - _lineWidth/2.0f;
    CGFloat centerX = _animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = _animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    
    _animationLayer.path = path.CGPath;
}

-(CGFloat)speed{
    if (_endAngle > M_PI) {
        return 0.3/60.0f;
    }
    return 2/60.0f;
}

@end
