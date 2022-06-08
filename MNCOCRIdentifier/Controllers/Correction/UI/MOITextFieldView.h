//
//  MOITextFieldView.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 07/06/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface MOITextFieldView : UIStackView

- (void)setAsFocus;
- (void)dismissFocus;
- (void)setError:(nullable NSString *)errorText;

@end

@protocol MOITextFieldDelegate <NSObject>

- (void)textFieldReturn:(MOITextFieldView *)textFieldView;

@end

@interface MOITextFieldView ()

@property (nonatomic) id <MOITextFieldDelegate> delegate;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *text;
@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) UIView *inputAccessoryView;
@property (nonatomic) UIView *inputView;

@end

NS_ASSUME_NONNULL_END
