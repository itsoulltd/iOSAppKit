// Generated by Apple Swift version 4.0.3 (swiftlang-900.0.74.1 clang-900.0.39.2)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_attribute(external_source_symbol)
# define SWIFT_STRINGIFY(str) #str
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name) _Pragma(SWIFT_STRINGIFY(clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in=module_name, generated_declaration))), apply_to=any(function, enum, objc_interface, objc_category, objc_protocol))))
# define SWIFT_MODULE_NAMESPACE_POP _Pragma("clang attribute pop")
#else
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name)
# define SWIFT_MODULE_NAMESPACE_POP
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR __attribute__((enum_extensibility(open)))
# else
#  define SWIFT_ENUM_ATTR
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import ObjectiveC;
@import CoreDataStack;
@import Foundation;
@import UIKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

SWIFT_MODULE_NAMESPACE_PUSH("FileSystemSDK")

SWIFT_CLASS_NAMED("DiskUtility")
@interface DiskUtility : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class NSDictionary;
@class NSString;

SWIFT_PROTOCOL_NAMED("IDocumentMetadata")
@protocol IDocumentMetadata <NSObject>
@property (nonatomic, readonly, copy) NSURL * _Nonnull documentUrl;
@property (nonatomic, readonly, copy) NSString * _Nonnull documentName;
- (NSDictionary * _Nullable)getAttributes SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nullable)modifiedDate SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nullable)creationDate SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nullable)documentType SWIFT_WARN_UNUSED_RESULT;
@end

@class NSCoder;

SWIFT_CLASS_NAMED("DocumentMetadata")
@interface DocumentMetadata : NGObject <IDocumentMetadata>
@property (nonatomic, readonly, copy) NSURL * _Nonnull documentUrl;
@property (nonatomic, readonly, copy) NSString * _Nonnull documentName;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (NSDictionary * _Nullable)getAttributes SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nullable)modifiedDate SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nullable)creationDate SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nullable)documentType SWIFT_WARN_UNUSED_RESULT;
- (void)updateValue:(id _Null_unspecified)value forKey:(NSString * _Null_unspecified)key;
- (id _Null_unspecified)serializeValue:(id _Null_unspecified)value forKey:(NSString * _Null_unspecified)key SWIFT_WARN_UNUSED_RESULT;
- (null_unspecified instancetype)initWithInfo:(NSDictionary * _Null_unspecified)info SWIFT_UNAVAILABLE;
- (null_unspecified instancetype)initWithJSON:(NSData * _Null_unspecified)json SWIFT_UNAVAILABLE;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class UIView;

SWIFT_PROTOCOL("_TtP13FileSystemSDK14ExportProtocol_")
@protocol ExportProtocol <NSObject>
- (void)handleDocumentExport:(NSURL * _Nonnull)documentUrl docUTI:(NSString * _Nonnull)docUTI presentOnView:(UIView * _Nonnull)presentOnView;
@end

@class UIDocumentInteractionController;

SWIFT_CLASS_NAMED("ExportWizard")
@interface ExportWizard : NSObject <ExportProtocol, UIDocumentInteractionControllerDelegate>
- (void)handleDocumentExport:(NSURL * _Nonnull)documentUrl docUTI:(NSString * _Nonnull)docUTI presentOnView:(UIView * _Nonnull)presentOnView;
- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController * _Nonnull)controller;
- (void)documentInteractionController:(UIDocumentInteractionController * _Nonnull)controller willBeginSendingToApplication:(NSString * _Nullable)application;
- (void)documentInteractionController:(UIDocumentInteractionController * _Nonnull)controller didEndSendingToApplication:(NSString * _Nullable)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@protocol IFileProgress;

