//
//  MOIUtils.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOIUtils.h"

@implementation MOIUtils

+ (UIImageOrientation)imageOrientationFromDevicePosition:(AVCaptureDevicePosition)devicePosition {
    UIDeviceOrientation deviceOrientation = UIDevice.currentDevice.orientation;
    if (deviceOrientation == UIDeviceOrientationFaceDown || deviceOrientation == UIDeviceOrientationFaceUp || deviceOrientation == UIDeviceOrientationUnknown) {
        deviceOrientation = [self currentUIOrientation];
    }
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
            return devicePosition == AVCaptureDevicePositionFront ? UIImageOrientationLeftMirrored
            : UIImageOrientationRight;
        case UIDeviceOrientationLandscapeLeft:
            return devicePosition == AVCaptureDevicePositionFront ? UIImageOrientationDownMirrored
            : UIImageOrientationUp;
        case UIDeviceOrientationPortraitUpsideDown:
            return devicePosition == AVCaptureDevicePositionFront ? UIImageOrientationRightMirrored
            : UIImageOrientationLeft;
        case UIDeviceOrientationLandscapeRight:
            return devicePosition == AVCaptureDevicePositionFront ? UIImageOrientationUpMirrored
            : UIImageOrientationDown;
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationUnknown:
            return UIImageOrientationUp;
    }
}

+ (UIDeviceOrientation)currentUIOrientation {
    UIDeviceOrientation (^deviceOrientation)(void) = ^UIDeviceOrientation(void) {
        switch (UIApplication.sharedApplication.statusBarOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                return UIDeviceOrientationLandscapeRight;
            case UIInterfaceOrientationLandscapeRight:
                return UIDeviceOrientationLandscapeLeft;
            case UIInterfaceOrientationPortraitUpsideDown:
                return UIDeviceOrientationPortraitUpsideDown;
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationUnknown:
                return UIDeviceOrientationPortrait;
        }
    };
    
    if (NSThread.isMainThread) {
        return deviceOrientation();
    } else {
        __block UIDeviceOrientation currentOrientation = UIDeviceOrientationPortrait;
        dispatch_sync(dispatch_get_main_queue(), ^{
            currentOrientation = deviceOrientation();
        });
        return currentOrientation;
    }
}

+ (void)addDotOnSide:(CGRect)objectRect toView:(UIView *)view {
    CGFloat objectCenterX = (objectRect.size.width / 2) + objectRect.origin.x;
    CGFloat objectCenterY = (objectRect.size.height / 2) + objectRect.origin.y;
    
    UIView *centerTopView = [[UIView alloc] initWithFrame:CGRectMake(objectCenterX, objectRect.origin.y, 6, 6)];
    centerTopView.layer.cornerRadius = 3;
    centerTopView.backgroundColor = UIColor.redColor;
    [view addSubview:centerTopView];
    
    UIView *centerBottomView = [[UIView alloc] initWithFrame:CGRectMake(objectCenterX, objectRect.origin.y + objectRect.size.height, 6, 6)];
    centerBottomView.layer.cornerRadius = 3;
    centerBottomView.backgroundColor = UIColor.redColor;
    [view addSubview:centerBottomView];
    
    UIView *leftCenterView = [[UIView alloc] initWithFrame:CGRectMake(objectRect.origin.x, objectCenterY, 6, 6)];
    leftCenterView.layer.cornerRadius = 3;
    leftCenterView.backgroundColor = UIColor.redColor;
    [view addSubview:leftCenterView];
    
    UIView *rightCenterView = [[UIView alloc] initWithFrame:CGRectMake(objectRect.origin.x + objectRect.size.width, objectCenterY, 6, 6)];
    rightCenterView.layer.cornerRadius = 3;
    rightCenterView.backgroundColor = UIColor.redColor;
    [view addSubview:rightCenterView];
}

+ (void)addDot:(CGRect)dotRect toView:(UIView *)view withColor:(UIColor *)color {
    CGRect rect = CGRectMake(dotRect.origin.x, dotRect.origin.y, 6, 6);
    UIView *dotView = [[UIView alloc] initWithFrame:rect];
    dotView.layer.cornerRadius = 3;
    dotView.backgroundColor = color;
    [view addSubview:dotView];
}

