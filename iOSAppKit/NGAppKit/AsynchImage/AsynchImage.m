//
//  KGAsynchImage.m
//  SampleAllProjects
//
//  Created by Towhidul Islam on 11/13/17.
//  Copyright © 2017 KITE GAMES STUDIO. All rights reserved.
//

#import "AsynchImage.h"

@interface AsynchImage(){
    UIImage *_contentImage;
    NSURLSessionDownloadTask *_dTask;
}
@end

@implementation AsynchImage

- (instancetype)initWithLink:(NSString *)link{
    if (self = [super initWithInfo:@{@"imageLink":link}]) {
        //
    }
    return self;
}

- (NSString*) getImagePath:(NSString*)fileName{
    NSString *dirPath = [[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject] path];
    return [dirPath stringByAppendingPathComponent:fileName];
}

- (NSString*) getUniqueName:(NSString*)link{
    NSString *extension = [link pathExtension];
    NSString *saveName = [NSString stringWithFormat:@"%ld.%@",(unsigned long)[self.imageLink hash],extension];
    return saveName;
}

- (void)asynchFetchOnQueue:(dispatch_queue_t)queue cache:(BOOL)shouldCache completion:(void (^)(UIImage * _Nullable))handler{
    if (queue == nil) {
        queue = dispatch_get_main_queue();
    }
    //If its a local file
    if ([[NSFileManager defaultManager] isReadableFileAtPath:self.imageLink]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            _contentImage = [[UIImage alloc] initWithContentsOfFile:self.imageLink];
            dispatch_async(queue, ^{
                if(handler) handler(_contentImage);
            });
        });
        return;
    }
    //Operation For RemoteImage
    if (shouldCache) {
        //lets try to load from cache.
        NSString *saveName = [self getUniqueName:self.imageLink];
        NSString *savePath = [self getImagePath:saveName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:savePath] == YES) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                _contentImage = [[UIImage alloc] initWithContentsOfFile:savePath];
                dispatch_async(queue, ^{
                    if(handler) handler(_contentImage);
                });
            });
            return;
        }
    }
    //File was not cached...So lets fetch from server.
    if (_dTask) {
        return;
    }
    NSURL *downloadUrl = [NSURL URLWithString:[self.imageLink stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    _dTask = [[NSURLSession sharedSession] downloadTaskWithURL:downloadUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (location) {
            _contentImage = [[UIImage alloc] initWithContentsOfFile:location.path];
            //save for caching
            if (shouldCache) {
                NSString *saveName = [self getUniqueName:self.imageLink];
                NSString *savePath = [self getImagePath:saveName];
                if ([[NSFileManager defaultManager] fileExistsAtPath:savePath] == NO) {
                    NSData *data = [[[saveName pathExtension] lowercaseString] isEqualToString:@"png"] ? UIImagePNGRepresentation(_contentImage) : UIImageJPEGRepresentation(_contentImage, 1.0);
                    if([data writeToFile:savePath atomically:YES])
                        NSLog(@"Save Successfull %@",saveName);
                }
            }
        }
        _dTask = nil;
        dispatch_async(queue, ^{
            if(handler) handler(_contentImage);
        });
    }];
    [_dTask resume];
}

- (void)fetch:(void (^ _Nullable)(UIImage * _Nullable))handler{
    if (_contentImage == nil) {
        [self asynchFetchOnQueue:nil cache:YES completion:handler];
    }
    else{
        if(handler) handler(_contentImage);
    }
}

- (void) fetchWithSize:(CGSize)size completion:(void(^ _Nullable)(UIImage* _Nullable))handler{
    if (_contentImage == nil) {
        [self asynchFetchOnQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) cache:YES completion:^(UIImage * _Nullable img) {
            UIImage *resize = [self imageByScalingAndCropping:size source:img];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(handler) handler(resize);
            });
        }];
    }
    else{
        if (CGSizeEqualToSize(_contentImage.size, size)) {
            if(handler) handler(_contentImage);
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                UIImage *resize = [self imageByScalingAndCropping:size source:_contentImage];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(handler) handler(resize);
                });
            });
        }
    }
}

- (UIImage*)imageByScalingAndCropping:(CGSize)targetSize source:(UIImage*) sourceImage{
    //
    CGSize sourceSize = sourceImage.size;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetSize.width;
    CGFloat scaledHeight = targetSize.height;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(sourceSize, targetSize) == NO){
        CGFloat widthFactor = targetSize.width / sourceSize.width;
        CGFloat heightFactor = targetSize.height / sourceSize.height;
        
        if (widthFactor > heightFactor){
            scaleFactor = widthFactor; // scale to fit height
        }
        else{
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = sourceSize.width * scaleFactor;
        scaledHeight = sourceSize.height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor){
            thumbnailPoint.y = (targetSize.height - scaledHeight) * 0.5;
        }
        else{
            thumbnailPoint.x = (targetSize.width - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
