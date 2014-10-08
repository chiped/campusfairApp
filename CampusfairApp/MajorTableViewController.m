int selectedIndex = -1;

#import "MajorTableViewController.h"

@interface MajorTableViewController () 

@property (nonatomic, strong) NSArray *majorArray;

@end

@implementation MajorTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"majorList" ofType:@"plist"];
    self.majorArray = [NSArray arrayWithContentsOfFile:plistPath];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:21],
      NSFontAttributeName, nil]];
}

+ (void)resetSelection
{
    selectedIndex = -1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.majorArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MajorCell" forIndexPath:indexPath];
    cell.textLabel.text = self.majorArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
    cell.textLabel.textColor = [UIColor blackColor];
    if(selectedIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = cell.tintColor;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.textColor = cell.tintColor;
    if(selectedIndex != -1 && selectedIndex != indexPath.row) {
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:selectedIndex inSection:0]];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        oldCell.textLabel.textColor = [UIColor blackColor];
    }
    selectedIndex = indexPath.row;
    if(self.delegate) {
        [self.delegate selectedMajor:self.majorArray[indexPath.row]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
