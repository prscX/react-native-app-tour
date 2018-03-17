
#import <React/RCTUIManager.h>
#import "MaterialShowcase/MaterialShowcase-Swift.h"

@interface MutableOrderedDictionary<__covariant KeyType, __covariant ObjectType> : NSDictionary<KeyType, ObjectType>
@end

@interface RNAppTour : NSObject<RCTBridgeModule> {
    MutableOrderedDictionary *targets;
}

@property (nonatomic, weak) id <MaterialShowcaseDelegate> delegate;

@end
