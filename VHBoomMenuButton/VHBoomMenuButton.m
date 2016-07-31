//
//  VHBoomMenuButton.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHBoomMenuButton.h"
#include <stdlib.h>

@implementation VHBoomMenuButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.shadowRadius = frame.size.width / 2 + DEFAULT_BOOM_MENU_BUTTON_SHADOW_WIDTH;
        self.shadowOffset = CGSizeMake(DEFAULT_BOOM_MENU_BUTTON_SHADOW_OFFSET_X, DEFAULT_BOOM_MENU_BUTTON_SHADOW_OFFSET_Y);
        self.shadowOpacity = DEFAULT_BOOM_MENU_BUTTON_SHADOW_OPACITY;
        self.shadowColor = DEFAULT_BOOM_MENU_BUTTON_SHADOW_COLOR;
        
        self.buttonRadius = frame.size.width / 2;
        
        self.dotRadius = DEFAULT_BOOM_MENU_BUTTON_DOT_RADIUS;
        self.barWidth = DEFAULT_BOOM_MENU_BUTTON_BAR_WIDTH;
        self.barHeight = DEFAULT_BOOM_MENU_BUTTON_BAR_HEIGHT;
        self.blockWidth = DEFAULT_BOOM_MENU_BUTTON_BLOCK_WIDTH;
        self.blockHeight = DEFAULT_BOOM_MENU_BUTTON_BLOCK_HEIGHT;
        
        self.simpleCircleButtonRadius = DEFAULT_SIMPLE_CIRCLE_BUTTON_RADIUS;
        
        self.buttonNormalColor = DEFAULT_BOOM_MENU_BUTTON_NORMAL_COLOR;
        self.buttonPressedColor = DEFAULT_BOOM_MENU_BUTTON_PRESSED_COLOR;
        
        self.showOrderEnum = DEFAULT_BOOM_MENU_BUTTON_SHOW_ORDER;
        self.hideOrderEnum = DEFAULT_BOOM_MENU_BUTTON_HIDE_ORDER;
        self.boomEnum = DEFAULT_BOOM_MENU_BUTTON_BOOM_ENUM;
        
        self.buttonCircle = [CAShapeLayer layer];
        [self.buttonCircle setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,
                                                                                0,
                                                                                frame.size.width,
                                                                                frame.size.height)] CGPath]];
        [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
        [[self layer] addSublayer:self.buttonCircle];
        self.backgroundColor = [UIColor clearColor];
        
        self.showMoveEaseEnum = DEFAULT_BOOM_MENU_BUTTON_SHOW_MOVE_EASE_ENUM;
        self.showScaleEaseEnum = DEFAULT_BOOM_MENU_BUTTON_SHOW_SCALE_EASE_ENUM;
        self.showRotateEaseEnum = DEFAULT_BOOM_MENU_BUTTON_SHOW_ROTATE_EASE_ENUM;
        self.hideMoveEaseEnum = DEFAULT_BOOM_MENU_BUTTON_HIDE_MOVE_EASE_ENUM;
        self.hideScaleEaseEnum = DEFAULT_BOOM_MENU_BUTTON_HIDE_SCALE_EASE_ENUM;
        self.hideRotateEaseEnum = DEFAULT_BOOM_MENU_BUTTON_HIDE_ROTATE_EASE_ENUM;
        
        self.dimColor = DEFAULT_BOOM_MENU_BUTTON_DIM_COLOR;
        self.autoHide = DEFAULT_BOOM_MENU_BUTTON_AUTO_HIDE;
        self.cancelable = DEFAULT_BOOM_MENU_BUTTON_CANCELABLE;
        self.frames = DEFAULT_BOOM_MENU_BUTTON_FRAMES;
        self.duration = DEFAULT_BOOM_MENU_BUTTON_DURATION;
        self.delay = DEFAULT_BOOM_MENU_BUTTON_DELAY;
        self.rotationDegree = DEFAULT_BOOM_MENU_BUTTON_ROTATION_DEGREE;
        
        self.animatingViewsNumber = 0;
        
        self.boomButtonBuilders = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect shadowRect = CGRectMake(0, 0, self.shadowRadius * 2, self.shadowRadius * 2);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithOvalInRect:shadowRect];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = self.shadowColor.CGColor;
    CGSize shadowOffset = CGSizeMake(self.shadowOffset.width - (self.shadowRadius - self.frame.size.width / 2),
                                     self.shadowOffset.height - (self.shadowRadius - self.frame.size.height / 2));
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = self.shadowOpacity;
    self.layer.shadowPath = shadowPath.CGPath;
}

