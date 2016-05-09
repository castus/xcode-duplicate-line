#import "DuplicateLine.h"

@interface DuplicateLine()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, assign) NSRange selectedLineRange;
@property (nonatomic, strong) NSTextView *textView;
@end

@implementation DuplicateLine

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    // RemoveObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Add observer for selection
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectionDidChange:)
                                                 name:NSTextViewDidChangeSelectionNotification
                                               object:nil];
    
    [self addMenuItem];
}

- (void)addMenuItem
{
    NSMenuItem *editMenuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (editMenuItem) {
        [[editMenuItem submenu] addItem:[NSMenuItem separatorItem]];
        
        NSMenuItem *newMenuItem = [[NSMenuItem alloc] initWithTitle:@"Duplicate Line"
                                                             action:@selector(duplicateLine:)
                                                      keyEquivalent:@"d"];
        
        [newMenuItem setTarget:self];
        [newMenuItem setKeyEquivalentModifierMask:NSControlKeyMask|NSShiftKeyMask];
        [[editMenuItem submenu] addItem:newMenuItem];
    }
}

- (void)selectionDidChange:(NSNotification *)notification
{
    if ([[notification object] isKindOfClass:[NSTextView class]]) {
        
        self.textView = (NSTextView *)[notification object];
        
        NSArray *selectedRanges = [self.textView selectedRanges];
        if (selectedRanges.count == 0) {
            return;
        }
        
        NSRange selectedRange = [[selectedRanges objectAtIndex:0] rangeValue];
        self.selectedLineRange = [self.textView.textStorage.string lineRangeForRange:selectedRange];
    }
}

- (void)duplicateLine:(id)sender
{
    NSString *duplicatedText = [self.textView.textStorage.string substringWithRange:self.selectedLineRange];
    NSString *duplicatedString = [NSString stringWithFormat:@"%@%@", duplicatedText, duplicatedText];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:duplicatedString];
    
    if ([self.textView shouldChangeTextInRange:self.selectedLineRange replacementString:duplicatedString]) {
        [self.textView.textStorage replaceCharactersInRange:self.selectedLineRange
                                       withAttributedString:attributedString
         ];
        [self.textView didChangeText];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