SWIFT_PROTOCOL_NAMED("IFile")
@protocol IFile <NSObject>
@property (nonatomic, readonly, strong) id <IDocumentMetadata> _Nonnull metadata;
@property (nonatomic, readonly, copy) NSString * _Nonnull name;
@property (nonatomic, readonly, copy) NSURL * _Nonnull URL;
- (BOOL)isFile SWIFT_WARN_UNUSED_RESULT;
- (BOOL)fileExist SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nonnull)mimeType SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, readonly) double sizeInBytes;
@property (nonatomic, readonly) double sizeInKBytes;
@property (nonatomic, readonly) double sizeInMBytes;
@property (nonatomic, readonly) double sizeInGBytes;
- (NSData * _Nullable)read SWIFT_WARN_UNUSED_RESULT;
- (BOOL)write:(NSData * _Nonnull)data SWIFT_WARN_UNUSED_RESULT;
- (BOOL)writeFrom:(id <IFile> _Nonnull)readfile bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress SWIFT_WARN_UNUSED_RESULT;
- (void)writeAsynchFrom:(id <IFile> _Nonnull)readfile bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress completionHandler:(void (^ _Nullable)(BOOL))completionHandler;
- (void)writeAsynchTo:(id <IFile> _Nonnull)file bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress completionHandler:(void (^ _Nullable)(BOOL))completionHandler;
- (BOOL)delete SWIFT_WARN_UNUSED_RESULT;
- (BOOL)rename:(NSString * _Nonnull)rename SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS_NAMED("File")
@interface File : NGObject <IFile>
@property (nonatomic, readonly, copy) NSURL * _Nonnull URL;
@property (nonatomic, readonly, copy) NSString * _Nonnull name;
@property (nonatomic, readonly) double sizeInBytes;
@property (nonatomic, readonly) double sizeInKBytes;
@property (nonatomic, readonly) double sizeInMBytes;
@property (nonatomic, readonly) double sizeInGBytes;
@property (nonatomic, readonly, strong) id <IDocumentMetadata> _Nonnull metadata;
- (nonnull instancetype)initWithUrl:(NSURL * _Nonnull)url OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (BOOL)fileExist SWIFT_WARN_UNUSED_RESULT;
- (BOOL)isFile SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nonnull)mimeType SWIFT_WARN_UNUSED_RESULT;
- (NSData * _Nullable)read SWIFT_WARN_UNUSED_RESULT;
- (BOOL)write:(NSData * _Nonnull)data SWIFT_WARN_UNUSED_RESULT;
- (void)calculateProgressWithTotalReadWrite:(NSInteger)rwBytes totalDataLength:(double)tdlBytes progress:(id <IFileProgress> _Nullable)progress;
- (BOOL)writeFrom:(id <IFile> _Nonnull)readfile bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress SWIFT_WARN_UNUSED_RESULT;
- (void)writeAsynchFrom:(id <IFile> _Nonnull)readfile bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress completionHandler:(void (^ _Nullable)(BOOL))completionHandler;
- (void)writeAsynchTo:(id <IFile> _Nonnull)file bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress completionHandler:(void (^ _Nullable)(BOOL))completionHandler;
- (BOOL)delete SWIFT_WARN_UNUSED_RESULT;
- (BOOL)rename:(NSString * _Nonnull)rename SWIFT_WARN_UNUSED_RESULT;
- (void)updateValue:(id _Null_unspecified)value forKey:(NSString * _Null_unspecified)key;
- (id _Null_unspecified)serializeValue:(id _Null_unspecified)value forKey:(NSString * _Null_unspecified)key SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Null_unspecified)updateDate:(NSString * _Null_unspecified)dateStr SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Null_unspecified)serializeDate:(NSDate * _Null_unspecified)date SWIFT_WARN_UNUSED_RESULT;
- (null_unspecified instancetype)initWithInfo:(NSDictionary * _Null_unspecified)info SWIFT_UNAVAILABLE;
- (null_unspecified instancetype)initWithJSON:(NSData * _Null_unspecified)json SWIFT_UNAVAILABLE;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_PROTOCOL_NAMED("ISecureFile")
@protocol ISecureFile <NSObject>
- (void)decryptedWithBufferSize:(NSInteger)size progress:(id <IFileProgress> _Nullable)progress decrypt:(NSData * _Nonnull (^ _Nullable)(NSData * _Nonnull))decrypt completionHandler:(void (^ _Nonnull)(NSData * _Nonnull))completionHandler;
- (void)encryptedWithBufferSize:(NSInteger)size progress:(id <IFileProgress> _Nullable)progress encrypt:(NSData * _Nonnull (^ _Nullable)(NSData * _Nonnull))encrypt completionHandler:(void (^ _Nonnull)(NSData * _Nonnull))completionHandler;
- (void)secureWriteFrom:(id <IFile> _Nonnull)readfile bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress encrypt:(NSData * _Nonnull (^ _Nullable)(NSData * _Nonnull))encrypt completionHandler:(void (^ _Nullable)(BOOL))completionHandler;
- (void)secureWriteTo:(id <IFile> _Nonnull)file bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress encrypt:(NSData * _Nonnull (^ _Nullable)(NSData * _Nonnull))encrypt completionHandler:(void (^ _Nullable)(BOOL))completionHandler;
@end


