@class EAGLView;

@interface aurioTouchAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow       *window;
	IBOutlet EAGLView       *view;
}

@property (nonatomic, retain)	UIWindow        *window;
@property (nonatomic, retain)	EAGLView        *view;

@end
