//
//  MNCOCRIdentifierDelegate.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//
#import "MNCOCRIdentifierResult.h"

#ifndef MNCOCRIdentifierDelegate_h
#define MNCOCRIdentifierDelegate_h

@protocol MNCOCRIdentifierDelegate <NSObject>

- (void)ocrResult:(nullable MNCOCRIdentifierResult *)result; 

@end

#endif /* MNCOCRIdentifierDelegate_h */
