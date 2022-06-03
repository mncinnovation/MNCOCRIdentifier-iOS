//
//  MOIICameraView.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 31/05/22.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MOIICameraDelegate <NSObject>

- (void)streamOutput:(CMSampleBufferRef)streamBuffer;

@end

@interface MOIICameraView : UIView<AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (weak, nonatomic) id <MOIICameraDelegate> delegate;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

- (void)startCamera;
- (void)stopCamera;

@end

NS_ASSUME_NONNULL_END
