#import "RNAppTour.h"
#import <React/RCTEventDispatcher.h>

NSString *const onStartShowStepEvent = @"onStartShowCaseEvent";
NSString *const onShowSequenceStepEvent = @"onShowSequenceStepEvent";
NSString *const onFinishShowStepEvent = @"onFinishSequenceEvent";
NSString *const onCancelSequenceStepEvent = @"onCancelStepEvent";

@implementation MutableOrderedDictionary {
@protected
    NSMutableArray *_values;
    NSMutableOrderedSet *_keys;
}

- (instancetype)init {
    if ((self = [super init])) {
        _values = NSMutableArray.new;
        _keys = NSMutableOrderedSet.new;
    }
    return self;
}

- (NSUInteger)count {
    return _keys.count;
}

- (NSEnumerator *)keyEnumerator {
    return _keys.objectEnumerator;
}

- (void)removeObjectForKey:(id)key {
    [_values removeObjectAtIndex:[_keys indexOfObject: key]];
    [_keys removeObject:key];
}

- (id)objectForKey:(id)key {
    NSUInteger index = [_keys indexOfObject:key];
    if (index != NSNotFound){
        return _values[index];
    }
    return nil;
}


- (void)setObject:(id)object forKey:(id)key {
    NSUInteger index = [_keys indexOfObject:key];
    if (index != NSNotFound) {
        _values[index] = object;
    } else {
        [_keys addObject:key];
        [_values addObject:object];
    }
}

@end

@implementation RNAppTour

@synthesize delegate;

@synthesize bridge = _bridge;

- (id)init {
    self = [super init];
    if (self) {
        targets = [[MutableOrderedDictionary alloc] init];
    }
    
    return self;
}


- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}


- (NSTextAlignment*) getTextAlignmentByString: (NSString*) strAlignment {
    if (strAlignment == nil) {
        return NSTextAlignmentLeft; // default is left
    }
    
    NSString *lowCaseString = [strAlignment lowercaseString];
    if ([lowCaseString isEqualToString:@"left"]) {
        return NSTextAlignmentLeft;
    } if ([lowCaseString isEqualToString:@"right"]) {
        return NSTextAlignmentRight;
    } if ([lowCaseString isEqualToString:@"center"]) {
        return NSTextAlignmentCenter;
    } if ([lowCaseString isEqualToString:@"justify"]) {
        return NSTextAlignmentJustified;
    }
    
    return NSTextAlignmentLeft;
}

- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

