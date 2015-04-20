
#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"

@interface BigColorTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *colorNameLabel;
@property (nonatomic, strong) JVFloatLabeledTextField *titleField;
- (void)setColorName:(NSString *)colorName;
- (void)setColor:(UIColor *)color;
@end
