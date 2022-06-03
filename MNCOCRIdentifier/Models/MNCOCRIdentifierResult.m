//
//  MNCOCRIdentifierResult.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MNCOCRIdentifierResult.h"

@implementation MNCOCRIdentifierResult

- (NSString *)asJson {
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self dictionary] options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObject:(self.errorMessage == nil) ? [NSNull null] : self.errorMessage forKey:@"errorMessage"];
    [dictionary setObject:(self.imagePath == nil) ? [NSNull null] : self.imagePath forKey:@"imagePath"];
    [dictionary setObject:@(self.isSuccess)  forKey:@"isSuccess"];
    [dictionary setObject:(self.ktp == nil) ? [NSNull null] : self.ktp.dictionary forKey:@"ktp"];
    
    return [[NSDictionary alloc] initWithDictionary:dictionary copyItems:YES];
}

@end