#pragma mark - Place Dots, Bars or Blocks

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableArray<NSValue *> *piecePositions = [self calculatePiecePositons];
    
    long pieceNumber = [[VHPiecePlaceManager sharedManager] numbersWithEnum:self.piecePlaceEnum];
    
    self.pieces = [NSMutableArray arrayWithCapacity:pieceNumber];
    self.startPositions = [NSMutableArray arrayWithCapacity:pieceNumber];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    for (int i = 0; i < pieceNumber; i++)
    {
        VHBoomPiece *piece = [self getBoomPieceAt:[piecePositions objectAtIndex:i] withColor:[self.boomButtonBuilders objectAtIndex:i].buttonNormalColor];
        [self.pieces addObject:piece];
        [self addSubview:piece];
        CGPoint centerPointOfPieceInWindow = [self convertPoint:piece.frame.origin toView:window];
        centerPointOfPieceInWindow = CGPointMake(centerPointOfPieceInWindow.x + piece.frame.size.width / 2, centerPointOfPieceInWindow.y + piece.frame.size.height / 2);
        [self.startPositions addObject:[NSValue valueWithCGPoint:centerPointOfPieceInWindow]];
    }
}

- (NSMutableArray<NSValue *> *)calculatePiecePositons
{
    switch (self.buttonEnum) {
        case VHSimpleCircle:
            return [[VHPiecePlaceManager sharedManager] positionsWithEnum:self.piecePlaceEnum withParentFrame:self.bounds withDotRadius:self.dotRadius];
            break;
        default:
            break;
    }
    return [NSMutableArray arrayWithCapacity:0];
}

