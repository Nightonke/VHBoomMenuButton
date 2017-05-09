//
//  VHShareLinesView.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/17.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "VHShareLinesView.h"
#import "VHShareLinesLayer.h"

@interface VHShareLinesView ()

@property (nonatomic, strong) NSMutableArray<NSValue *> *piecePositions;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *pieceNumbers;

@end

@implementation VHShareLinesView

#pragma mark - In-BMB-Only Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.processForLine1 = 1;
        self.processForLine2 = 1;
    }
    return self;
}

- (void)setPiecePositions:(NSMutableArray<NSValue *> *)piecePositions dotRadius:(CGFloat)dotRadius
{
    CGFloat xOffset = dotRadius - self.lineWidth / 4;
    CGFloat yOffset = dotRadius - self.lineWidth * sqrt(3) / 4 + 0.5;
    
    self.piecePositions = [NSMutableArray array];
    for (NSValue *piecePositionValue in piecePositions)
    {
        BOOL exist = NO;
        CGPoint piecePosition = [piecePositionValue CGRectValue].origin;
        for (NSValue *value in self.piecePositions)
        {
            CGPoint existedPiecePosition = [value CGPointValue];
            if (CGPointEqualToPoint(piecePosition, existedPiecePosition))
            {
                exist = YES;
                break;
            }
        }
        if (!exist)
        {
            [self.piecePositions addObject:[NSValue valueWithCGPoint:piecePosition]];
        }
    }
    NSMutableArray<NSValue *> * offsetedPiecePositions = [NSMutableArray arrayWithCapacity:self.piecePositions.count];
    for (NSValue *piecePositionValue in self.piecePositions)
    {
        CGPoint piecePosition = [piecePositionValue CGPointValue];
        [offsetedPiecePositions addObject:[NSValue valueWithCGPoint:CGPointMake(piecePosition.x + xOffset, piecePosition.y + yOffset)]];
    }
    self.piecePositions = offsetedPiecePositions;
    
    int pieceNumbers[3] = {0, 0, 0};
    int pieceNumber = (int)piecePositions.count;
    for (int i = 0; i < pieceNumber; i++)
    {
        pieceNumbers[i % 3]++;
    }
    self.pieceNumbers = [NSMutableArray arrayWithCapacity:3];
    [self.pieceNumbers addObject:@(pieceNumbers[0])];
    [self.pieceNumbers addObject:@(pieceNumbers[0] + pieceNumbers[1])];
    [self.pieceNumbers addObject:@(pieceNumbers[0] + pieceNumbers[1] + pieceNumbers[2])];
    
    [self setNeedsDisplay];
}

- (void)pieceStartShowAnimation:(NSUInteger)pieceIndex withDuration:(CFTimeInterval)duration
{
    if (pieceIndex == [[self.pieceNumbers objectAtIndex:0] unsignedIntegerValue] - 1)
    {
        // The lowest piece on the top-right position starts show-animation
        self.processForLine1 = 1;
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.processForLine1 = 0;
                         } completion:nil];
    }
    else if (pieceIndex == [[self.pieceNumbers objectAtIndex:1] unsignedIntegerValue] - 1)
    {
        // The lowest piece on the middle-left position starts show-animation
        self.processForLine2 = 1;
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.processForLine2 = 0;
                         } completion:nil];
    }
}

- (void)pieceFinishHideAnimation:(NSUInteger)pieceIndex withDuration:(CFTimeInterval)duration
{
    if (pieceIndex == [[self.pieceNumbers objectAtIndex:1] unsignedIntegerValue])
    {
        // The highest piece on the bottom-right position finishes hide-animation
        self.processForLine2 = 0;
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.processForLine2 = 1;
                         } completion:nil];
    }
    else if (pieceIndex == [[self.pieceNumbers objectAtIndex:0] unsignedIntegerValue])
    {
        // The highest piece on the middle-left position finishes hide-animation
        self.processForLine1 = 0;
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.processForLine1 = 1;
                         } completion:nil];
    }
}

#pragma mark - Private Methods

- (void)drawRect:(CGRect)rect
{
    VHShareLinesLayer *l = (VHShareLinesLayer *)self.layer.presentationLayer;
    CGFloat processForLine1 = l.processForLine1;
    CGFloat processForLine2 = l.processForLine2;
    if (!l)
    {
        processForLine1 = processForLine2 = 1;
    }
    if (self.piecePositions.count < 3)
    {
        return;
    }
    
    CGPoint point0 = [[self.piecePositions objectAtIndex:0] CGPointValue];  // top-right
    CGPoint point1 = [[self.piecePositions objectAtIndex:1] CGPointValue];  // middle-left
    CGPoint point2 = [[self.piecePositions objectAtIndex:2] CGPointValue];  // bottom-right
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.line1Color.CGColor);
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, (point0.x - point1.x) * processForLine1 + point1.x, (point0.y - point1.y) * processForLine1 + point1.y);
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, self.line2Color.CGColor);
    CGContextMoveToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, (point1.x - point2.x) * processForLine2 + point2.x, (point1.y - point2.y) * processForLine2 + point2.y);
    CGContextStrokePath(context);
}

+ (Class)layerClass
{
    return [VHShareLinesLayer class];
}

- (void)setProcessForLine1:(CGFloat)processForLine1
{
    ((VHShareLinesLayer *)self.layer).processForLine1 = processForLine1;
}

- (CGFloat)processForLine1
{
    return ((VHShareLinesLayer *)self.layer).processForLine1;
}

- (void)setProcessForLine2:(CGFloat)processForLine2
{
    ((VHShareLinesLayer *)self.layer).processForLine2 = processForLine2;
}

- (CGFloat)processForLine2
{
    return ((VHShareLinesLayer *)self.layer).processForLine2;
}

@end
