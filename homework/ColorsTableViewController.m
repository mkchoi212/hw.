
#import "ColorsTableViewController.h"
#import "BigColorTableViewCell.h"
#import "UIColor+FlatColors.h"
#import "JVFloatLabeledTextField.h"

@interface ColorsTableViewController ()

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSMutableDictionary *selectedIndexes;


- (BOOL)cellIsSelected:(NSIndexPath *)indexPath;

@end

@implementation ColorsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureColors];
    self.selectedIndexes = [[NSMutableDictionary alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
}

- (void)configureColors{
    self.colors = [[NSArray alloc] initWithObjects:
                    @"Turquoise",
                    @"Green Sea",
                    @"Emerald",
                    @"Nephritis",
                    @"Peter River",
                    @"Belize Hole",
                    @"Amethyst",
                    @"Wisteria",
                    @"Wet Asphalt",
                    @"Midnight Blue",
                    @"Piano Black",
                    @"Sun Flower",
                    @"Orange",
                    @"Carrot",
                    @"Pumpkin",
                    @"Alizarin",
                    @"Pomegranate",
                    @"Clouds",
                    @"Silver",
                    @"Concrete",
                    @"Asbestos", nil
                   ];
    self.tableView.backgroundColor = [UIColor clearColor];
}


- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {

    NSNumber *selectedIndex = [self.selectedIndexes objectForKey:[NSNumber numberWithInteger:[indexPath row]]];
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.colors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    BigColorTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[BigColorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    NSString *name = self.colors[indexPath.row];
    [cell setColorName:name];
    [cell setColor:[self colorForName:name]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // If our cell is selected, return double height
    if([self cellIsSelected:indexPath]) {
        return 150;
    }
    
    // Cell isn't selected so return single height
    return 72;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     BigColorTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.titleField.delegate = self;
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
     BOOL isSelected = ![self cellIsSelected:indexPath];
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [self.selectedIndexes setObject:selectedIndex forKey:[NSNumber numberWithInteger: [indexPath row]]];
    NSNumber *ornah = [self.selectedIndexes objectForKey:[NSNumber numberWithInteger:[indexPath row]]];
    [self.tableView beginUpdates];
    
    if(ornah == [NSNumber numberWithBool:YES]){
        cell.colorNameLabel.hidden = YES;
        cell.titleField.hidden = NO;
    }
    else{
        cell.colorNameLabel.hidden = NO;
        cell.titleField.hidden = YES;
        [cell.titleField resignFirstResponder];
    }
    [self.tableView endUpdates];

}

- (BOOL)textFieldShouldReturn:(JVFloatLabeledTextField *)textField {
    [textField resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.8 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    return NO;
}

#pragma mark - Status bar

- (BOOL)prefersStatusBarHidden { return YES; }


- (UIColor *)colorForName:(NSString *)name
{
    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
    Class colorClass = [UIColor class];
    return [colorClass performSelector:NSSelectorFromString(selectorString)];
}

@end
