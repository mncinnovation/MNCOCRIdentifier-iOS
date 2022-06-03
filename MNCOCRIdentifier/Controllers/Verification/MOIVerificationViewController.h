//
//  MOIVerificationViewController.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <UIKit/UIKit.h>
#import "MOIKTPDataModel.h"
#import "MNCOCRIdentifierDelegate.h"
#import "MOIDismissDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MOIVerificationViewController : UIViewController

@property (weak, nonatomic) id <MNCOCRIdentifierDelegate> resultDelegate;
@property (weak, nonatomic) id <MOIDismissDelegate> dissmissDelegate;
@property (weak, nonatomic) MOIKTPDataModel *ktpData;
@property (strong, nonatomic) UIImage *ktpImage;

@end

NS_ASSUME_NONNULL_END
