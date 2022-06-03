//
//  MOIMarriageStatusModel.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MOIMarriageStatusModel : NSObject

@property (nonatomic) NSArray *kawinArray;
@property (nonatomic) NSArray *belumArray;
@property (nonatomic) NSArray *ceraiArray;
@property (nonatomic) NSArray *hidupArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
