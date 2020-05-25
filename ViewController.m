//
//  ViewController.m
//  CoreML
//
//  Created by 123 on 2020/5/25.
//  Copyright © 2020 game. All rights reserved.
//

#import "ViewController.h"
#import <CoreML/CoreML.h>
 #import <Vision/Vision.h>
#import "Resnet50.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Resnet50 *resnetModel = [[Resnet50 alloc] init];
    UIImage *image = [UIImage imageNamed:@"1234"];
    VNCoreMLModel *vnCoreModel = [VNCoreMLModel modelForMLModel:resnetModel.model error:nil];
    
    VNCoreMLRequest *vnCoreMlRequest = [[VNCoreMLRequest alloc] initWithModel:vnCoreModel completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        CGFloat confidence = 0.0f;
        VNClassificationObservation *tempClassification = nil;
        for (VNClassificationObservation *classification in request.results) {
            if (classification.confidence > confidence) {
                confidence = classification.confidence;
                tempClassification = classification;
            }
        }
        
//        self.recognitionResultLabel.text = [NSString stringWithFormat:@"识别结果:%@",tempClassification.identifier];
//        self.confidenceResult.text = [NSString stringWithFormat:@"匹配率:%@",@(tempClassification.confidence)];
    }];
    
    VNImageRequestHandler *vnImageRequestHandler = [[VNImageRequestHandler alloc] initWithCGImage:image.CGImage options:nil];
    
    NSError *error = nil;
    [vnImageRequestHandler performRequests:@[vnCoreMlRequest] error:&error];
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    // Do any additional setup after loading the view.
}


@end
