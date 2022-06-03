//
//  MOINumberValidationModel.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MOINumberValidationModel : NSObject

@property (nonatomic) NSArray *firstArray;
@property (nonatomic) NSArray *secondArray;
@property (nonatomic) NSArray *thirdArray;
@property (nonatomic) NSArray *fourthArray;
@property (nonatomic) NSArray *fifthArray;
@property (nonatomic) NSArray *sixthArray;
@property (nonatomic) NSArray *seventhArray;
@property (nonatomic) NSArray *eighthArray;
@property (nonatomic) NSArray *ninethArray;
@property (nonatomic) NSArray *zeroArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
