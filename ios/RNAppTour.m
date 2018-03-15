#import "RNAppTour.h"
#import <React/RCTEventDispatcher.h>

NSString *const onStartShowStepEvent = @"onStartShowCaseEvent";
NSString *const onShowSequenceStepEvent = @"onShowSequenceStepEvent";
NSString *const onFinishShowStepEvent = @"onFinishSequenceEvent";

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
    NSLog(@"");
    
    NSArray *targetKeys = [targets allKeys];
    if (targetKeys.count <= 0) {
        return;
    }
    
    NSString *removeTargetKey = [targetKeys objectAtIndex: 0];
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
    
    NSString *primaryText = [props objectForKey: @"primaryText"];
    NSString *secondaryText = [props objectForKey: @"secondaryText"];
    
    // Background
    UIColor *backgroundPromptColor;
    NSString *backgroundPromptColorValue = [props objectForKey:@"backgroundPromptColor"];
    if (backgroundPromptColorValue != nil) {
        backgroundPromptColor = [UIColor fromHexWithHexString: backgroundPromptColorValue];
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
    UIColor *targetTintColor;
    UIColor *targetHolderColor;
    NSString *targetTintColorValue = [props objectForKey:@"targetTintColor"];
    if (targetTintColorValue != nil) {
        targetTintColor = [UIColor fromHexWithHexString: targetTintColorValue];
    }
    NSString *targetHolderColorValue = [props objectForKey:@"targetHolderColor"];
    if (targetHolderColorValue != nil) {
        targetHolderColor = [UIColor fromHexWithHexString: targetHolderColorValue];
    }
    
    
    if (targetTintColor != nil) {
        target.tintColor = targetTintColor;
        [materialShowcase setTargetTintColor: targetTintColor];
    } if (targetHolderColor != nil) {
        [materialShowcase setTargetHolderColor: targetHolderColor];
    }
    
    if ([props objectForKey:@"targetHolderRadius"] != nil) {
        float targetHolderRadiusValue = [[props objectForKey:@"targetHolderRadius"] floatValue];
        if (targetHolderRadiusValue >= 0) {
            [materialShowcase setTargetHolderRadius: targetHolderRadiusValue];
        }
    }
    
    BOOL *isTapRecognizerForTagretViewValue = [[props objectForKey:@"isTapRecognizerForTagretView"] boolValue];
    if (isTapRecognizerForTagretViewValue == TRUE) {
        [materialShowcase setIsTapRecognizerForTagretView:TRUE];
    }
    
    // Text
    UIColor *primaryTextColor;
    UIColor *secondaryTextColor;
    //    showcase.primaryTextFont = UIFont.boldSystemFont(ofSize: primaryTextSize)
    //    showcase.secondaryTextFont = UIFont.systemFont(ofSize: secondaryTextSize)
    
    NSString *primaryTextColorValue = [props objectForKey:@"primaryTextColor"];
    if (primaryTextColorValue != nil) {
        primaryTextColor = [UIColor fromHexWithHexString: primaryTextColorValue];
    }
    
    NSString *secondaryTextColorValue = [props objectForKey:@"secondaryTextColor"];
    if (secondaryTextColorValue != nil) {
        secondaryTextColor = [UIColor fromHexWithHexString: secondaryTextColorValue];
    }
    
    [materialShowcase setPrimaryText: primaryText];
    [materialShowcase setSecondaryText: secondaryText];
    
    if (primaryTextColor != nil) {
        [materialShowcase setPrimaryTextColor: primaryTextColor];
    } if (secondaryTextColor != nil) {
        [materialShowcase setSecondaryTextColor: secondaryTextColor];
    }
    
    float primaryTextSizeValue = [[props objectForKey:@"primaryTextSize"] floatValue];
    float secondaryTextSizeValue = [[props objectForKey:@"secondaryTextSize"] floatValue];
    if (primaryTextSizeValue > 0) {
        [materialShowcase setPrimaryTextSize: primaryTextSizeValue];
    } if (secondaryTextSizeValue > 0) {
        [materialShowcase setSecondaryTextSize: secondaryTextSizeValue];
    }
    
    NSString *primaryTextAlignmentValue = [props objectForKey:@"primaryTextAlignment"];
    NSString *secondaryTextAlignmentValue = [props objectForKey:@"secondaryTextAlignment"];
    if (primaryTextAlignmentValue != nil) {
        NSTextAlignment* primaryTextAlign = [self getTextAlignmentByString:primaryTextAlignmentValue];
        [materialShowcase setSecondaryTextAlignment: primaryTextAlign];
    } if (secondaryTextAlignmentValue != nil) {
        NSTextAlignment* secondaryTextAlign = [self getTextAlignmentByString:secondaryTextAlignmentValue];
        [materialShowcase setSecondaryTextAlignment: secondaryTextAlign];
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
        aniRippleColor = [UIColor fromHexWithHexString: aniRippleColorValue];
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
    
    [materialShowcase setTargetViewWithView: target];
    [materialShowcase setDelegate: self];
    
    return materialShowcase;
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

@end

