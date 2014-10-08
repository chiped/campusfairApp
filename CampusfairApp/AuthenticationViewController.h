@protocol AuthenticationDelegate <NSObject>

@required
-(void)authenticate:(bool)success;

@end

@interface AuthenticationViewController : UIViewController

@property(weak, nonatomic) id<AuthenticationDelegate> delegate;

@end
