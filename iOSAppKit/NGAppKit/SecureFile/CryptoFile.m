//
//  SecureFileX.m
//  KitePhotoLocker
//
//  Created by Towhidul Islam on 6/21/18.
//  Copyright © 2018 Kite Games Studio. All rights reserved.
//

#import "CryptoFile.h"
#import "RNCryptorHelper.h"

@interface CryptoFile ()
@property (nonatomic) id<IFile> file;
@end

@implementation CryptoFile

- (instancetype)initWithUrl:(NSURL *)url{
    if (self = [self initWithFile:[[File alloc] initWithUrl:url]]) {
    }
    return self;
}

- (instancetype)initWithFile:(id<IFile>)file{
    if (self = [super init]) {
        _file = file;
    }
    return self;
}

- (void)decrypt:(NSString *)key bufferSize:(int)size progress:(id<IFileProgress>)prog completionHandler:(void (^)(NSData*))handler{
    //
    if (size < 1024){
        size = 1024;
    }
    int blockSize = 32 * size;
    
    NSInputStream *readStream = [[NSInputStream alloc] initWithFileAtPath:[self.file.URL path]];
    __block NSMutableData *writeStream = [[NSMutableData alloc] init];
    __block NSError *cnryptionError = nil;
    __block RNDecryptor *decryptor = nil;
    __block int totalWritenLength = 0;
    __block long long readFileTotalBytes = self.file.sizeInBytes;
    
    [readStream open];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        decryptor = [RNCryptorHelper decryptorWithKey:key handler:^(RNCryptor *cryptor, NSData *data) {
            @autoreleasepool {
                //NSLog(@"Decryptor recevied %d bytes", data.length);
                [writeStream appendBytes:data.bytes length:data.length];
                dispatch_semaphore_signal(semaphore);
                data = nil;
                
                if (cryptor.isFinished) {
                    // call my delegate that I'm finished with decrypting
                    if (handler) {
                        handler(writeStream);
                    }
                }
                if(cryptor.error){
                    cnryptionError = cryptor.error;
                    [readStream close];
                    if (handler) {
                        handler(nil);
                    }
                }
            }
        }];
        
        while (readStream.hasBytesAvailable) {
            @autoreleasepool {
                uint8_t buf[blockSize];
                NSUInteger bytesRead = [readStream read:buf maxLength:blockSize];
                if(bytesRead == 0){
                    [readStream close];
                    [decryptor finish];
                }
                else if (bytesRead > 0) {
                    NSData *data = [NSData dataWithBytes:buf length:bytesRead];
                    totalWritenLength += bytesRead;
                    [decryptor addData:data];
                    //NSLog(@"New bytes to decryptor: %d Total: %d", bytesRead, total);
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [((File*)self.file) calculateProgressWithTotalReadWrite:totalWritenLength totalDataLength:readFileTotalBytes progress:prog];
                    });
                    
                }else{
                    NSLog(@"Error Has Occoured In DNFile.secureWrite(from:bufferSize:password:completionHandler:) method.");
                    if (handler){
                        handler(nil);
                    }
                }
            }
        }
    });
}

