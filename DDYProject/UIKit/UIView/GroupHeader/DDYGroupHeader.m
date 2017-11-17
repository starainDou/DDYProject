//
//  DDYGroupHeader.m
//  DDYProject
//
//  Created by LingTuan on 17/11/9.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYGroupHeader.h"

static inline float radians(double degrees) { return degrees * M_PI / 180; }

//-------------------------------- layer --------------------------------//
@interface DDYGroupHeaderLayer : CALayer
/** 要处理的图片 */
@property (nonatomic, strong) UIImage *img;
/** 因为统一裁剪，所以旋转一定角度 */
@property (nonatomic, assign) CGFloat angle;
/** 是否裁剪 */
@property (nonatomic, assign) BOOL isClip;
/** 裁剪角度 */
@property (nonatomic, assign) CGFloat clipHalfAngle;

+ (DDYGroupHeaderLayer *)initWithImage:(UIImage *)img angle:(CGFloat)angle isClip:(BOOL)isClip;

@end

@implementation DDYGroupHeaderLayer

- (instancetype)init {
    if (self = [super init]) {
        _angle = 0;
        _isClip = NO;
    }
    return self;
}

+ (DDYGroupHeaderLayer *)initWithImage:(UIImage *)img angle:(CGFloat)angle isClip:(BOOL)isClip {
    DDYGroupHeaderLayer *headerLayer = [DDYGroupHeaderLayer layer];
    [headerLayer updateImage:img angle:angle isClip:isClip];
    return headerLayer;
}

- (void)updateImage:(UIImage *)img angle:(CGFloat)angle isClip:(BOOL)isClip {
    _img = img;
    _angle = angle;
    _isClip = isClip;
    _clipHalfAngle = clipAngle/2.;
    self.contentsScale = [UIScreen mainScreen].scale;
}

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    
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
    [_img drawInRect:self.bounds];
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIGraphicsPushContext(ctx);
    [maskedImage drawInRect:CGRectMake(0, 0, width, height)];
    UIGraphicsPopContext();
}

@end

//-------------------------------- view --------------------------------//
@implementation DDYGroupHeader

+ (instancetype)headerWithHeaderWH:(CGFloat)headerWH {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, headerWH, headerWH)];
}

