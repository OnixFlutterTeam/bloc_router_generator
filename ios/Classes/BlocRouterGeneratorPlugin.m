#import "BlocRouterGeneratorPlugin.h"
#if __has_include(<bloc_router_generator/bloc_router_generator-Swift.h>)
#import <bloc_router_generator/bloc_router_generator-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bloc_router_generator-Swift.h"
#endif

@implementation BlocRouterGeneratorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBlocRouterGeneratorPlugin registerWithRegistrar:registrar];
}
@end