@interface File (SWIFT_EXTENSION(FileSystemSDK)) <ISecureFile>
- (void)decryptedWithBufferSize:(NSInteger)size progress:(id <IFileProgress> _Nullable)progress decrypt:(NSData * _Nonnull (^ _Nullable)(NSData * _Nonnull))decrypt completionHandler:(void (^ _Nonnull)(NSData * _Nonnull))completionHandler;
- (void)encryptedWithBufferSize:(NSInteger)size progress:(id <IFileProgress> _Nullable)progress encrypt:(NSData * _Nonnull (^ _Nullable)(NSData * _Nonnull))encrypt completionHandler:(void (^ _Nonnull)(NSData * _Nonnull))completionHandler;
- (void)secureWriteTo:(id <IFile> _Nonnull)file bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress encrypt:(NSData * _Nonnull (^ _Nullable)(NSData * _Nonnull))encrypt completionHandler:(void (^ _Nullable)(BOOL))completionHandler;
- (void)secureWriteFrom:(id <IFile> _Nonnull)readfile bufferSize:(NSInteger)bufferSize progress:(id <IFileProgress> _Nullable)progress encrypt:(NSData * _Nonnull (^ _Nullable)(NSData * _Nonnull))encrypt completionHandler:(void (^ _Nullable)(BOOL))completionHandler;
@end


SWIFT_PROTOCOL_NAMED("IFolder")
@protocol IFolder <NSObject>
@property (nonatomic, readonly, strong) id <IDocumentMetadata> _Nonnull metadata;
@property (nonatomic, readonly, copy) NSString * _Nonnull name;
@property (nonatomic, readonly, copy) NSURL * _Nonnull URL;
@property (nonatomic, readonly) double sizeInBytes;
@property (nonatomic, readonly) double sizeInKBytes;
@property (nonatomic, readonly) double sizeInMBytes;
@property (nonatomic, readonly) double sizeInGBytes;
- (double)calculateSize SWIFT_WARN_UNUSED_RESULT;
- (double)calculateFilesSize SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nullable)path SWIFT_WARN_UNUSED_RESULT;
- (BOOL)isFolder SWIFT_WARN_UNUSED_RESULT;
- (BOOL)exist SWIFT_WARN_UNUSED_RESULT;
- (id <IFolder> _Nonnull)addSubfolder:(NSString * _Nonnull)name SWIFT_WARN_UNUSED_RESULT;
- (id <IFolder> _Nonnull)subfolder:(NSString * _Nonnull)name SWIFT_WARN_UNUSED_RESULT;
- (BOOL)rename:(NSString * _Nonnull)name SWIFT_WARN_UNUSED_RESULT;
- (BOOL)delete SWIFT_WARN_UNUSED_RESULT;
- (id <IFolder> _Nullable)moveTo:(id <IFolder> _Nonnull)folder SWIFT_WARN_UNUSED_RESULT;
- (BOOL)copyFrom:(id <IFolder> _Nonnull)folder SWIFT_WARN_UNUSED_RESULT;
- (NSArray<id <IFolder>> * _Nonnull)searchfolders:(NSString * _Nullable)folderName SWIFT_WARN_UNUSED_RESULT;
- (NSArray<id <IFile>> * _Nonnull)searchfiles:(NSString * _Nullable)extention SWIFT_WARN_UNUSED_RESULT;
- (BOOL)moveIn:(id <IFile> _Nonnull)file replace:(BOOL)replace SWIFT_WARN_UNUSED_RESULT;
- (BOOL)copyOf:(id <IFile> _Nonnull)file replace:(BOOL)replace SWIFT_WARN_UNUSED_RESULT;
@end