- (void)decryptTo:(id<IFile>)file bufferSize:(int)size password:(NSString *)key progress:(id<IFileProgress>)prog completionHandler:(void (^)(BOOL))handler{
    //
    if (size < 1024){
        size = 1024;
    }
    int blockSize = 32 * size;
    
    NSInputStream *readStream = [[NSInputStream alloc] initWithFileAtPath:[self.file.URL path]];
    __block NSOutputStream *writeStream = [[NSOutputStream alloc] initToFileAtPath:[file.URL path] append:NO];
    __block NSError *cnryptionError = nil;
    __block RNDecryptor *decryptor = nil;
    __block int totalWritenLength = 0;
    __block long long readFileTotalBytes = self.file.sizeInBytes;
    
    [readStream open];
    [writeStream open];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        decryptor = [RNCryptorHelper decryptorWithKey:key handler:^(RNCryptor *cryptor, NSData *data) {
            @autoreleasepool {
                //NSLog(@"Decryptor recevied %d bytes", data.length);
                [writeStream write:data.bytes maxLength:data.length];
                dispatch_semaphore_signal(semaphore);
                data = nil;
                
                if (cryptor.isFinished) {
                    [writeStream close];
                    // call my delegate that I'm finished with decrypting
                    if (handler) {
                        handler(YES);
                    }
                }
                if(cryptor.error){
                    cnryptionError = cryptor.error;
                    [writeStream close];
                    [readStream close];
                    if (handler) {
                        handler(NO);
                    }
                }
            }
        }];
        
        while (readStream.hasBytesAvailable) {
            @autoreleasepool {
                uint8_t buf[blockSize];
                NSUInteger bytesRead = [readStream read:buf maxLength:blockSize];
                if(bytesRead == 0){
                    [readStream close];
                    [decryptor finish];
                }
                else if (bytesRead > 0) {
                    NSData *data = [NSData dataWithBytes:buf length:bytesRead];
                    totalWritenLength += bytesRead;
                    [decryptor addData:data];
                    //NSLog(@"New bytes to decryptor: %d Total: %d", bytesRead, total);
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [((File*)self.file) calculateProgressWithTotalReadWrite:totalWritenLength totalDataLength:readFileTotalBytes progress:prog];
                    });
                    
                }else{
                    NSLog(@"Error Has Occoured In DNFile.secureWrite(from:bufferSize:password:completionHandler:) method.");
                    if (handler){
                        handler(NO);
                    }
                }
            }
        }
    });
}

- (void)encryptFrom:(id<IFile>)readfile bufferSize:(int)size password:(NSString *)key progress:(id<IFileProgress>)prog completionHandler:(void (^)(BOOL))handler{
    //
    if ([self.file fileExist]) {
        NSLog(@"secureWriteFrom Existing file Deleted %@",([self.file delete]?@"YES":@"NO"));
    }
    
    if (size < 1024){
        size = 1024;
    }
    int blockSize = 32 * size;
    
    NSInputStream *readStream = [[NSInputStream alloc] initWithFileAtPath:[readfile.URL path]];
    __block NSOutputStream *writeStream = [[NSOutputStream alloc] initToFileAtPath:[self.file.URL path] append:NO];
    __block NSError *cnryptionError = nil;
    __block RNEncryptor *encryptor = nil;
    __block int totalWritenLength = 0;
    __block long long readFileTotalBytes = readfile.sizeInBytes;
    
    [readStream open];
    [writeStream open];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        encryptor = [RNCryptorHelper encryptorWithKey:key handler:^(RNCryptor *cryptor, NSData *data) {
            @autoreleasepool {
                //NSLog(@"Decryptor recevied %d bytes", data.length);
                [writeStream write:data.bytes maxLength:data.length];
                dispatch_semaphore_signal(semaphore);
                data = nil;
                
                if (cryptor.isFinished) {
                    [writeStream close];
                    // call my delegate that I'm finished with decrypting
                    if (handler) {
                        handler(YES);
                    }
                }
                if(cryptor.error){
                    cnryptionError = cryptor.error;
                    [writeStream close];
                    [readStream close];
                    if (handler) {
                        handler(NO);
                    }
                }
            }
        }];
        
        while (readStream.hasBytesAvailable) {
            @autoreleasepool {
                uint8_t buf[blockSize];
                NSUInteger bytesRead = [readStream read:buf maxLength:blockSize];
                if(bytesRead == 0){
                    [readStream close];
                    [encryptor finish];
                }
                else if (bytesRead > 0) {
                    NSData *data = [NSData dataWithBytes:buf length:bytesRead];
                    totalWritenLength += bytesRead;
                    [encryptor addData:data];
                    //NSLog(@"New bytes to decryptor: %d Total: %d", bytesRead, total);
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [((File*)self.file) calculateProgressWithTotalReadWrite:totalWritenLength totalDataLength:readFileTotalBytes progress:prog];
                    });
                    
                }else{
                    NSLog(@"Error Has Occoured In DNFile.secureWrite(from:bufferSize:password:completionHandler:) method.");
                    if (handler){
                        handler(NO);
                    }
                }
            }
        }
    });
}

