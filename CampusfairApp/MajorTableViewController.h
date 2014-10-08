@protocol MajorPickerDelegate <NSObject>

@required
-(void)selectedMajor:(NSString *)newMajor;

@end

@interface MajorTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(weak, nonatomic) id<MajorPickerDelegate> delegate;

+(void)resetSelection;

@end
