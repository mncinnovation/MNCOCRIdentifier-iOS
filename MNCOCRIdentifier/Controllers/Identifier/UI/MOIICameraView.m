//
//  MOIICameraView.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 31/05/22.
//

#import "MOIICameraView.h"

@implementation MOIICameraView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

-(void)startCamera {
    self.captureSession = [AVCaptureSession new];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    
    AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
      NSArray *captureDevices = [captureDeviceDiscoverySession devices];
      
      NSError *error;
      AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevices[0] error:&error];
      
      AVCaptureVideoDataOutput *outputDevice = [[AVCaptureVideoDataOutput alloc] init];
      outputDevice.videoSettings = @{(id) kCVPixelBufferPixelFormatTypeKey: [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA]};
      outputDevice.alwaysDiscardsLateVideoFrames = YES;
      [outputDevice setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
      
      if (!error) {
          if ([self.captureSession canAddInput:input] && [self.captureSession canAddOutput:outputDevice]) {
              [self.captureSession addInput:input];
              [self.captureSession addOutput:outputDevice];
              [self setupLivePreview];
          }
      } else {
          NSLog(@"Error Unable to intialize front camera: %@", error.localizedDescription);
      }
}

- (void)stopCamera {
    [self.captureSession stopRunning];
}

-(void)setupLivePreview {
    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.layer addSublayer:self.videoPreviewLayer];
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(globalQueue, ^{
        [self.captureSession startRunning];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.videoPreviewLayer.frame = self.bounds;
        });
    });
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    [self.delegate streamOutput:sampleBuffer];
}

@end
