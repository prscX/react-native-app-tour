
#import <React/RCTUIManager.h>
#import "MaterialShowcase/MaterialShowcase-Swift.h"

@interface MutableOrderedDictionary<__covariant KeyType, __covariant ObjectType> : NSDictionary<KeyType, ObjectType>
@end

@interface RNAppTour : NSObject<RCTBridgeModule, MaterialShowcaseDelegate> {
    MutableOrderedDictionary *targets;
    UIColor *targetOriginalColor;
}

@property (nonatomic, weak) id <MaterialShowcaseDelegate> delegate;

@end