@class NSFileManager;
@class NSNumber;

SWIFT_CLASS_NAMED("Folder")
@interface Folder : NSObject <IFolder, NSFileManagerDelegate>
- (nonnull instancetype)initWithName:(NSString * _Nullable)name searchDirectoryType:(NSSearchPathDirectory)searchDirectoryType OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, readonly, strong) id <IDocumentMetadata> _Nonnull metadata;
- (NSString * _Nullable)path SWIFT_WARN_UNUSED_RESULT;
- (BOOL)isFolder SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, readonly, copy) NSString * _Nonnull name;
@property (nonatomic, readonly, copy) NSURL * _Nonnull URL;
- (BOOL)exist SWIFT_WARN_UNUSED_RESULT;
- (id <IFolder> _Nonnull)addSubfolder:(NSString * _Nonnull)name SWIFT_WARN_UNUSED_RESULT;
- (BOOL)rename:(NSString * _Nonnull)name SWIFT_WARN_UNUSED_RESULT;
- (BOOL)delete SWIFT_WARN_UNUSED_RESULT;
- (BOOL)fileManager:(NSFileManager * _Nonnull)fileManager shouldProceedAfterError:(NSError * _Nonnull)error movingItemAtPath:(NSString * _Nonnull)srcPath toPath:(NSString * _Nonnull)dstPath SWIFT_WARN_UNUSED_RESULT;
- (id <IFolder> _Nullable)moveTo:(id <IFolder> _Nonnull)folder SWIFT_WARN_UNUSED_RESULT;
- (BOOL)fileManager:(NSFileManager * _Nonnull)fileManager shouldProceedAfterError:(NSError * _Nonnull)error copyingItemAtPath:(NSString * _Nonnull)srcPath toPath:(NSString * _Nonnull)dstPath SWIFT_WARN_UNUSED_RESULT;
- (BOOL)copyFrom:(id <IFolder> _Nonnull)folder SWIFT_WARN_UNUSED_RESULT;
- (id <IFolder> _Nonnull)subfolder:(NSString * _Nonnull)name SWIFT_WARN_UNUSED_RESULT;
- (NSArray<id <IFolder>> * _Nonnull)searchfolders:(NSString * _Nullable)folderName SWIFT_WARN_UNUSED_RESULT;
- (NSArray<id <IFile>> * _Nonnull)searchfiles:(NSString * _Nullable)extention SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nonnull)resolveChildNameWithName:(NSString * _Nonnull)oldName SWIFT_WARN_UNUSED_RESULT;
- (NSURL * _Nullable)saveAs:(NSString * _Nonnull)fileName data:(NSData * _Nonnull)data replace:(BOOL)replace SWIFT_WARN_UNUSED_RESULT;
- (NSURL * _Nullable)pasteContent:(id <IFile> _Nonnull)file replace:(BOOL)replace SWIFT_WARN_UNUSED_RESULT;
- (BOOL)moveIn:(id <IFile> _Nonnull)file replace:(BOOL)replace SWIFT_WARN_UNUSED_RESULT;
- (BOOL)copyOf:(id <IFile> _Nonnull)file replace:(BOOL)replace SWIFT_WARN_UNUSED_RESULT;
- (BOOL)isEqual:(id _Nullable)object SWIFT_WARN_UNUSED_RESULT;
- (BOOL)deleteContentByName:(NSString * _Nonnull)name SWIFT_WARN_UNUSED_RESULT;
- (BOOL)deleteContent:(id <IFile> _Nonnull)file SWIFT_WARN_UNUSED_RESULT;
- (double)calculateSize SWIFT_WARN_UNUSED_RESULT;
- (double)calculateFilesSize SWIFT_WARN_UNUSED_RESULT;
- (void)calculateSize:(void (^ _Nonnull)(NSNumber * _Nonnull))onCompletion;
@property (nonatomic, readonly) double sizeInBytes;
@property (nonatomic, readonly) double sizeInKBytes;
@property (nonatomic, readonly) double sizeInMBytes;
@property (nonatomic, readonly) double sizeInGBytes;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end




