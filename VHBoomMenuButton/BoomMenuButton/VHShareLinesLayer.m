//
//  VHShareLinesLayer.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/17.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "VHShareLinesLayer.h"

@implementation VHShareLinesLayer

@dynamic processForLine1;
@dynamic processForLine2;

#pragma mark - Private Methods

- (id)initWithLayer:(id)layer
{
    self = [super initWithLayer:layer];
    if (self)
    {
        if ([layer isKindOfClass:[VHShareLinesLayer class]])
        {
            VHShareLinesLayer *l = (VHShareLinesLayer *)layer;
            self.processForLine1 = l.processForLine1;
            self.processForLine2 = l.processForLine2;
        }
    }
    return self;
}

+ (BOOL)isCustomAnimKey:(NSString *)key
{
    return [key isEqualToString:@"processForLine1"] || [key isEqualToString:@"processForLine2"];
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([self isCustomAnimKey:key]) return YES;
    return [super needsDisplayForKey:key];
}

- (id<CAAction>)actionForKey:(NSString *)key
{
    if ([[self class] isCustomAnimKey:key])
    {
        id animation = [super actionForKey:@"backgroundColor"];
        if (animation == nil || [animation isEqual:[NSNull null]])
        {
            [self setNeedsDisplay];
            return [NSNull null];
        }
        [animation setKeyPath:key];
        if ([key isEqualToString:@"processForLine1"])
        {
            [animation setFromValue:@([self.presentationLayer processForLine1])];
        }
        else if ([key isEqualToString:@"processForLine2"])
        {
            [animation setFromValue:@([self.presentationLayer processForLine2])];
        }
        [animation setToValue:nil];
        return animation;
    }
    return [super actionForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx
{
    [super drawInContext:ctx];  // add this to make drawRect method of VHShareLinesView work 
}

@end
