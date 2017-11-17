//
//  DDYHeader.m
//  DDYProject
//
//  Created by LingTuan on 17/11/16.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYHeader.h"

#define headerClipAngle 60 // 默认裁剪角度

static inline float radians(double degrees) { return degrees * M_PI / 180; }

//-------------------------------- layer --------------------------------//
@interface DDYHeaderLayer : CAShapeLayer
/** 因为统一裁剪，所以旋转一定角度 */
@property (nonatomic, assign) CGFloat angle;
/** 是否裁剪 */
@property (nonatomic, assign) BOOL isClip;
/** 裁剪角度 */
@property (nonatomic, assign) CGFloat clipHalfAngle;

+ (DDYHeaderLayer *)initWithAngle:(CGFloat)angle isClip:(BOOL)isClip;

@end

@implementation DDYHeaderLayer

- (instancetype)init {
    if (self = [super init]) {
        _angle = 0;
        _isClip = NO;
    }
    return self;
}

+ (DDYHeaderLayer *)initWithAngle:(CGFloat)angle isClip:(BOOL)isClip {
    DDYHeaderLayer *headerLayer = [DDYHeaderLayer layer];
    [headerLayer updateAngle:angle isClip:isClip];
    return headerLayer;
}

- (void)updateAngle:(CGFloat)angle isClip:(BOOL)isClip {
    _angle = angle;
    _isClip = isClip;
    _clipHalfAngle = headerClipAngle/2.;
    self.contentsScale = [UIScreen mainScreen].scale;
}

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    transform = CGAffineTransformRotate(transform, radians(_angle));
    transform = CGAffineTransformTranslate(transform, -CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds));
    
    CGMutablePathRef path = CGPathCreateMutable();
    if (_isClip)
    {
        CGPathAddArc(path, &transform, width/2, height/2, width/2, radians(90-_clipHalfAngle), radians(90+_clipHalfAngle), true);
        CGPathAddArcToPoint(path,
                            &transform,
                            width/2,
                            height/2+(width/2*sin(radians(90-_clipHalfAngle)) - width/2*sin(radians(_clipHalfAngle))*tan(radians(_clipHalfAngle))),
                            width/2+width/2*sin(radians(_clipHalfAngle)), height/2+width/2*sin(radians(90-_clipHalfAngle)),
                            width/2);
    }
    else
    {
        CGPathAddArc(path, &transform, width/2, height/2, width/2, radians(90), radians(90.01), true);
    }
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:path];
    [bezierPath closePath];
    [bezierPath addClip];
    self.path = bezierPath.CGPath;
}

@end

//-------------------------------- view --------------------------------//
@implementation DDYHeader

+ (instancetype)headerWithHeaderWH:(CGFloat)headerWH {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, headerWH, headerWH)];
}

- (void)setImageURLArray:(NSArray *)imageURLArray {
    _imageURLArray = imageURLArray;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (imageURLArray.count == 1) {
        [self view1WithURLs:imageURLArray];
    } else if (imageURLArray.count == 2) {
        [self view2WithURLs:imageURLArray];
    } else if (imageURLArray.count == 3) {
        [self view3WithURLs:imageURLArray];
    } else if (imageURLArray.count == 4) {
        [self view4WithURLs:imageURLArray];
    } else if (imageURLArray.count == 5) {
        [self view5WithURLs:imageURLArray];
    }
}

#pragma mark 一张图片
- (void)view1WithURLs:(NSArray <NSURL *>*)URLs {
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:0 isClip:NO];
    UIImageView *view0 = [self imgViewWithCenter:CGPointMake(self.ddy_h/2, self.ddy_h/2) size:CGSizeMake(self.ddy_w, self.ddy_h) layer:layer0];
    [view0 sd_setImageWithURL:URLs[0] placeholderImage:[UIImage imageNamed:@"1"]];
    [self addSubview:view0];
}

