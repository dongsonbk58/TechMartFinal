#import <Foundation/Foundation.h>
#import "UIFont+Alignment.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSHashTable *adjustedFontsList;

@implementation UIFont (Alignment)

static id (*_method_invoke_void)(id, Method, ...) = (id (*)(id, Method, ...)) method_invoke;

- (void)ensureCorrectFontAlignment {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        adjustedFontsList = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    });
    
    @synchronized (adjustedFontsList) {
        
        if ([adjustedFontsList containsObject:self]) {
            return;
        }
        else if ([self.fontName containsString:@"HiraKakuProN"] ||
                 [self.fontName containsString:@"HiraKakuPro"] ||
                 [self.fontName containsString:@"HiraginoSans"]) {
            SEL originalLineHeightSelector = @selector(lineHeight);
            Method originalLineHeightMethod = class_getInstanceMethod([UIFont class], originalLineHeightSelector);

            id resultLineHeight = _method_invoke_void(self, originalLineHeightMethod, nil);
            CGFloat originalLineHeightValue = [[resultLineHeight valueForKey:@"lineHeight"] floatValue];
            [resultLineHeight setValue:@(originalLineHeightValue * 1.25) forKey:@"lineHeight"];

            [adjustedFontsList addObject:self];
        }
    }

}

+ (void)resetFontAlignment {
    [adjustedFontsList removeAllObjects];
}

@end
