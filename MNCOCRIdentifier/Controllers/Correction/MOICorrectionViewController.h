//
//  MOICorrectionViewController.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <UIKit/UIKit.h>
#import "MOIKTPDataModel.h"
#import "MNCOCRIdentifierDelegate.h"
#import "MOIDismissDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MOICorrectionViewController : UIViewController

@property (weak, nonatomic) id <MNCOCRIdentifierDelegate> resultDelegate;
@property (weak, nonatomic) id <MOIDismissDelegate> dismissDelegate;
@property (strong, nonatomic) MOIKTPDataModel *ktpData;
@property (strong, nonatomic) UIImage *ktpImage;

@end

NS_ASSUME_NONNULL_END
