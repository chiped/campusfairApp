#define NAME_MULTIPLIER 0.2382
#define PHONE_WIDTH 100
#define MAJOR_MULTIPLIER 0.1627
#define MINOR_MULTIPLIER 0.1302
#define SUBSCRIBE_WIDTH 80

#import <MessageUI/MessageUI.h>
#import "StudentDataViewController.h"
#import "Student.h"
#import "StudentCellTableViewCell.h"

@interface StudentDataViewController ()

@property (weak, nonatomic) IBOutlet UITableView *studentTableView;
@property (strong, nonatomic) NSArray *students;

@end

@implementation StudentDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingString:@"/"];
    NSString *fileName = @"exportedData.csv";
    NSString *absolutePath = [documentsDirectory stringByAppendingString:fileName];

    self.students = [Student studentsFromFile:absolutePath];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(CGFloat) heightByAdjustingString:(NSString *)string toWidth:(CGFloat)width
{
    CGRect size = [string
                   boundingRectWithSize:CGSizeMake(width, 999)
                   options:NSStringDrawingUsesLineFragmentOrigin
                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f]}
                   context:nil];
    return size.size.height;
}

- (IBAction)onCLickEmail:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingString:@"/"];
    NSString *fileName = @"exportedData.csv";
    NSString *absolutePath = [documentsDirectory stringByAppendingString:fileName];
    NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath: absolutePath];
    
    if(file == nil) {
        NSLog(@"File doesnt exist");
        return;
    }
    
    [self showEmail:fileName atPath:absolutePath];
}

- (void)showEmail:(NSString*)file atPath:(NSString *)filePath
{
    
    NSString *emailTitle = @"Student data";
    NSString *messageBody = @"UD career fair student data attached";
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    NSArray *filepart = [file componentsSeparatedByString:@"."];
    NSString *filename = [filepart objectAtIndex:0];
    NSString *extension = [filepart objectAtIndex:1];
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSString *mimeType;
    if ([extension isEqualToString:@"csv"]) {
        mimeType = @"text/csv";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }
    
    [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];
    
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - UITableView methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.students.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentCellTableViewCell *studentCell = (StudentCellTableViewCell*)cell;
    studentCell.labelName.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
    studentCell.labelEmail.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
    studentCell.labelPhone.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
    studentCell.labelMajor.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
    studentCell.labelMinor.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
    studentCell.labelSubscribe.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell"];
    cell.labelName.text= nil;
    cell.labelEmail.text= nil;
    cell.labelPhone.text = nil;
    cell.labelMajor.text = nil;
    cell.labelMinor.text = nil;
    cell.labelSubscribe.text = nil;
    
    cell.labelName.text = [NSString stringWithFormat:@"%@ %@", ((Student*)self.students[indexPath.row]).firstName ,((Student*)self.students[indexPath.row]).lastName];
    cell.labelEmail.text = ((Student*)self.students[indexPath.row]).email;
    cell.labelPhone.text = ((Student*)self.students[indexPath.row]).phone;
    cell.labelMajor.text = ((Student*)self.students[indexPath.row]).major;
    cell.labelMinor.text = ((Student*)self.students[indexPath.row]).minor;
    cell.labelSubscribe.text = ((Student*)self.students[indexPath.row]).subscribe;
    [cell fitAllLabelsForCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *heights = [[NSMutableArray alloc ]init];
    CGFloat deviceWidth = self.studentTableView.frame.size.width;
    NSString *name = [NSString stringWithFormat:@"%@ %@", ((Student*)self.students[indexPath.row]).firstName ,((Student*)self.students[indexPath.row]).lastName];
    [heights addObject:[NSNumber numberWithFloat:[self heightByAdjustingString:name toWidth:deviceWidth*NAME_MULTIPLIER]] ];
    [heights addObject:[NSNumber numberWithFloat:[self heightByAdjustingString:((Student*)self.students[indexPath.row]).phone toWidth:PHONE_WIDTH]] ];
    [heights addObject:[NSNumber numberWithFloat:[self heightByAdjustingString:((Student*)self.students[indexPath.row]).major toWidth:deviceWidth* MAJOR_MULTIPLIER]] ];
    [heights addObject:[NSNumber numberWithFloat:[self heightByAdjustingString:((Student*)self.students[indexPath.row]).minor toWidth:deviceWidth * MINOR_MULTIPLIER]] ];
    [heights addObject:[NSNumber numberWithFloat:[self heightByAdjustingString:((Student*)self.students[indexPath.row]).subscribe toWidth:SUBSCRIBE_WIDTH]] ];
    float widthLeftForEmail = deviceWidth-16-5*8- deviceWidth*NAME_MULTIPLIER - PHONE_WIDTH - deviceWidth*MAJOR_MULTIPLIER - deviceWidth*MINOR_MULTIPLIER - SUBSCRIBE_WIDTH;
    [heights addObject:[NSNumber numberWithFloat:[self heightByAdjustingString:((Student*)self.students[indexPath.row]).email toWidth:widthLeftForEmail] ]];
    
    float max = [[heights valueForKeyPath:@"@max.self"] floatValue];
    
    return max + 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float width = tableView.frame.size.width;
    int xVal = 8;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 18)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(xVal, 5, width*NAME_MULTIPLIER, 18)];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [nameLabel setText:@"Name"];
    [view addSubview:nameLabel];
    xVal += width*NAME_MULTIPLIER + 8;
    
    float emailWidth = width - 16-5*8- width*NAME_MULTIPLIER - PHONE_WIDTH - width*MAJOR_MULTIPLIER - width*MINOR_MULTIPLIER - SUBSCRIBE_WIDTH;;
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(xVal, 5, emailWidth, 18)];
    [emailLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [emailLabel setText:@"Email"];
    [view addSubview:emailLabel];
    xVal += emailWidth + 8;
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(xVal, 5, PHONE_WIDTH, 18)];
    [phoneLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [phoneLabel setText:@"Phone"];
    [view addSubview:phoneLabel];
    xVal += PHONE_WIDTH + 8;
    
    UILabel *majorLabel = [[UILabel alloc] initWithFrame:CGRectMake(xVal, 5, width*MAJOR_MULTIPLIER, 18)];
    [majorLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [majorLabel setText:@"Major"];
    [view addSubview:majorLabel];
    xVal += width*MAJOR_MULTIPLIER + 8;
    
    UILabel *minorLabel = [[UILabel alloc] initWithFrame:CGRectMake(xVal, 5, width*MINOR_MULTIPLIER, 18)];
    [minorLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [minorLabel setText:@"Minor"];
    [view addSubview:minorLabel];
    xVal += width*MINOR_MULTIPLIER + 8;
    
    UILabel *subscribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(xVal, 5, SUBSCRIBE_WIDTH, 18)];
    [subscribeLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [subscribeLabel setText:@"Subscribe"];
    [view addSubview:subscribeLabel];
    
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    return view;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.studentTableView reloadData];
}

@end
