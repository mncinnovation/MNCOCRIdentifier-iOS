//
//  MOIExtractKTPData.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MOIKTPDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ExtractKTPCallback)(MOIKTPDataModel *_Nullable data, CGFloat completedPercentage)
    NS_SWIFT_NAME(KTPCallback);

@interface MOIExtractKTPData : NSObject

- (void)extractImageFromCamera:(UIImage *)image isImageRotate:(BOOL)imageRotate completion:(ExtractKTPCallback)completion NS_SWIFT_NAME(process(_:completion:));



@end

NS_ASSUME_NONNULL_END