- (void)setImages:(NSArray *)images {
    _images = images;
   [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    switch (images.count)
    {
        case 1:
            [self view1WithImages:images];
            break;
        case 2:
            [self view2WithImages:images];
            break;
        case 3:
            [self view3WithImages:images];
            break;
        case 4:
            [self view4WithImages:images];
            break;
        default:
            [self view5WithImages:images];
            break;
    }
}

#pragma mark 一张图片
- (void)view1WithImages:(NSArray *)images {
    DDYGroupHeaderLayer *layer1 = [DDYGroupHeaderLayer initWithImage:images[0] angle:0 isClip:NO];
    layer1.frame = [self getRectWithCenter:CGPointMake(self.ddy_h/2, self.ddy_h/2) size:CGSizeMake(self.ddy_w, self.ddy_h)];
    [self.layer addSublayer:layer1];
    [layer1 setNeedsDisplay];
}

#pragma mark 两张图片
- (void)view2WithImages:(NSArray *)images {
    CGFloat diameter = self.ddy_w + self.ddy_w- sqrtf(2)*self.ddy_w;
    CGFloat r = diameter/2;
    
    DDYGroupHeaderLayer *layer1 = [DDYGroupHeaderLayer initWithImage:images[0] angle:0 isClip:NO];
    layer1.frame = [self getRectWithCenter:CGPointMake(r, r) size:CGSizeMake(diameter, diameter)];
    [self.layer addSublayer:layer1];
    [layer1 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer2 = [DDYGroupHeaderLayer initWithImage:images[1] angle:180-45 isClip:YES];
    layer2.frame = [self getRectWithCenter:CGPointMake(r+sqrtf(2)*diameter/2, r+sqrtf(2)*diameter/2) size:CGSizeMake(diameter, diameter)];
    [self.layer addSublayer:layer2];
    [layer2 setNeedsDisplay];
}

#pragma mark 三张图片
- (void)view3WithImages:(NSArray *)images {
    CGFloat diameter = self.ddy_w/2;
    CGPoint center0 = CGPointMake(diameter, diameter / 2);
    CGPoint center1 = CGPointMake(center0.x - diameter * sin(radians(30)), diameter / 2 + diameter * cos(radians(30)));
    CGPoint center2 = CGPointMake(center1.x + diameter, center1.y);
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 2*diameter, diameter+sqrtf(3)/2*diameter);
    
    DDYGroupHeaderLayer *layer0 = [DDYGroupHeaderLayer initWithImage:images[0] angle:30 isClip:YES];
    layer0.frame = [self getRectWithCenter:center0 size:CGSizeMake(diameter, diameter)];
    [layer addSublayer:layer0];
    [layer0 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer1 = [DDYGroupHeaderLayer initWithImage:images[1] angle:270 isClip:YES];
    layer1.frame = [self getRectWithCenter:center1 size:CGSizeMake(diameter, diameter)];
    [layer addSublayer:layer1];
    [layer1 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer2 = [DDYGroupHeaderLayer initWithImage:images[2] angle:150 isClip:YES];
    layer2.frame = [self getRectWithCenter:center2 size:CGSizeMake(diameter, diameter)];
    [layer addSublayer:layer2];
    [layer2 setNeedsDisplay];
    
    CGRect f = layer.frame;
    f.origin.y = (self.ddy_h - f.size.height) / 2;
    layer.frame = f;
    [self.layer addSublayer:layer];
}

#pragma mark 四张图片
- (void)view4WithImages:(NSArray *)images {
    CGFloat diameter = self.ddy_w/2;
    CGPoint center0 = CGPointMake(diameter/2, diameter/2);
    CGPoint center1 = CGPointMake(center0.x, center0.y + diameter);
    CGPoint center2 = CGPointMake(center1.x + diameter, center1.y);
    CGPoint center3 = CGPointMake(center2.x, center2.y - diameter);
    
    DDYGroupHeaderLayer *layer0 = [DDYGroupHeaderLayer initWithImage:images[0] angle:0 isClip:YES];
    layer0.frame = [self getRectWithCenter:center0 size:CGSizeMake(diameter, diameter)];
    [self.layer addSublayer:layer0];
    [layer0 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer1 = [DDYGroupHeaderLayer initWithImage:images[1] angle:270 isClip:YES];
    layer1.frame = [self getRectWithCenter:center1 size:CGSizeMake(diameter, diameter)];
    [self.layer addSublayer:layer1];
    [layer1 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer2 = [DDYGroupHeaderLayer initWithImage:images[2] angle:180 isClip:YES];
    layer2.frame = [self getRectWithCenter:center2 size:CGSizeMake(diameter, diameter)];
    [self.layer addSublayer:layer2];
    [layer2 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer3 = [DDYGroupHeaderLayer initWithImage:images[3] angle:90 isClip:YES];
    layer3.frame = [self getRectWithCenter:center3 size:CGSizeMake(diameter, diameter)];
    [self.layer addSublayer:layer3];
    [layer3 setNeedsDisplay];
}

#pragma mark 五张图片
- (void)view5WithImages:(NSArray *)images {
    CGFloat r = self.ddy_w / 2 / ( 2*sin(radians(54)) + 1 );
    CGFloat diameter = r * 2;
    CGPoint center0 = CGPointMake(self.ddy_w/2, r);
    CGPoint center1 = CGPointMake(center0.x - diameter * sin(radians(54)), center0.y + diameter * cos(radians(54)));
    CGPoint center2 = CGPointMake(center1.x + diameter * cos(radians(72)), center1.y + diameter * sin(radians(72)));
    CGPoint center3 = CGPointMake(center2.x + diameter, center2.y);
    CGPoint center4 = CGPointMake(center3.x + diameter * cos(radians(72)), center3.y - diameter * sin(radians(72)));
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, self.ddy_w, r / tan(radians(36)) + r / sin(radians(36)) + diameter);
    
    DDYGroupHeaderLayer *layer0 = [DDYGroupHeaderLayer initWithImage:images[0] angle:54 isClip:YES];
    layer0.frame = [self getRectWithCenter:center0 size:CGSizeMake(diameter, diameter)];
    [layer addSublayer:layer0];
    [layer0 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer1 = [DDYGroupHeaderLayer initWithImage:images[1] angle:270+72 isClip:YES];
    layer1.frame = [self getRectWithCenter:center1 size:CGSizeMake(diameter, diameter)];
    [layer addSublayer:layer1];
    [layer1 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer2 = [DDYGroupHeaderLayer initWithImage:images[2] angle:270 isClip:YES];
    layer2.frame = [self getRectWithCenter:center2 size:CGSizeMake(diameter, diameter)];
    [layer addSublayer:layer2];
    [layer2 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer3 = [DDYGroupHeaderLayer initWithImage:images[3] angle:180+18 isClip:YES];
    layer3.frame = [self getRectWithCenter:center3 size:CGSizeMake(diameter, diameter)];
    [layer addSublayer:layer3];
    [layer3 setNeedsDisplay];
    
    DDYGroupHeaderLayer *layer4 = [DDYGroupHeaderLayer initWithImage:images[4] angle:90+36 isClip:YES];
    layer4.frame = [self getRectWithCenter:center4 size:CGSizeMake(diameter, diameter)];
    [layer addSublayer:layer4];
    [layer4 setNeedsDisplay];
    
    CGRect f = layer.frame;
    f.origin.y = (self.ddy_w - f.size.height) / 2;
    layer.frame = f;
    [self.layer addSublayer:layer];
}

#pragma mark 相应layer的frame
- (CGRect)getRectWithCenter:(CGPoint)center size:(CGSize)size
{
    return CGRectMake(center.x - size.width/2, center.y - size.height/2, size.width, size.height);
}

@end
