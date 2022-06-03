//
//  MOIUtils.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>
#import <UIKit/UIKit.h>
#import "MOIComparationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MOIUtils : NSObject

+ (UIImageOrientation)imageOrientationFromDevicePosition:(AVCaptureDevicePosition)devicePosition;
+ (UIDeviceOrientation)currentUIOrientation;
+ (void)addDotOnSide:(CGRect)objectRect toView:(UIView *)view;
+ (void)addDot:(CGRect)dotRect toView:(UIView *)view withColor:(UIColor *)color;
+ (MOIComparationModel *)getRectAccuration:(CGRect)mainRect byComparison:(CGRect)viewRect enableDot:(BOOL)isDotEnable viewForDot:(UIView *)dotView;
+ (UIColor *)colorWithHexString:(NSString *)hex;

@end

NS_ASSUME_NONNULL_END
