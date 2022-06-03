//
//  MOIReligionModel.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MOIReligionModel : NSObject

@property (nonatomic) NSArray *islamArray;
@property (nonatomic) NSArray *kristenArray;
@property (nonatomic) NSArray *katholikArray;
@property (nonatomic) NSArray *budhaArray;
@property (nonatomic) NSArray *hinduArray;
@property (nonatomic) NSArray *konghuchuArray;
@property (nonatomic) NSArray *kepercayaanArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
