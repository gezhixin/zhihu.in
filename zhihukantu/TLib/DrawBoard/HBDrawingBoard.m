//
//  HBDrawingBoard.m
//  DemoAntiAliasing
//
//  Created by 伍宏彬 on 15/11/2.
//  Copyright (c) 2015年 HB. All rights reserved.
//

#import "HBDrawingBoard.h"
#import "HBDrawPoint.h"
#import "NSFileManager+Helper.h"
#import <YYCategories/YYCategories.h>

@interface HBDrawingBoard()
{
    UIColor *_lastColor;
    CGFloat _lastLineWidth;
    
    CGFloat _lineWidth;
    UIColor *_lineColor;

}

@property (nonatomic, strong) NSMutableArray *paths;

@property (nonatomic, strong) NSMutableArray *tempPath;

@property (nonatomic, strong) UIImageView *drawImage;

@property (nonatomic, strong) HBDrawView *drawView;


@end

#define ThumbnailPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"HBThumbnail"]

@implementation HBDrawingBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _lineColor = [UIColor redColor];
        _lineWidth = 2;
        [self addSubview:self.drawImage];
        [self.drawImage addSubview:self.drawView];
        self.editEnabled = NO;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _lineColor = [UIColor redColor];
        _lineWidth = 2;
        [self addSubview:self.drawImage];
        [self.drawImage addSubview:self.drawView];
        self.editEnabled = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.drawImage.frame = self.bounds;
    self.drawView.frame = self.bounds;
}

- (void)clean {
    self.drawImage.image = [UIImage imageWithColor:[UIColor clearColor]];
    for (HBPath *path in self.paths) {
        [[NSFileManager defaultManager] removeItemAtPath:path.imagePath error:nil];
    }
    
    [self.paths removeAllObjects];
}

#pragma mark - CustomMethd
- (CGPoint)getTouchSet:(NSSet *)touches{
    
    UITouch *touch = [touches anyObject];
     return [touch locationInView:self];

}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (!_editEnabled) {
        return;
    }
    
    CGPoint point = [self getTouchSet:touches];

    HBPath *path = [HBPath pathToPoint:point pathWidth:_lineWidth isEraser:self.ise];

    path.pathColor = _lineColor;
    path.imagePath = [NSString stringWithFormat:@"%@.png",[self getTimeString]];
    
    [self.paths addObject:path];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (!_editEnabled) {
        return;
    }
    
    CGPoint point = [self getTouchSet:touches];

    HBPath *path = [self.paths lastObject];
    
    [path pathLineToPoint:point WithType:self.shapType];
    
    if (self.ise) {
        [self setEraseBrush:path];
    }else{
        [self.drawView setBrush:path];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (!_editEnabled) {
        return;
    }
    
    HBPath *path = [self.paths lastObject];
    
    UIImage *image = [self.drawImage snapshotImage];
    
    self.drawImage.image = image;
    
    [self.drawView setBrush:nil];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *filePath = [ThumbnailPath stringByAppendingPathComponent:path.imagePath];
    
    BOOL isSave = [NSFileManager hb_saveData:imageData filePath:filePath];
    
    if (isSave) {
        NSLog(@"%@", [NSString stringWithFormat:@"保存成功: %@",filePath]);
    }
    
}

