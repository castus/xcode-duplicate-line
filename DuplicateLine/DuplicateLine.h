#import <AppKit/AppKit.h>

@class DuplicateLine;

static DuplicateLine *sharedPlugin;

@interface DuplicateLine : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end