#pragma mark 两张图片
- (void)view2WithURLs:(NSArray <NSURL *>*)URLs {
    CGFloat diameter = self.ddy_w + self.ddy_w- sqrtf(2)*self.ddy_w;
    CGFloat r = diameter/2;
    
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:0 isClip:NO];
    UIImageView *view0 = [self imgViewWithCenter:CGPointMake(r, r) size:CGSizeMake(diameter, diameter) layer:layer0];
    [view0 sd_setImageWithURL:URLs[0] placeholderImage:[UIImage imageNamed:@"1"]];
    [self addSubview:view0];
    
    DDYHeaderLayer *layer1 = [DDYHeaderLayer initWithAngle:180-45 isClip:YES];
    UIImageView *view1 = [self imgViewWithCenter:CGPointMake(r+sqrtf(2)*diameter/2, r+sqrtf(2)*diameter/2) size:CGSizeMake(diameter, diameter) layer:layer1];
    [view1 sd_setImageWithURL:URLs[1] placeholderImage:[UIImage imageNamed:@"2"]];
    [self addSubview:view1];
}

#pragma mark 三张图片
- (void)view3WithURLs:(NSArray <NSURL *>*)URLs {
    CGFloat diameter = self.ddy_w/2;
    CGPoint center0 = CGPointMake(diameter, diameter / 2);
    CGPoint center1 = CGPointMake(center0.x - diameter * sin(radians(30)), diameter / 2 + diameter * cos(radians(30)));
    CGPoint center2 = CGPointMake(center1.x + diameter, center1.y);
    
    self.ddy_h = diameter+sqrtf(3)/2*diameter;
    
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:30 isClip:YES];
    UIImageView *view0 = [self imgViewWithCenter:center0 size:CGSizeMake(diameter, diameter) layer:layer0];
    [view0 sd_setImageWithURL:URLs[0] placeholderImage:[UIImage imageNamed:@"1"]];
    [self addSubview:view0];
    
    DDYHeaderLayer *layer1 = [DDYHeaderLayer initWithAngle:270 isClip:YES];
    UIImageView *view1 = [self imgViewWithCenter:center1 size:CGSizeMake(diameter, diameter) layer:layer1];
    [view1 sd_setImageWithURL:URLs[1] placeholderImage:[UIImage imageNamed:@"2"]];
    [self addSubview:view1];
    
    DDYHeaderLayer *layer2 = [DDYHeaderLayer initWithAngle:150 isClip:YES];
    UIImageView *view2 = [self imgViewWithCenter:center2 size:CGSizeMake(diameter, diameter) layer:layer2];
    [view2 sd_setImageWithURL:URLs[2] placeholderImage:[UIImage imageNamed:@"3"]];
    [self addSubview:view2];
}

#pragma mark 四张图片
- (void)view4WithURLs:(NSArray <NSURL *>*)URLs {
    CGFloat diameter = self.ddy_w/2;
    CGPoint center0 = CGPointMake(diameter/2, diameter/2);
    CGPoint center1 = CGPointMake(center0.x, center0.y + diameter);
    CGPoint center2 = CGPointMake(center1.x + diameter, center1.y);
    CGPoint center3 = CGPointMake(center2.x, center2.y - diameter);
    
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:0 isClip:YES];
    UIImageView *view0 = [self imgViewWithCenter:center0 size:CGSizeMake(diameter, diameter) layer:layer0];
    [view0 sd_setImageWithURL:URLs[0] placeholderImage:[UIImage imageNamed:@"1"]];
    [self addSubview:view0];
    
    DDYHeaderLayer *layer1 = [DDYHeaderLayer initWithAngle:270 isClip:YES];
    UIImageView *view1 = [self imgViewWithCenter:center1 size:CGSizeMake(diameter, diameter) layer:layer1];
    [view1 sd_setImageWithURL:URLs[1] placeholderImage:[UIImage imageNamed:@"2"]];
    [self addSubview:view1];
    
    DDYHeaderLayer *layer2 = [DDYHeaderLayer initWithAngle:180 isClip:YES];
    UIImageView *view2 = [self imgViewWithCenter:center2 size:CGSizeMake(diameter, diameter) layer:layer2];
    [view2 sd_setImageWithURL:URLs[2] placeholderImage:[UIImage imageNamed:@"3"]];
    [self addSubview:view2];
    
    DDYHeaderLayer *layer3 = [DDYHeaderLayer initWithAngle:90 isClip:YES];
    UIImageView *view3 = [self imgViewWithCenter:center3 size:CGSizeMake(diameter, diameter) layer:layer3];
    [view3 sd_setImageWithURL:URLs[3] placeholderImage:[UIImage imageNamed:@"4"]];
    [self addSubview:view3];
}

