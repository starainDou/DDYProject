//
//  DDYHeader.m
//  DDYProject
//
//  Created by LingTuan on 17/11/16.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYHeader.h"

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
    transform = CGAffineTransformRotate(transform, change2Radians(_angle));
    transform = CGAffineTransformTranslate(transform, -CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds));
    
    CGMutablePathRef path = CGPathCreateMutable();
    if (_isClip)
    {
        CGPathAddArc(path, &transform, width/2, height/2, width/2, change2Radians(90-_clipHalfAngle), change2Radians(90+_clipHalfAngle), true);
        CGPathAddArcToPoint(path,
                            &transform,
                            width/2,
                            height/2+(width/2*sin(change2Radians(90-_clipHalfAngle)) - width/2*sin(change2Radians(_clipHalfAngle))*tan(change2Radians(_clipHalfAngle))),
                            width/2+width/2*sin(change2Radians(_clipHalfAngle)), height/2+width/2*sin(change2Radians(90-_clipHalfAngle)),
                            width/2);
    }
    else
    {
        CGPathAddArc(path, &transform, width/2, height/2, width/2, change2Radians(90), change2Radians(90.01), true);
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

- (void)setUrlArray:(NSArray *)urlArray {
    _urlArray = urlArray;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (urlArray.count == 1) {
        [self view1];
    } else if (urlArray.count == 2) {
        [self view2];
    } else if (urlArray.count == 3) {
        [self view3];
    } else if (urlArray.count == 4) {
        [self view4];
    } else if (urlArray.count >= 5) {
        [self view5];
    }
}

#pragma mark 一张图片
- (void)view1 {
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:0 isClip:NO];
    UIImageView *view0 = [self imgViewWithCenter:CGPointMake(self.ddy_h/2, self.ddy_h/2) size:CGSizeMake(self.ddy_w, self.ddy_h) layer:layer0];
    [view0 sd_setImageWithURL:[NSURL URLWithString:_urlArray[0]] placeholderImage:[self getPlaceholderImg:0]];
    [self addSubview:view0];
}

#pragma mark 两张图片
- (void)view2 {
    CGFloat diameter = self.ddy_w + self.ddy_w- sqrtf(2)*self.ddy_w;
    CGFloat r = diameter/2;
    
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:0 isClip:NO];
    UIImageView *view0 = [self imgViewWithCenter:CGPointMake(r, r) size:CGSizeMake(diameter, diameter) layer:layer0];
    [view0 sd_setImageWithURL:[NSURL URLWithString:_urlArray[0]] placeholderImage:[self getPlaceholderImg:0]];
    [self addSubview:view0];
    
    DDYHeaderLayer *layer1 = [DDYHeaderLayer initWithAngle:180-45 isClip:YES];
    UIImageView *view1 = [self imgViewWithCenter:CGPointMake(r+sqrtf(2)*diameter/2, r+sqrtf(2)*diameter/2) size:CGSizeMake(diameter, diameter) layer:layer1];
    [view1 sd_setImageWithURL:[NSURL URLWithString:_urlArray[1]] placeholderImage:[self getPlaceholderImg:1]];
    [self addSubview:view1];
}

#pragma mark 三张图片
- (void)view3 {
    CGFloat diameter = self.ddy_w/2;
    CGPoint center0 = CGPointMake(diameter, diameter / 2);
    CGPoint center1 = CGPointMake(center0.x - diameter * sin(change2Radians(30)), diameter / 2 + diameter * cos(change2Radians(30)));
    CGPoint center2 = CGPointMake(center1.x + diameter, center1.y);
    
    self.ddy_h = diameter+sqrtf(3)/2*diameter;
    
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:30 isClip:YES];
    UIImageView *view0 = [self imgViewWithCenter:center0 size:CGSizeMake(diameter, diameter) layer:layer0];
    [view0 sd_setImageWithURL:[NSURL URLWithString:_urlArray[0]] placeholderImage:[self getPlaceholderImg:0]];
    [self addSubview:view0];
    
    DDYHeaderLayer *layer1 = [DDYHeaderLayer initWithAngle:270 isClip:YES];
    UIImageView *view1 = [self imgViewWithCenter:center1 size:CGSizeMake(diameter, diameter) layer:layer1];
    [view1 sd_setImageWithURL:[NSURL URLWithString:_urlArray[1]] placeholderImage:[self getPlaceholderImg:1]];
    [self addSubview:view1];
    
    DDYHeaderLayer *layer2 = [DDYHeaderLayer initWithAngle:150 isClip:YES];
    UIImageView *view2 = [self imgViewWithCenter:center2 size:CGSizeMake(diameter, diameter) layer:layer2];
    [view2 sd_setImageWithURL:[NSURL URLWithString:_urlArray[2]] placeholderImage:[self getPlaceholderImg:2]];
    [self addSubview:view2];
}

