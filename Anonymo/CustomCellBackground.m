//
//  CustomCellBackground.m
//  Anonymo
//
//  Created by Meeshoo on 27/04/14.
//  Copyright (c) 2014 Meeshoo. All rights reserved.
//

#import "CustomCellBackground.h"
#import "Common.h"

@implementation CustomCellBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext(); //the canvas you will painting within
    
    UIColor *redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    
    UIColor *whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    UIColor *lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    
    CGRect paperRect = self.bounds;
    
    
    //CGContextSetFillColorWithColor(context, redColor.CGColor);
    //CGContextFillRect(context, self.bounds);
    drawLinearGradient(context, paperRect, whiteColor.CGColor, lightGrayColor.CGColor);
    
    //Red line
    
    //CGRect strokeRect = CGRectInset(paperRect, 5.0, 5.0);
    //CGRect strokeRect = rectFor1PxStroke(CGRectInset(paperRect, 5.0, 5.0));
    //sau//ContextSetStrokeColorWithColor(context, redColor.CGColor);
    
    CGRect strokeRect = paperRect;
    strokeRect.size.height -= 1;
    strokeRect = rectFor1PxStroke(strokeRect);
    CGContextSetStrokeColorWithColor(context, whiteColor.CGColor);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, strokeRect);
    //Red line end
    
}

@end
