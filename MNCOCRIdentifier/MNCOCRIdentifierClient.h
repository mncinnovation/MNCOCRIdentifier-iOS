//
//  MNCOCRIdentifierClient.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MNCOCRIdentifierDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNCOCRIdentifierClient : NSObject

@property(nonatomic, weak) id <MNCOCRIdentifierDelegate> delegate;

- (void)showOCRIdentifier:(UIViewController *)parent;

@end

NS_ASSUME_NONNULL_END
