//
//  MOINumberValidationModel.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOINumberValidationModel.h"

@implementation MOINumberValidationModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.firstArray = dictionary[@"1"];
        self.secondArray = dictionary[@"2"];
        self.thirdArray = dictionary[@"3"];
        self.fourthArray = dictionary[@"4"];
        self.fifthArray = dictionary[@"5"];
        self.sixthArray = dictionary[@"6"];
        self.seventhArray = dictionary[@"7"];
        self.eighthArray = dictionary[@"8"];
        self.ninethArray = dictionary[@"9"];
        self.zeroArray = dictionary[@"0"];
    }
    return self;
}

@end