+ (MOIComparationModel *)getRectAccuration:(CGRect)mainRect byComparison:(CGRect)viewRect enableDot:(BOOL)isDotEnable viewForDot:(UIView *)dotView{
    CGRect viewTopLeftRect = CGRectMake(viewRect.origin.x, viewRect.origin.y, 0, 0);
    CGRect viewTopRightRect = CGRectMake(viewTopLeftRect.origin.x + viewRect.size.width, viewTopLeftRect.origin.y, 0, 0);
    CGRect viewBottomLeftRect = CGRectMake(viewTopLeftRect.origin.x, viewTopLeftRect.origin.y + viewRect.size.height, 0, 0);
    CGRect viewBottomRightRect = CGRectMake(viewTopRightRect.origin.x, viewBottomLeftRect.origin.y, 0, 0);
    
    CGFloat mainCenterX = (mainRect.size.width / 2) + mainRect.origin.x;
    CGFloat mainCenterY = (mainRect.size.height / 2) + mainRect.origin.y;
    
    CGRect mainCenterLeft = CGRectMake(mainRect.origin.x, mainCenterY, 0, 0);
    CGRect mainCenterRight = CGRectMake(mainCenterLeft.origin.x + mainRect.size.width, mainCenterY, 0, 0);
    CGRect mainCenterTop = CGRectMake(mainCenterX, mainRect.origin.y, 0, 0);
    CGRect mainCenterBottom = CGRectMake(mainCenterTop.origin.x, mainCenterTop.origin.y + mainRect.size.height, 0, 0);
    
    if (isDotEnable && dotView != nil) {
        [MOIUtils addDot:viewTopLeftRect toView:dotView withColor:UIColor.purpleColor];
        [MOIUtils addDot:viewTopRightRect toView:dotView withColor:UIColor.purpleColor];
        [MOIUtils addDot:viewBottomLeftRect toView:dotView withColor:UIColor.purpleColor];
        [MOIUtils addDot:viewBottomRightRect toView:dotView withColor:UIColor.purpleColor];
        
        [MOIUtils addDot:mainCenterLeft toView:dotView withColor:UIColor.redColor];
        [MOIUtils addDot:mainCenterRight toView:dotView withColor:UIColor.redColor];
        [MOIUtils addDot:mainCenterTop toView:dotView withColor:UIColor.blueColor];
        [MOIUtils addDot:mainCenterBottom toView:dotView withColor:UIColor.blueColor];
    }
    
    CGFloat leftPointDiff = mainCenterLeft.origin.x - viewTopLeftRect.origin.x;
    CGFloat rightPointDiff = mainCenterRight.origin.x - viewTopRightRect.origin.x;
    CGFloat topPointDiff = mainCenterTop.origin.y - viewTopLeftRect.origin.y;
    CGFloat bottomPointDiff = mainCenterBottom.origin.y - viewBottomLeftRect.origin.y;
    
    leftPointDiff = leftPointDiff < 0 ? leftPointDiff * -1 : leftPointDiff;
    rightPointDiff = rightPointDiff < 0 ? rightPointDiff * -1 : rightPointDiff;
    topPointDiff = topPointDiff < 0 ? topPointDiff * -1 : topPointDiff;
    bottomPointDiff = bottomPointDiff < 0 ? bottomPointDiff * -1 : bottomPointDiff;
    
    CGFloat leftPercentage = ((100 - leftPointDiff) / 100) * 100;
    CGFloat rightPercentage = ((100 - rightPointDiff) / 100) * 100;
    CGFloat topPercentage = ((100 - topPointDiff) / 100) * 100;
    CGFloat bottomPercentage = ((100 - bottomPointDiff) / 100) * 100;
    CGFloat accuratePercentage = (((leftPercentage + rightPercentage + topPercentage + bottomPercentage) /4) /100) * 100;
    
    BOOL isLeftPointInside = (mainCenterLeft.origin.x > viewTopLeftRect.origin.x && mainCenterLeft.origin.x < viewTopRightRect.origin.x && mainCenterLeft.origin.y > viewTopLeftRect.origin.y && mainCenterLeft.origin.y < viewBottomLeftRect.origin.y);
    BOOL isRightPointInside = (mainCenterRight.origin.x > viewTopLeftRect.origin.x && mainCenterRight.origin.x < viewTopRightRect.origin.x && mainCenterLeft.origin.x && mainCenterRight.origin.y > viewTopRightRect.origin.y &&  mainCenterRight.origin.y < viewBottomRightRect.origin.y);
    BOOL isTopPointInside = (mainCenterTop.origin.x > viewTopLeftRect.origin.x && mainCenterTop.origin.x < viewTopRightRect.origin.x && mainCenterTop.origin.y > viewTopLeftRect.origin.y && mainCenterTop.origin.y < viewBottomLeftRect.origin.y );
    BOOL isBottomPointInside = (mainCenterBottom.origin.x > viewBottomLeftRect.origin.x && mainCenterBottom.origin.x < viewBottomRightRect.origin.x && mainCenterBottom.origin.y > viewTopLeftRect.origin.y && mainCenterBottom.origin.y < viewBottomLeftRect.origin.y);
    
    MOIComparationModel *comparationModel = [MOIComparationModel new];
    comparationModel.leftPercentage = leftPercentage;
    comparationModel.rightPercentage = rightPercentage;
    comparationModel.topPercentage = topPercentage;
    comparationModel.bottomPercentage = bottomPercentage;
    comparationModel.accuratePercentage = accuratePercentage;
    comparationModel.isLeftPointInside = isLeftPointInside;
    comparationModel.isRightPointInside = isRightPointInside;
    comparationModel.isTopPointInside = isTopPointInside;
    comparationModel.isBottomPointInside = isBottomPointInside;
    
    return comparationModel;
}

+ (UIColor *)colorWithHexString:(NSString *)hex {
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];

    if ([cString length] != 6) return  [UIColor grayColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];

    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