- (NSString *)getTimeString{
    
    NSDateFormatter  *dateformatter = nil;
    if (!dateformatter) {
        dateformatter = [[NSDateFormatter alloc] init];
    }
    
    [dateformatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    
    return [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}

- (void)setEraseBrush:(HBPath *)path{
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0);

    
    [[UIColor clearColor] set];
    
    path.bezierPath.lineWidth = _lineWidth;
    
    [path.bezierPath strokeWithBlendMode:kCGBlendModeClear alpha:1.0];
    
    [path.bezierPath stroke];
    
    UIGraphicsEndImageContext();
    
}

#pragma mark - Lazying
- (NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (NSMutableArray *)tempPath{
    if (!_tempPath) {
        _tempPath = [NSMutableArray array];
    }
    return _tempPath;
}
- (void)setShapType:(HBDrawingShapeType)shapType{
    if (self.ise) {
        return;
    }
    _shapType = shapType;
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (self.ise) {
        
        _lastColor = lineColor;
        
        return;
    }
    
    _lineColor = lineColor;
}
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    _lastLineWidth = lineWidth;
}

- (HBDrawView *)drawView{
    if (!_drawView) {
        _drawView = [HBDrawView new];
        _drawView.backgroundColor = [UIColor clearColor];
        _drawView.frame = self.bounds;
        
    }
    return _drawView;
}


- (UIImageView *)drawImage
{
    if (!_drawImage) {
        _drawImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _drawImage.backgroundColor = [UIColor clearColor];
        _drawImage.contentMode = UIViewContentModeScaleToFill;
        _drawImage.opaque = NO;
    }
    return _drawImage;
}

- (void)reDo {
    
    HBPath * path = [self.paths lastObject];
    
    if (!path) {
        return;
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:path.imagePath error:nil];
    
    [self.paths removeLastObject];
    
    path = [self.paths lastObject];
    
    if (path) {
        NSString * filePath = [ThumbnailPath stringByAppendingPathComponent:path.imagePath];
        UIImage  * image = [UIImage imageWithContentsOfFile:filePath];
        self.drawImage.image = image ? image : [UIImage imageWithColor:[UIColor clearColor]];
    } else {
        self.drawImage.image = [UIImage imageWithColor:[UIColor clearColor]];
    }
}

@end

#pragma mark - HBPath
@interface HBPath()

@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGFloat pathWidth;

@end

@implementation HBPath

+ (instancetype)pathToPoint:(CGPoint)beginPoint pathWidth:(CGFloat)pathWidth isEraser:(BOOL)isEraser
{
    HBPath *path = [[HBPath alloc] init];
    path.beginPoint = beginPoint;
    path.pathWidth = pathWidth;
    path.isEraser = isEraser;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = pathWidth;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [bezierPath moveToPoint:beginPoint];
    path.bezierPath = bezierPath;
    
    return path;
}
//HBDrawingShapeCurve = 0,//曲线
//HBDrawingShapeLine,//直线
//HBDrawingShapeEllipse,//椭圆
//HBDrawingShapeRect,//矩形
- (void)pathLineToPoint:(CGPoint)movePoint WithType:(HBDrawingShapeType)shapeType
{
    //判断绘图类型
    _shapType = shapeType;
    switch (shapeType) {
        case HBDrawingShapeCurve:
        {
            [self.bezierPath addLineToPoint:movePoint];
        }
            break;
        case HBDrawingShapeLine:
        {
            self.bezierPath = [UIBezierPath bezierPath];
            self.bezierPath.lineCapStyle = kCGLineCapRound;
            self.bezierPath.lineJoinStyle = kCGLineJoinRound;
            self.bezierPath.lineWidth = self.pathWidth;
            [self.bezierPath moveToPoint:self.beginPoint];
            [self.bezierPath addLineToPoint:movePoint];
        }
            break;
        case HBDrawingShapeEllipse:
        {
            self.bezierPath = [UIBezierPath bezierPathWithRect:[self getRectWithStartPoint:self.beginPoint endPoint:movePoint]];
            self.bezierPath.lineCapStyle = kCGLineCapRound;
            self.bezierPath.lineJoinStyle = kCGLineJoinRound;
            self.bezierPath.lineWidth = self.pathWidth;
        }
            break;
        case HBDrawingShapeRect:
        {
            self.bezierPath = [UIBezierPath bezierPathWithOvalInRect:[self getRectWithStartPoint:self.beginPoint endPoint:movePoint]];
            self.bezierPath.lineCapStyle = kCGLineCapRound;
            self.bezierPath.lineJoinStyle = kCGLineJoinRound;
            self.bezierPath.lineWidth = self.pathWidth;
        }
            break;
        default:
            break;
    }
}

- (CGRect)getRectWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGPoint orignal = startPoint;
    if (startPoint.x > endPoint.x) {
        orignal = endPoint;
    }
    CGFloat width = fabs(startPoint.x - endPoint.x);
    CGFloat height = fabs(startPoint.y - endPoint.y);
    return CGRectMake(orignal.x , orignal.y , width, height);
}

@end

@implementation HBDrawView

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)setBrush:(HBPath *)path
{
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    
    shapeLayer.strokeColor = path.pathColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = path.bezierPath.lineWidth;
    ((CAShapeLayer *)self.layer).path = path.bezierPath.CGPath;
}


@end
