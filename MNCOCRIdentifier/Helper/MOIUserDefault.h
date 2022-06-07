//
//  MOIUserDefault.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 07/06/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MOIUserDefault : NSObject

+ (void)setFlashEnable:(BOOL)isEnable;
+ (BOOL)isFlashEnable;

@end

NS_ASSUME_NONNULL_END