- (VHBoomPiece *)getBoomPieceAt:(NSValue *)position withColor:(UIColor *)color
{
    switch (self.buttonEnum) {
        case VHSimpleCircle:
            return [[VHDot alloc] initWithFrame:[position CGRectValue] withColor:color];
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - Touch Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    CGRect selfRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsPoint(selfRect, touchLocation))
    {
        [self.buttonCircle setFillColor:self.buttonPressedColor.CGColor];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    CGRect selfRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
    if (CGRectContainsPoint(selfRect, touchLocation))
    {
        [self boom];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
}

#pragma mark Animation

- (void)boom
{
    if (self.animatingViewsNumber != 0)
    {
        return;
    }
    [self createButtons];
    [self dimBackground];
    [self startShowAnimations];
}

- (void)reboom
{
    if (self.animatingViewsNumber != 0)
    {
        return;
    }
    [self lightBackground];
    [self startHideAnimations];
}

- (void)dimBackground
{
    [self createBackground];
    self.background.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:self.duration + (self.pieces.count - 1) * self.delay animations:^
    {
        self.background.backgroundColor = self.dimColor;
    } completion:nil];
}

- (void)lightBackground
{
    [self createBackground];
    self.background.backgroundColor = self.dimColor;
    [UIView animateWithDuration:self.duration + (self.pieces.count - 1) * self.delay animations:^
     {
         self.background.backgroundColor = [UIColor clearColor];
     } completion:nil];
}

- (void)startShowAnimations
{
    if (nil != self.background)
    {
        [self removeAllSubViews:self.background];
    }
    
    [self calculateEndPositions];
    
    NSMutableArray<NSNumber *> *indexs = [self getOrderIndex:self.showOrderEnum inSize:(int)self.pieces.count];
    for (int i = 0; i < indexs.count; i++)
    {
        int index = [[indexs objectAtIndex:i] intValue];
        VHBoomButton *button = [self putSubButtonInBackground:[self.boomButtons objectAtIndex:index] withPosition:[[self.startPositions objectAtIndex:index] CGPointValue]];
        
        CGPoint startPosition = CGPointMake([[self.startPositions objectAtIndex:index] CGPointValue].x, [[self.startPositions objectAtIndex:index] CGPointValue].y);
        CGPoint endPosition = CGPointMake([[self.endPositions objectAtIndex:index] CGPointValue].x, [[self.endPositions objectAtIndex:index] CGPointValue].y);
        
        // [[self.endPositions objectAtIndex:i] CGPointValue] != endPosition ????
        
        [self setShowAnimationForEverySubButton:[self.pieces objectAtIndex:index]
                                         button:button
                                  startPosition:startPosition
                                    endPosition:endPosition
                                          index:index];
    }
}

- (void)setShowAnimationForEverySubButton:(VHBoomPiece *)piece button:(VHBoomButton *)button startPosition:(CGPoint)startPosition endPosition:(CGPoint)endPosition index:(int)buttonIndex
{
    self.animatingViewsNumber++;
    
    [[button superview] bringSubviewToFront:button];
    
    NSMutableArray *xs = [NSMutableArray arrayWithCapacity:self.frames];
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:self.frames];
    [[VHAnimationManager sharedManager] calculateShowXY:self.boomEnum
                                                   ease:self.showMoveEaseEnum
                                                 frames:self.frames
                                          startPosition:startPosition
                                            endPosition:endPosition
                                                xValues:xs
                                                yValues:ys];
    
    for (UIView *goneView in button.goneViews)
    {
        goneView.alpha = 0;
    }
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^(void)
     {
         piece.hidden = YES;
         button.hidden = NO;
         
         [CATransaction begin];
         [CATransaction setCompletionBlock:^(void)
          {
              self.animatingViewsNumber--;
          }];
         
         CAAnimationGroup *group = [CAAnimationGroup animation];
         group.duration = self.duration;
         group.removedOnCompletion = YES;
         group.fillMode = kCAFillModeForwards;
         
         
         CAKeyframeAnimation *xAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
         xAnimation.values = xs;
         
         CAKeyframeAnimation *yAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
         yAnimation.values = ys;
         
         CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
         scaleAnimation.values = [[VHAnimationManager sharedManager] calculateScale:self.showScaleEaseEnum
                                                                             frames:self.frames
                                                                         startScale:piece.frame.size.width / button.frame.size.width
                                                                           endScale:1];
         
         CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
         opacityAnimation.values = @[@0, @1];
         opacityAnimation.duration = self.duration;
         opacityAnimation.removedOnCompletion = NO;
         opacityAnimation.fillMode = kCAFillModeForwards;
         for (UIView *goneView in button.goneViews)
         {
             [goneView.layer addAnimation:opacityAnimation forKey:nil];
         }
         
         CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
         rotateAnimation.values = [[VHAnimationManager sharedManager] calculateRotate:self.showRotateEaseEnum frames:self.frames startRotate:0 endRotate:self.rotationDegree];
         rotateAnimation.duration = self.duration;
         rotateAnimation.removedOnCompletion = NO;
         rotateAnimation.fillMode = kCAFillModeForwards;
         for (UIView *rotateView in button.rotateViews)
         {
             [rotateView.layer addAnimation:rotateAnimation forKey:nil];
         }
         
         button.frame = CGRectMake(endPosition.x - button.frame.size.width / 2, endPosition.y - button.frame.size.height / 2, button.frame.size.width, button.frame.size.height);
         button.layer.frame = button.frame;
         
         [group setAnimations:@[xAnimation, yAnimation, scaleAnimation]];
         [button.layer addAnimation:group forKey:[NSString stringWithFormat:@"%d", buttonIndex]];
         [CATransaction commit];

     }];
    
    CAKeyframeAnimation *scaleAnimationAtFirst = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimationAtFirst.values = @[@(piece.frame.size.width / button.frame.size.width)];
    scaleAnimationAtFirst.duration = buttonIndex * self.delay;
    scaleAnimationAtFirst.removedOnCompletion = NO;
    scaleAnimationAtFirst.fillMode = kCAFillModeForwards;
    [button.layer addAnimation:scaleAnimationAtFirst forKey:[NSString stringWithFormat:@"%d", buttonIndex]];
    
    [CATransaction commit];
}

