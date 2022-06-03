//
//  MOIMarriageStatusModel.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOIMarriageStatusModel.h"

@implementation MOIMarriageStatusModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.kawinArray = dictionary[@"kawin"];
        self.belumArray = dictionary[@"belum"];
        self.ceraiArray = dictionary[@"cerai"];
        self.hidupArray = dictionary[@"hidup"];
    }
    return self;
}


@end
