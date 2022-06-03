//
//  MOIIKTPFrameView.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 31/05/22.
//

#import "MOIIKTPFrameView.h"

static const CGFloat widthKTPRatio = 856;
static const CGFloat heightKTPRatio = 539;

@implementation MOIIKTPFrameView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat widthKTPView = width - 72;
        CGFloat heightKTPView = (heightKTPRatio * widthKTPView) / widthKTPRatio;
        
        self.ktpView = [UIView new];
        self.ktpView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.ktpView];
        [self.ktpView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [self.ktpView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        [self.ktpView.widthAnchor constraintEqualToConstant:widthKTPView].active = YES;
        [self.ktpView.heightAnchor constraintEqualToConstant:heightKTPView].active = YES;
        
        UIView *ktpBorderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthKTPView, (heightKTPView - 1))];
        [self.ktpView addSubview:ktpBorderView];
        
        CAShapeLayer *ktpBorderLayer = [CAShapeLayer layer];
        ktpBorderLayer.strokeColor = [UIColor whiteColor].CGColor;
        ktpBorderLayer.fillColor = nil;
        ktpBorderLayer.lineDashPattern = @[@10, @5];
        ktpBorderLayer.frame = ktpBorderView.bounds;
        ktpBorderLayer.path = [UIBezierPath bezierPathWithRect:ktpBorderView.bounds].CGPath;
        [ktpBorderView.layer addSublayer:ktpBorderLayer];
    }
    
    return self;
}

@end
