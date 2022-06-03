//
//  MNCOCRIdentifierResult.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MOIKTPDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNCOCRIdentifierResult : NSObject

@property (nonatomic, nullable) NSString *errorMessage;
@property (nonatomic, nullable) NSString *imagePath;
@property (nonatomic) BOOL isSuccess;
@property (nonatomic, nullable) MOIKTPDataModel *ktp;

- (NSString *)asJson;

@end

NS_ASSUME_NONNULL_END
