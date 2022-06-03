//
//  MOICommonTextModel.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <Foundation/Foundation.h>
#import "MOIReligionModel.h"
#import "MOIMarriageStatusModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MOICommonTextModel : NSObject

@property (nonatomic) MOIReligionModel *religionModel;
@property (nonatomic) MOIMarriageStatusModel *marriageStatusModel;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