#pragma mark 四张图片
- (void)view4 {
    CGFloat diameter = self.ddy_w/2;
    CGPoint center0 = CGPointMake(diameter/2, diameter/2);
    CGPoint center1 = CGPointMake(center0.x, center0.y + diameter);
    CGPoint center2 = CGPointMake(center1.x + diameter, center1.y);
    CGPoint center3 = CGPointMake(center2.x, center2.y - diameter);
    
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:0 isClip:YES];
    UIImageView *view0 = [self imgViewWithCenter:center0 size:CGSizeMake(diameter, diameter) layer:layer0];
    [view0 sd_setImageWithURL:[NSURL URLWithString:_urlArray[0]] placeholderImage:[self getPlaceholderImg:0]];
    [self addSubview:view0];
    
    DDYHeaderLayer *layer1 = [DDYHeaderLayer initWithAngle:270 isClip:YES];
    UIImageView *view1 = [self imgViewWithCenter:center1 size:CGSizeMake(diameter, diameter) layer:layer1];
    [view1 sd_setImageWithURL:[NSURL URLWithString:_urlArray[1]] placeholderImage:[self getPlaceholderImg:1]];
    [self addSubview:view1];
    
    DDYHeaderLayer *layer2 = [DDYHeaderLayer initWithAngle:180 isClip:YES];
    UIImageView *view2 = [self imgViewWithCenter:center2 size:CGSizeMake(diameter, diameter) layer:layer2];
    [view2 sd_setImageWithURL:[NSURL URLWithString:_urlArray[2]] placeholderImage:[self getPlaceholderImg:2]];
    [self addSubview:view2];
    
    DDYHeaderLayer *layer3 = [DDYHeaderLayer initWithAngle:90 isClip:YES];
    UIImageView *view3 = [self imgViewWithCenter:center3 size:CGSizeMake(diameter, diameter) layer:layer3];
    [view3 sd_setImageWithURL:[NSURL URLWithString:_urlArray[3]] placeholderImage:[self getPlaceholderImg:3]];
    [self addSubview:view3];
}

#pragma mark 五张图片
- (void)view5 {
    CGFloat r = self.ddy_w / 2 / ( 2*sin(change2Radians(54)) + 1 );
    CGFloat diameter = r * 2;
    CGPoint center0 = CGPointMake(self.ddy_w/2, r);
    CGPoint center1 = CGPointMake(center0.x - diameter * sin(change2Radians(54)), center0.y + diameter * cos(change2Radians(54)));
    CGPoint center2 = CGPointMake(center1.x + diameter * cos(change2Radians(72)), center1.y + diameter * sin(change2Radians(72)));
    CGPoint center3 = CGPointMake(center2.x + diameter, center2.y);
    CGPoint center4 = CGPointMake(center3.x + diameter * cos(change2Radians(72)), center3.y - diameter * sin(change2Radians(72)));
    
    DDYHeaderLayer *layer0 = [DDYHeaderLayer initWithAngle:54 isClip:YES];
    UIImageView *view0 = [self imgViewWithCenter:center0 size:CGSizeMake(diameter, diameter) layer:layer0];
    [view0 sd_setImageWithURL:[NSURL URLWithString:_urlArray[0]] placeholderImage:[self getPlaceholderImg:0]];
    [self addSubview:view0];
    
    DDYHeaderLayer *layer1 = [DDYHeaderLayer initWithAngle:270+72 isClip:YES];
    UIImageView *view1 = [self imgViewWithCenter:center1 size:CGSizeMake(diameter, diameter) layer:layer1];
    [view1 sd_setImageWithURL:[NSURL URLWithString:_urlArray[1]] placeholderImage:[self getPlaceholderImg:1]];
    [self addSubview:view1];
    
    DDYHeaderLayer *layer2 = [DDYHeaderLayer initWithAngle:270 isClip:YES];
    UIImageView *view2 = [self imgViewWithCenter:center2 size:CGSizeMake(diameter, diameter) layer:layer2];
    [view2 sd_setImageWithURL:[NSURL URLWithString:_urlArray[2]] placeholderImage:[self getPlaceholderImg:2]];
    [self addSubview:view2];
    
    DDYHeaderLayer *layer3 = [DDYHeaderLayer initWithAngle:180+18 isClip:YES];
    UIImageView *view3 = [self imgViewWithCenter:center3 size:CGSizeMake(diameter, diameter) layer:layer3];
    [view3 sd_setImageWithURL:[NSURL URLWithString:_urlArray[3]] placeholderImage:[self getPlaceholderImg:3]];
    [self addSubview:view3];
    
    DDYHeaderLayer *layer4 = [DDYHeaderLayer initWithAngle:90+36 isClip:YES];
    UIImageView *view4 = [self imgViewWithCenter:center4 size:CGSizeMake(diameter, diameter) layer:layer4];
    [view4 sd_setImageWithURL:[NSURL URLWithString:_urlArray[4]] placeholderImage:[self getPlaceholderImg:4]];
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

#pragma mark 取占位图
- (UIImage *)getPlaceholderImg:(NSInteger)index {
    return (_imgArray[index]&&[_imgArray[index] isKindOfClass:[UIImage class]]) ? _imgArray[index] : [UIImage imageNamed:@"icon_head_defaul"];
}

@end