- (void)startHideAnimations
{
    NSMutableArray<NSNumber *> *indexs = [self getOrderIndex:self.hideOrderEnum inSize:(int)self.pieces.count];
    for (int i = 0; i < indexs.count; i++)
    {
        int index = [[indexs objectAtIndex:i] intValue];

        CGPoint startPosition = CGPointMake([[self.startPositions objectAtIndex:index] CGPointValue].x, [[self.startPositions objectAtIndex:index] CGPointValue].y);
        CGPoint endPosition = CGPointMake([[self.endPositions objectAtIndex:index] CGPointValue].x, [[self.endPositions objectAtIndex:index] CGPointValue].y);
        
        [self setHideAnimationForEverySubButton:[self.pieces objectAtIndex:index]
                                         button:[self.boomButtons objectAtIndex:index]
                                  startPosition:endPosition
                                    endPosition:startPosition
                                          index:index];
    }
}

- (void)setHideAnimationForEverySubButton:(VHBoomPiece *)piece button:(VHBoomButton *)button startPosition:(CGPoint)startPosition endPosition:(CGPoint)endPosition index:(int)buttonIndex
{
    self.animatingViewsNumber++;
    
    NSMutableArray *xs = [NSMutableArray arrayWithCapacity:self.frames];
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:self.frames];
    [[VHAnimationManager sharedManager] calculateHideXY:self.boomEnum
                                                   ease:self.hideMoveEaseEnum
                                                 frames:self.frames
                                          startPosition:startPosition
                                            endPosition:endPosition
                                                xValues:xs
                                                yValues:ys];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^(void)
     {
         piece.hidden = NO;
         button.hidden = YES;
         self.animatingViewsNumber--;
         if (self.animatingViewsNumber == 0)
         {
             [self.background removeFromSuperview];
         }
     }];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = self.duration;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + buttonIndex * self.delay;
    
    CAKeyframeAnimation *xAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    xAnimation.values = xs;
    
    CAKeyframeAnimation *yAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    yAnimation.values = ys;
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = [[VHAnimationManager sharedManager] calculateScale:self.hideScaleEaseEnum
                                                                        frames:self.frames
                                                                    startScale:1
                                                                      endScale:piece.frame.size.width / button.frame.size.width];
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@1, @0];
    opacityAnimation.duration = self.duration;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + buttonIndex * self.delay;
    for (UIView *goneView in button.goneViews)
    {
        [goneView.layer addAnimation:opacityAnimation forKey:nil];
    }
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = [[VHAnimationManager sharedManager] calculateRotate:self.hideRotateEaseEnum frames:self.frames startRotate:self.rotationDegree endRotate:0];
    rotateAnimation.duration = self.duration;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + buttonIndex * self.delay;
    for (UIView *rotateView in button.rotateViews)
    {
        [rotateView.layer addAnimation:rotateAnimation forKey:nil];
    }
    
    [group setAnimations:@[xAnimation, yAnimation, scaleAnimation]];
    [button.layer addAnimation:group forKey:[NSString stringWithFormat:@"%d", buttonIndex]];
    [CATransaction commit];
}

#pragma mark Other Methods