- (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
            case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
            case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
            case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
            case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(ShowSequence:(NSArray *)views props:(NSDictionary *)props)
{
    targets = [[MutableOrderedDictionary alloc] init];
    for (NSNumber *view in views) {
        [targets setObject:[props objectForKey: [view stringValue]] forKey: [view stringValue]];
    }
    
    NSString *showTargetKey = [ [targets allKeys] objectAtIndex: 0];
    [self ShowFor:[NSNumber numberWithLongLong:[showTargetKey longLongValue]] props:[targets objectForKey:showTargetKey] ];
}

- (void)showCaseWillDismissWithShowcase:(MaterialShowcase *)materialShowcase {
    NSLog(@"");
}
- (void)showCaseDidDismissWithShowcase:(MaterialShowcase *)materialShowcase {
    NSArray *targetKeys = [targets allKeys];
    if (targetKeys.count <= 0) {
        return;
    }
    
    NSString *removeTargetKey = [targetKeys objectAtIndex: 0];
    
    // This for revert background color of target
    if (materialShowcase.targetHolderRadius <= 0.0f && targetOriginalColor != nil) {
        NSLog(@"targetHolderRadius change");
        NSNumber *view =  [NSNumber numberWithLongLong:[removeTargetKey longLongValue]];
        UIView *target = [self.bridge.uiManager viewForReactTag: view];
        [target setBackgroundColor: targetOriginalColor];
    }
    
    [targets removeObjectForKey: removeTargetKey];
    
    NSMutableArray *viewIds = [[NSMutableArray alloc] init];
    NSMutableDictionary *props = [[NSMutableDictionary alloc] init];
    
    if (targetKeys.count <= 1) {
        [self.bridge.eventDispatcher sendDeviceEventWithName:onFinishShowStepEvent body:@{@"finish": @YES}];
    }
    else {
        [self.bridge.eventDispatcher sendDeviceEventWithName:onShowSequenceStepEvent body:@{@"next_step": @YES}];
    }
    
    for (NSString *view in [targets allKeys]) {
        [viewIds addObject: [NSNumber numberWithLongLong:[view longLongValue]]];
        [props setObject:(NSDictionary *)[targets objectForKey: view] forKey:view];
    }
    
    if ([viewIds count] > 0) {
        [self ShowSequence:viewIds props:props];
    }
}

- (void) showCaseSkippedWithShowcase: (MaterialShowcase *)materialShowcase {
    if (targets != nil) {
        targets = MutableOrderedDictionary.new;
    }
    [self.bridge.eventDispatcher sendDeviceEventWithName:onCancelSequenceStepEvent body:@{@"cancel_step": @YES}];
    [materialShowcase completeShowcaseWithAnimated: true];
}

RCT_EXPORT_METHOD(ShowFor:(nonnull NSNumber *)view props:(NSDictionary *)props)
{
    MaterialShowcase *materialShowcase = [self generateMaterialShowcase:view props:props];
    [materialShowcase showWithAnimated:true completion:^() {
        [self.bridge.eventDispatcher sendDeviceEventWithName:onStartShowStepEvent body:@{@"start_step": @YES}];
    }];
}

- (MaterialShowcase *)generateMaterialShowcase:(NSNumber *)view props:(NSDictionary *)props {
    
    MaterialShowcase *materialShowcase = [[MaterialShowcase alloc] init];
    UIView *target = [self.bridge.uiManager viewForReactTag: view];
    CGRect viewRect = target.frame;
    NSString *title = [props objectForKey: @"title"];
    NSString *description = [props objectForKey: @"description"];
    
    // Background
    UIColor *backgroundPromptColor;
    NSString *backgroundPromptColorValue = [props objectForKey:@"backgroundPromptColor"];
    if (backgroundPromptColorValue != nil) {
        backgroundPromptColor = [self colorWithHexString: backgroundPromptColorValue];
    }
    if (backgroundPromptColor != nil) {
        [materialShowcase setBackgroundColor: backgroundPromptColor];
    }
    
    if ([props objectForKey:@"backgroundPrompAlpha"] != nil) {
        float backgroundPrompAlphaValue = [[props objectForKey:@"backgroundPrompAlpha"] floatValue];
        if (backgroundPrompAlphaValue >= 0.0 && backgroundPrompAlphaValue <= 1.0) {
            [materialShowcase setBackgroundPromptColorAlpha:backgroundPrompAlphaValue];
        }
    }
    
    // Target
    UIColor *outerCircleColor;
    UIColor *targetCircleColor;
    NSString *outerCircleColorValue = [props objectForKey:@"outerCircleColor"];
    if (outerCircleColorValue != nil) {
        outerCircleColor = [self colorWithHexString: outerCircleColorValue];
    }
    NSString *targetCircleColorValue = [props objectForKey:@"targetCircleColor"];
    if (targetCircleColorValue != nil) {
        targetCircleColor = [self colorWithHexString: targetCircleColorValue];
    }
    
    
    if (outerCircleColor != nil) {
        target.tintColor = outerCircleColor;
        [materialShowcase setTargetTintColor: outerCircleColor];
    } if (targetCircleColor != nil) {
        [materialShowcase setTargetHolderColor: targetCircleColor];
    }
    
    if ([props objectForKey:@"targetRadius"] != nil) {
        float targetRadiusValue = [[props objectForKey:@"targetRadius"] floatValue];
        if (targetRadiusValue >= 0) {
            [materialShowcase setTargetHolderRadius: targetRadiusValue];
        }
    }
    
    if ([props objectForKey:@"cancelable"] != nil) {
        BOOL *cancelable = [[props objectForKey:@"cancelable"] boolValue];
        [materialShowcase setIsTapRecognizerForTagretView: !cancelable];
    }
    
    // Text
    UIColor *titleTextColor;
    UIColor *descriptionTextColor;
    
    NSString *titleTextColorValue = [props objectForKey:@"titleTextColor"];
    if (titleTextColorValue != nil) {
        titleTextColor = [self colorWithHexString:titleTextColorValue];
    }
    
    NSString *descriptionTextColorValue = [props objectForKey:@"descriptionTextColor"];
    if (descriptionTextColorValue != nil) {
        descriptionTextColor = [self colorWithHexString:descriptionTextColorValue];
    }
    
    [materialShowcase setPrimaryText: title];
    [materialShowcase setSecondaryText: description];
    
    if (titleTextColor != nil) {
        [materialShowcase setPrimaryTextColor: titleTextColor];
    } if (descriptionTextColor != nil) {
        [materialShowcase setSecondaryTextColor: descriptionTextColor];
    }
    
    float titleTextSizeValue = [[props objectForKey:@"titleTextSize"] floatValue];
    float descriptionTextSizeValue = [[props objectForKey:@"descriptionTextSize"] floatValue];
    if (titleTextSizeValue > 0) {
        [materialShowcase setPrimaryTextSize: titleTextSizeValue];
    } if (descriptionTextSizeValue > 0) {
        [materialShowcase setSecondaryTextSize: descriptionTextSizeValue];
    }
    
    NSString *titleTextAlignmentValue = [props objectForKey:@"titleTextAlignment"];
    NSString *descriptionTextAlignmentValue = [props objectForKey:@"descriptionTextAlignment"];
    if (titleTextAlignmentValue != nil) {
        NSTextAlignment* titleTextAlignment = [self getTextAlignmentByString:titleTextAlignmentValue];
        [materialShowcase setSecondaryTextAlignment: titleTextAlignment];
    } if (descriptionTextAlignmentValue != nil) {
        NSTextAlignment* descriptionTextAlignment = [self getTextAlignmentByString:descriptionTextAlignmentValue];
        [materialShowcase setSecondaryTextAlignment: descriptionTextAlignment];
    }
    
    // Animation
    float aniComeInDurationValue = [[props objectForKey:@"aniComeInDuration"] floatValue]; // second unit
    float aniGoOutDurationValue = [[props objectForKey:@"aniGoOutDuration"] floatValue]; // second unit
    if (aniGoOutDurationValue > 0) {
        [materialShowcase setAniComeInDuration: aniComeInDurationValue];
    } if (aniGoOutDurationValue > 0) {
        [materialShowcase setAniGoOutDuration: aniGoOutDurationValue];
    }
    
    UIColor *aniRippleColor;
    NSString *aniRippleColorValue = [props objectForKey:@"aniRippleColor"];
    if (aniRippleColorValue != nil) {
        aniRippleColor = [self colorWithHexString: aniRippleColorValue];
    } if (aniRippleColor != nil) {
        [materialShowcase setAniRippleColor: aniRippleColor];
    }
    
    
    if ([props objectForKey:@"aniRippleAlpha"] != nil) {
        float aniRippleAlphaValue = [[props objectForKey:@"aniRippleAlpha"] floatValue];
        if (aniRippleAlphaValue >= 0.0 && aniRippleAlphaValue <= 1.0) {
            [materialShowcase setAniRippleAlpha: aniRippleAlphaValue];
        }
    }
    
    float aniRippleScaleValue = [[props objectForKey:@"aniRippleScale"] floatValue];
    if (aniRippleScaleValue > 0) {
        [materialShowcase setAniRippleScale:aniRippleScaleValue];
    }
    
    // Skip button
    if ([props objectForKey:@"isSkipButtonVisible"] != nil && targets != nil && targets.count > 0) {
        bool *isSkipButtonVisible = [[props objectForKey:@"isSkipButtonVisible"] boolValue];
        [materialShowcase setIsSkipButtonVisible: isSkipButtonVisible];
        // Set skip button params
        UIColor *skipTextColor;
        NSString *skipTextValue = [props objectForKey:@"skipText"];
        NSString *skipTextColorValue = [props objectForKey:@"skipTextColor"];
        float skipTextSizeValue = [[props objectForKey:@"skipTextSize"] floatValue];
        UIColor *skipButtonBackgroundColor;
        NSString *skipButtonBackgroundColorValue = [props objectForKey:@"skipButtonBackgroundColor"];
        
        if (skipTextValue != nil) {
            [materialShowcase  setSkipText: skipTextValue];
        } if (skipTextColorValue != nil) {
            skipTextColor = [self colorWithHexString:skipTextColorValue];
        } if (skipTextColor) {
            [materialShowcase setSkipTextColor: skipTextColor];
        } if (skipTextSizeValue > 0) {
            [materialShowcase setSkipTextSize: skipTextSizeValue];
        } if (skipButtonBackgroundColorValue != nil) {
            skipButtonBackgroundColor = [self colorWithHexString: skipButtonBackgroundColorValue];
        } if (skipButtonBackgroundColor) {
            [materialShowcase setSkipButtonBackgroundColor: skipButtonBackgroundColor];
        }
        
        // skip button margin
        if ([props objectForKey:@"skipButtonMargin"] != nil) {
            float marginValue = [[props objectForKey:@"skipButtonMargin"] floatValue];
            [materialShowcase setSkipButtonMarginLeft: marginValue];
            [materialShowcase setSkipButtonMarginTop: marginValue];
            [materialShowcase setSkipButtonMarginRight: marginValue];
            [materialShowcase setSkipButtonMarginBottom: marginValue];
        }
        
        if ([props objectForKey:@"skipButtonMarginLeft"] != nil) {
            float skipButtonMarginLeftValue = [[props objectForKey:@"skipButtonMarginLeft"] floatValue];
            [materialShowcase setSkipButtonMarginLeft: skipButtonMarginLeftValue];
        } if ([props objectForKey:@"skipButtonMarginTop"] != nil) {
            float skipButtonMarginTopValue = [[props objectForKey:@"skipButtonMarginTop"] floatValue];
            [materialShowcase setSkipButtonMarginTop: skipButtonMarginTopValue];
        } if ([props objectForKey:@"skipButtonMarginRight"] != nil) {
            float skipButtonMarginRightValue = [[props objectForKey:@"skipButtonMarginRight"] floatValue];
            [materialShowcase setSkipButtonMarginRight: skipButtonMarginRightValue];
        } if ([props objectForKey:@"skipButtonMarginBottom"] != nil) {
            float skipButtonMarginBottomValue = [[props objectForKey:@"skipButtonMarginBottom"] floatValue];
            [materialShowcase setSkipButtonMarginLeft: skipButtonMarginBottomValue];
        }
        
        if ([props objectForKey:@"skipButtonMarginHorizontal"] != nil) {
            float skipButtonMarginHorizontalValue = [[props objectForKey:@"skipButtonMarginHorizontal"] floatValue];
            [materialShowcase setSkipButtonMarginLeft: skipButtonMarginHorizontalValue];
            [materialShowcase setSkipButtonMarginRight: skipButtonMarginHorizontalValue];
        } if ([props objectForKey:@"skipButtonMarginVertical"] != nil) {
            float skipButtonMarginVerticalValue = [[props objectForKey:@"skipButtonMarginVertical"] floatValue];
            [materialShowcase setSkipButtonMarginTop: skipButtonMarginVerticalValue];
            [materialShowcase setSkipButtonMarginBottom: skipButtonMarginVerticalValue];
        }
    }
    if ([[props objectForKey:@"isRect"] boolValue])
    {
        NSString *rectHighLightColorValue = [props objectForKey:@"rectHighLightColor"];
        if (rectHighLightColorValue != nil && targets != nil && targets.count > 0) {
            // save target original color for reversing
            targetOriginalColor = target.backgroundColor;
            
            // set target background color
            UIColor *targetHighLightColor = [self colorWithHexString:rectHighLightColorValue];
            if (targetHighLightColor != nil) {
                [target setBackgroundColor: targetHighLightColor];
            }
        }
        // we should remove circle
        [materialShowcase setTargetHolderRadius: 0];
    }
    else {
        targetOriginalColor = nil;
    }
    
    [materialShowcase setTargetViewWithView: target];
    
    [materialShowcase setDelegate: self];
    
    return materialShowcase;
}


@end

