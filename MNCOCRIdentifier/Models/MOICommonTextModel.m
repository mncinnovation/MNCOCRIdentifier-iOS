//
//  MOICommonTextModel.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOICommonTextModel.h"

@implementation MOICommonTextModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.religionModel = [[MOIReligionModel alloc] initWithDictionary:dictionary[@"religions"]];
        self.marriageStatusModel = [[MOIMarriageStatusModel alloc] initWithDictionary:dictionary[@"marriageStatus"]];
        self.numberValidationModel = [[MOINumberValidationModel alloc] initWithDictionary:dictionary[@"numberValidation"]];
    }
    return self;
}

@end