SWIFT_PROTOCOL_NAMED("IFileProgress")
@protocol IFileProgress <NSObject>
- (void)readWriteProgress:(double)progress;
@end



@class UIDocumentMenuViewController;
@class UIDocumentPickerViewController;

SWIFT_CLASS_NAMED("ImportWizard") SWIFT_AVAILABILITY(ios,introduced=8.0)
@interface ImportWizard : NSObject <UIDocumentMenuDelegate, UIDocumentPickerDelegate>
- (void)documentMenu:(UIDocumentMenuViewController * _Nonnull)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController * _Nonnull)documentPicker;
- (void)documentMenuWasCancelled:(UIDocumentMenuViewController * _Nonnull)documentMenu;
- (void)documentPicker:(UIDocumentPickerViewController * _Nonnull)controller didPickDocumentAtURL:(NSURL * _Nonnull)url;
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController * _Nonnull)controller;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class UIViewController;

SWIFT_PROTOCOL_NAMED("ImportWizardDelegate") SWIFT_AVAILABILITY(ios,introduced=8.0)
@protocol ImportWizardDelegate <NSObject>
- (UIViewController * _Nonnull)importWizardPresenterViewController:(ImportWizard * _Nonnull)wizard SWIFT_WARN_UNUSED_RESULT;
- (void)importWizard:(ImportWizard * _Nonnull)wizard didPickDocumentAtURL:(NSURL * _Nonnull)url;
@end


SWIFT_CLASS_NAMED("RemoteFile")
@interface RemoteFile : NGObject
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)updateValue:(id _Null_unspecified)value forKey:(NSString * _Null_unspecified)key;
- (id _Null_unspecified)serializeValue:(id _Null_unspecified)value forKey:(NSString * _Null_unspecified)key SWIFT_WARN_UNUSED_RESULT;
- (null_unspecified instancetype)initWithInfo:(NSDictionary * _Null_unspecified)info SWIFT_UNAVAILABLE;
- (null_unspecified instancetype)initWithJSON:(NSData * _Null_unspecified)json SWIFT_UNAVAILABLE;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class HttpWebRequest;

SWIFT_PROTOCOL_NAMED("RemoteFileDelegate")
@protocol RemoteFileDelegate
- (void)didFinishSynch:(HttpWebRequest * _Nonnull)request file:(id <IFile> _Nonnull)file;
@end

typedef SWIFT_ENUM_NAMED(NSInteger, SpaceIn, "SpaceIn") {
  SpaceInBytes = 0,
  SpaceInKb = 1,
  SpaceInMb = 2,
  SpaceInGb = 3,
  SpaceInTb = 4,
};

SWIFT_MODULE_NAMESPACE_POP
#pragma clang diagnostic pop
