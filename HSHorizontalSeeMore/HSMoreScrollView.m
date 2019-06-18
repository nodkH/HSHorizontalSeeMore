//
//  HSMoreScrollView.m
//  HSHorizontalSeeMore
//
//  Created by 孔祥刚 on 2019/6/18.
//  Copyright © 2019 ~~. All rights reserved.
//

#import "HSMoreScrollView.h"

@interface HSMoreScrollView () <UIScrollViewDelegate>

@property (nonatomic , strong) UILabel *showMoreLabel;


@property (nonatomic , strong) CAShapeLayer *shapeLayer;


@property (nonatomic , strong) UIBezierPath *bezierPath;


@property (nonatomic , assign) CGFloat maxCanBig;

@end

#define SCREEN_WIDTH       ([UIScreen mainScreen].bounds.size.width)

@implementation HSMoreScrollView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)setContentSizeWidth:(CGFloat)contentSizeWidth {
    _contentSizeWidth = contentSizeWidth > SCREEN_WIDTH ? contentSizeWidth : SCREEN_WIDTH;
    self.contentSize = CGSizeMake(contentSizeWidth, 0);
    
    _maxCanBig = _contentSizeWidth - SCREEN_WIDTH;
    
    [self.layer addSublayer:self.shapeLayer];
    _shapeLayer.frame = CGRectMake(_contentSizeWidth, 0, SCREEN_WIDTH, self.frame.size.height);
    self.shapeLayer.path = self.bezierPath.CGPath;
    [self.shapeLayer addSublayer:self.showMoreLabel.layer];
}



- (UILabel *)showMoreLabel {
    if (!_showMoreLabel) {
        _showMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 10, self.frame.size.height)];
        _showMoreLabel.text = @"查\n看\n更\n多\n";
        _showMoreLabel.numberOfLines = 4;
        _showMoreLabel.font = [UIFont systemFontOfSize:10];
        _showMoreLabel.textColor = [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    }
    return _showMoreLabel;
}


- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor;
        _shapeLayer.borderColor = [UIColor blackColor].CGColor;
//        _shapeLayer.borderWidth = 1;
//        _shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        
    }
    return _shapeLayer;
}


- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        UIColor *color = [UIColor grayColor];
        [color set];

        _bezierPath = [UIBezierPath bezierPath];
        [_bezierPath moveToPoint:CGPointMake(0, 0)];
        [_bezierPath addQuadCurveToPoint:CGPointMake(0, self.frame.size.height) controlPoint:CGPointMake(0, self.frame.size.height / 2)];
        [_bezierPath addLineToPoint:CGPointMake(_contentSizeWidth, self.frame.size.height)];
        [_bezierPath addLineToPoint:CGPointMake(_contentSizeWidth, 0)];
        [_bezierPath closePath];
    }
    return _bezierPath;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BOOL toBig = NO;

    if (scrollView.contentOffset.x > _maxCanBig) {
        toBig = YES;
    }
    
    
    if (toBig) {
        [self setNeedsDisplay];
    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [_bezierPath removeAllPoints];
    
    NSLog(@"%.f",self.contentOffset.x - _maxCanBig);
    UIColor *color = [UIColor grayColor];
    [color set];

    
    CGFloat pointX = 0;
    
    if (self.contentOffset.x - _maxCanBig < 0) {
        pointX = 0;
    } else {
        pointX = self.contentOffset.x - _maxCanBig;
    }
    
    
    CGFloat pointControlX = 0;
    
    CGFloat fixPointControlX = 0;
    
    if (self.contentOffset.x - _maxCanBig < 0) {
        pointControlX = 0;
    } else {
        
        if (self.contentOffset.x - _maxCanBig > 32) {
            fixPointControlX = (self.contentOffset.x - _maxCanBig) - 32;
            pointControlX = - (32 - fixPointControlX);
            
            self.showMoreLabel.frame = CGRectMake(10 + fixPointControlX, self.showMoreLabel.frame.origin.y, self.showMoreLabel.frame.size.width, self.showMoreLabel.frame.size.height);
            
        } else {
            self.showMoreLabel.frame = CGRectMake(10, self.showMoreLabel.frame.origin.y, self.showMoreLabel.frame.size.width, self.showMoreLabel.frame.size.height);
            pointControlX = - (self.contentOffset.x - _maxCanBig);
        }
    }

    [_bezierPath moveToPoint:CGPointMake(pointX, 0)];
    [_bezierPath addQuadCurveToPoint:CGPointMake(pointX, self.frame.size.height) controlPoint:CGPointMake( pointControlX, self.frame.size.height / 2)];
    [_bezierPath addLineToPoint:CGPointMake(_contentSizeWidth, self.frame.size.height)];
    [_bezierPath addLineToPoint:CGPointMake(_contentSizeWidth, 0)];

    [_bezierPath closePath];

    _shapeLayer.path = _bezierPath.CGPath;

}


@end

