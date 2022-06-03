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

@property (nonatomic) NSString *ktpPath;
@property (nonatomic) MOIKTPDataModel *ktpData;

@end

NS_ASSUME_NONNULL_END