#pragma mark 五张图片
- (void)view5WithURLs:(NSArray <NSURL *>*)URLs {
    CGFloat r = self.ddy_w / 2 / ( 2*sin(radians(54)) + 1 );
    CGFloat diameter = r * 2;
    CGPoint center0 = CGPointMake(self.ddy_w/2, r);
    CGPoint center1 = CGPointMake(center0.x - diameter * sin(radians(54)), center0.y + diameter * cos(radians(54)));
    CGPoint center2 = CGPointMake(center1.x + diameter * cos(radians(72)), center1.y + diameter * sin(radians(72)));
    CGPoint center3 = CGPointMake(center2.x + diameter, center2.y);
    CGPoint center4 = CGPointMake(center3.x + diameter * cos(radians(72)), center3.y - diameter * sin(radians(72)));
    
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:54 isClip:YES];
    UIImageView *view0 = [self imgViewWithCenter:center0 size:CGSizeMake(diameter, diameter) layer:layer0];
    [view0 sd_setImageWithURL:URLs[0] placeholderImage:[UIImage imageNamed:@"1"]];
    [self addSubview:view0];
    
    DDYHeaderLayer *layer1 = [DDYHeaderLayer initWithAngle:270+72 isClip:YES];
    UIImageView *view1 = [self imgViewWithCenter:center1 size:CGSizeMake(diameter, diameter) layer:layer1];
    [view1 sd_setImageWithURL:URLs[1] placeholderImage:[UIImage imageNamed:@"2"]];
    [self addSubview:view1];
    
    DDYHeaderLayer *layer2 = [DDYHeaderLayer initWithAngle:270 isClip:YES];
    UIImageView *view2 = [self imgViewWithCenter:center2 size:CGSizeMake(diameter, diameter) layer:layer2];
    [view2 sd_setImageWithURL:URLs[2] placeholderImage:[UIImage imageNamed:@"3"]];
    [self addSubview:view2];
    
    DDYHeaderLayer *layer3 = [DDYHeaderLayer initWithAngle:180+18 isClip:YES];
    UIImageView *view3 = [self imgViewWithCenter:center3 size:CGSizeMake(diameter, diameter) layer:layer3];
    [view3 sd_setImageWithURL:URLs[3] placeholderImage:[UIImage imageNamed:@"4"]];
    [self addSubview:view3];
    
    DDYHeaderLayer *layer4 = [DDYHeaderLayer initWithAngle:90+36 isClip:YES];
    UIImageView *view4 = [self imgViewWithCenter:center4 size:CGSizeMake(diameter, diameter) layer:layer4];
    [view4 sd_setImageWithURL:URLs[4] placeholderImage:[UIImage imageNamed:@"1"]];
    [self addSubview:view4];
}

#pragma mark 得到imageView
- (UIImageView *)imgViewWithCenter:(CGPoint)center size:(CGSize)size layer:(DDYHeaderLayer *)layer {
    CGRect frame = CGRectMake(center.x - size.width/2, center.y - size.height/2, size.width, size.height);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    layer.frame = imgView.bounds;
    imgView.layer.mask = layer;
    [layer setNeedsDisplay];
    return imgView;
}

@end