- (void)createBackground
{
    if (nil == self.background)
    {
        self.background = [[VHBackgroundView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        self.background.delegate = self;
    }
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.background];
}

- (void)createButtons
{
    switch (self.buttonEnum)
    {
        case VHSimpleCircle:
            self.boomButtons = [NSMutableArray arrayWithCapacity:self.pieces.count];
            int buttonNumber = (int)self.pieces.count;
            for (int i = 0; i < buttonNumber; i++)
            {
                VHSimpleCircleButtonBuilder *builder = (VHSimpleCircleButtonBuilder *)[self.boomButtonBuilders objectAtIndex:i];
                [[builder withIndex:i] withDelegate:self];
                VHSimpleCircleButton *simpleCircleButton = [builder createButton];
                [self.boomButtons setObject:simpleCircleButton atIndexedSubscript:i];
            }
            break;
        default:
            break;
    }
}

- (void)onBackgroundClicked
{
    if (self.animatingViewsNumber != 0)
    {
        return;
    }
    if (self.cancelable)
    {
        [self reboom];
    }
}

- (void)removeAllSubViews:(UIView *)parentView
{
    for (UIView *subViews in parentView.subviews)
    {
        [subViews removeFromSuperview];
    }
}

- (void)calculateEndPositions
{
    self.endPositions = [[VHButtonPlaceManager sharedManager] positionsWithEnum:self.buttonPlaceEnum withParentFrame:[UIScreen mainScreen].bounds withButtonRadius:self.simpleCircleButtonRadius];
}

- (VHBoomButton *)putSubButtonInBackground:(VHBoomButton *)button withPosition:(CGPoint)position
{
    [self createBackground];
    button.frame = CGRectMake(position.x - button.frame.size.width / 2, position.y - button.frame.size.height / 2, button.frame.size.width, button.frame.size.height);
    [self.background addSubview:button];
    return button;
}

- (NSMutableArray<NSNumber *> *)getOrderIndex:(VHOrderEnum)orderEnum inSize:(int)size
{
    NSMutableArray<NSNumber *> *indexs = [NSMutableArray arrayWithCapacity:size];
    
    switch (orderEnum)
    {
        case Default:
            for (int i = 0; i < size; i++)
            {
                [indexs addObject:[NSNumber numberWithInteger:i]];
            }
            break;
        case Reverse:
            for (int i = 0; i < size; i++)
            {
                [indexs addObject:[NSNumber numberWithInteger:size - i - 1]];
            }
            break;
        case Random:
            {
                BOOL used[size];
                for (int i = 0; i < size; i++)
                {
                    used[i] = NO;
                }
                int count = 0;
                while (YES)
                {
                    int r = arc4random() % size;
                    if (used[r] == NO)
                    {
                        used[r] = YES;
                        [indexs addObject:[NSNumber numberWithInteger:r]];
                        count++;
                        
                        if (count == size)
                        {
                            break;
                        }
                    }
                }
            }
            break;
    }
    return indexs;
}

#pragma mark - On Button Clicked

- (void)onButtonClick:(int)index
{
    if ([self.boomDelegate respondsToSelector:@selector(onBoomClick:)])
    {
        [self.boomDelegate onBoomClick:index];
    }
    if (self.autoHide)
    {
        [self reboom];
    }
}

#pragma mark - On Background Clicked

- (void)onBackgroundClick
{
    if ([self.boomDelegate respondsToSelector:@selector(onBackgroundClick)])
    {
        [self.boomDelegate onBoomBackgroundClick];
    }
    if (self.cancelable)
    {
        [self reboom];
    }
}

#pragma mark - Add Builders

- (void)addBuilderBlock:(void (^)(VHSimpleCircleButtonBuilder *))block
{
    VHSimpleCircleButtonBuilder *builder = [[VHSimpleCircleButtonBuilder alloc] init];
    block(builder);
    [self.boomButtonBuilders addObject:builder];
}

@end
