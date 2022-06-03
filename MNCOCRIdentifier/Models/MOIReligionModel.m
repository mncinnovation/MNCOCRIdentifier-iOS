//
//  MOIReligionModel.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOIReligionModel.h"

@implementation MOIReligionModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.islamArray = dictionary[@"islam"];
        self.kristenArray = dictionary[@"kristen"];
        self.katholikArray = dictionary[@"katholik"];
        self.budhaArray = dictionary[@"budha"];
        self.hinduArray = dictionary[@"hindu"];
        self.konghuchuArray = dictionary[@"konghuchu"];
        self.kepercayaanArray = dictionary[@"kepercayaan"];
    }
    return self;
}

@end
