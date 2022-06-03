//
//  MOIIdentifierViewController.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <UIKit/UIKit.h>
#import "MNCOCRIdentifierDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MOIIdentifierViewController : UIViewController

@property (weak, nonatomic) id <MNCOCRIdentifierDelegate> resultDelegate;

@end

NS_ASSUME_NONNULL_END
