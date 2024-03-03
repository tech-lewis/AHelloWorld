
#import <Foundation/Foundation.h>
#import "MacroUtils.h"
@interface SystemSoundIDPlayer : NSObject

singleton_interface(SystemSoundIDPlayer)

- (void)vibrate;
- (void)play;
- (void)playIndex:(int)index;

@end
