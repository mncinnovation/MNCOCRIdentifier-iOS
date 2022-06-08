//
//  MOITextFieldView.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 07/06/22.
//

#import "MOITextFieldView.h"

@interface MOITextFieldView () <UITextFieldDelegate>

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *errorLabel;
@property (nonatomic) UITextField *textField;

@end

@implementation MOITextFieldView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.axis = UILayoutConstraintAxisVertical;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentFill;
        
        self.titleLabel = [UILabel new];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
        [self addArrangedSubview:self.titleLabel];
        
        UIView *firstSeparator = [UIView new];
        firstSeparator.translatesAutoresizingMaskIntoConstraints = NO;
        [self addArrangedSubview:firstSeparator];
        [firstSeparator.heightAnchor constraintEqualToConstant:8].active = YES;
        
        UIStackView *textFieldStackView = [UIStackView new];
        textFieldStackView.backgroundColor = [UIColor whiteColor];
        textFieldStackView.layoutMarginsRelativeArrangement = YES;
        textFieldStackView.layer.cornerRadius = 4;
        textFieldStackView.layer.masksToBounds = YES;
        textFieldStackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(12, 16, 12, 16);
        
        self.textField = [UITextField new];
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.delegate = self;
        self.textField.returnKeyType = UIReturnKeyNext;
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        
        UIImage *pencilImage = [UIImage imageNamed:@"ic_pencil" inBundle:[NSBundle bundleWithIdentifier:@"MNCIdentifier.MNCOCRIdentifier"] compatibleWithTraitCollection:nil];
        UIImageView *pencilImageView = [UIImageView new];
        pencilImageView.image = pencilImage;
        pencilImageView.contentMode = UIViewContentModeScaleAspectFit;
        pencilImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [textFieldStackView addArrangedSubview:self.textField];
        [textFieldStackView addArrangedSubview:pencilImageView];
        [pencilImageView.heightAnchor constraintEqualToConstant:18].active = YES;
        [pencilImageView.widthAnchor constraintEqualToConstant:18].active = YES;
        
        [self addArrangedSubview:textFieldStackView];
        
        self.errorLabel = [UILabel new];
        self.errorLabel.textColor = [UIColor redColor];
        self.errorLabel.font = [UIFont systemFontOfSize:12];
        self.errorLabel.hidden = YES;
        [self addArrangedSubview:self.errorLabel];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

- (NSString *)text {
    return self.textField.text;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    self.textField.keyboardType = keyboardType;
}

- (UIKeyboardType)keyboardType {
    return self.textField.keyboardType;
}

- (void)setInputView:(UIView *)inputView {
    self.textField.inputView = inputView;
}

- (void)setInputAccessoryView:(UIView *)inputAccessoryView {
    self.textField.inputAccessoryView = inputAccessoryView;
}

- (void)dismissFocus {
    [self.textField resignFirstResponder];
}

- (void)setAsFocus {
    [self.textField becomeFirstResponder];
}

- (void)setError:(nullable NSString *)errorText {
    self.errorLabel.hidden = errorText == nil;
    self.errorLabel.text = errorText;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.delegate textFieldReturn:self];
    return YES;
}

@end