- (void)encrypt:(NSString *)key bufferSize:(int)size progress:(id<IFileProgress>)prog completionHandler:(void (^)(NSData *))handler{
    if (size < 1024){
        size = 1024;
    }
    int blockSize = 32 * size;
    
    NSInputStream *readStream = [[NSInputStream alloc] initWithFileAtPath:[self.file.URL path]];
    __block NSMutableData *writeStream = [[NSMutableData alloc] init];
    __block NSError *cnryptionError = nil;
    __block RNEncryptor *encryptor = nil;
    __block int totalWritenLength = 0;
    __block long long readFileTotalBytes = self.file.sizeInBytes;
    
    [readStream open];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        encryptor = [RNCryptorHelper encryptorWithKey:key handler:^(RNCryptor *cryptor, NSData *data) {
            @autoreleasepool {
                //NSLog(@"Decryptor recevied %d bytes", data.length);
                [writeStream appendBytes:data.bytes length:data.length];
                dispatch_semaphore_signal(semaphore);
                data = nil;
                
                if (cryptor.isFinished) {
                    // call my delegate that I'm finished with decrypting
                    if (handler) {
                        handler(writeStream);
                    }
                }
                if(cryptor.error){
                    cnryptionError = cryptor.error;
                    [readStream close];
                    if (handler) {
                        handler(nil);
                    }
                }
            }
        }];
        
        while (readStream.hasBytesAvailable) {
            @autoreleasepool {
                uint8_t buf[blockSize];
                NSUInteger bytesRead = [readStream read:buf maxLength:blockSize];
                if(bytesRead == 0){
                    [readStream close];
                    [encryptor finish];
                }
                else if (bytesRead > 0) {
                    NSData *data = [NSData dataWithBytes:buf length:bytesRead];
                    totalWritenLength += bytesRead;
                    [encryptor addData:data];
                    //NSLog(@"New bytes to decryptor: %d Total: %d", bytesRead, total);
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [((File*)self.file) calculateProgressWithTotalReadWrite:totalWritenLength totalDataLength:readFileTotalBytes progress:prog];
                    });
                    
                }else{
                    NSLog(@"Error Has Occoured In DNFile.secureWrite(from:bufferSize:password:completionHandler:) method.");
                    if (handler){
                        handler(nil);
                    }
                }
            }
        }
    });
}

#pragma IFile interfaces

- (id<IDocumentMetadata>)metadata{
    return self.file.metadata;
}

- (NSString *)name{
    return self.file.name;
}

- (NSURL *)URL{
    return self.file.URL;
}

- (BOOL)isFile{
    return self.file.isFile;
}

- (BOOL)fileExist{
    return [self.file fileExist];
}

- (NSString *)mimeType{
    return self.file.mimeType;
}

- (double)sizeInBytes{
    return self.file.sizeInBytes;
}

- (double)sizeInKBytes{
    return self.file.sizeInKBytes;
}

- (double)sizeInMBytes{
    return self.file.sizeInMBytes;
}

- (double)sizeInGBytes{
    return self.file.sizeInGBytes;
}

- (NSData *)read{
    return [self.file read];
}

- (BOOL)write:(NSData *)data{
    return [self.file write:data];
}

- (BOOL)writeFrom:(id<IFile>)readfile bufferSize:(NSInteger)bufferSize progress:(id<IFileProgress>)progress{
    return [self.file writeFrom:readfile bufferSize:bufferSize progress:progress];
}

- (void)writeAsynchTo:(id<IFile>)file bufferSize:(NSInteger)bufferSize progress:(id<IFileProgress>)progress completionHandler:(void (^)(BOOL))completionHandler{
    [self.file writeAsynchTo:file bufferSize:bufferSize progress:progress completionHandler:completionHandler];
}

- (void)writeAsynchFrom:(id<IFile>)readfile bufferSize:(NSInteger)bufferSize progress:(id<IFileProgress>)progress completionHandler:(void (^)(BOOL))completionHandler{
    [self.file writeAsynchFrom:readfile bufferSize:bufferSize progress:progress completionHandler:completionHandler];
}

- (BOOL)delete{
    return [self.file delete];
}

- (BOOL)rename:(NSString *)rename{
    return [self.file rename:rename];
}

@end
