
#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingTableView.h"
@interface ColorsTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@end
