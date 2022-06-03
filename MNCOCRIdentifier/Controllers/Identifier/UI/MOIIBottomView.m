//
//  MOIIBottomView.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 31/05/22.
//

#import "MOIIBottomView.h"

@implementation MOIIBottomView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        UIView *roundedView = [UIView new];
        roundedView.backgroundColor = [UIColor whiteColor];
        roundedView.layer.cornerRadius = 40;
        roundedView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:roundedView];
        [roundedView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [roundedView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [roundedView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [roundedView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        
        UIView *whiteSpaceView = [UIView new];
        whiteSpaceView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:whiteSpaceView];
        [whiteSpaceView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [whiteSpaceView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [whiteSpaceView.heightAnchor constraintEqualToConstant:40].active = YES;
        
        UIStackView *contentStackView = [UIStackView new];
        contentStackView.axis = UILayoutConstraintAxisVertical;
        contentStackView.distribution = UIStackViewDistributionEqualSpacing;
        contentStackView.alignment = UIStackViewAlignmentCenter;
        contentStackView.spacing = 16;
        contentStackView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.counterLabel = [UILabel new];
        self.counterLabel.textColor = [UIColor redColor];
        self.counterLabel.text = @"3";
        self.counterLabel.font = [UIFont systemFontOfSize:48];
        
        UILabel *instructionLabel = [UILabel new];
        instructionLabel.textColor = [UIColor blackColor];
        instructionLabel.text = @"Tahan selama waktu selesai";
        instructionLabel.font = [UIFont systemFontOfSize:16];
        
        [contentStackView addArrangedSubview:self.counterLabel];
        [contentStackView addArrangedSubview:instructionLabel];
        
        [self addSubview:contentStackView];
        [contentStackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        [contentStackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    }
    
    return self;
}

@end
