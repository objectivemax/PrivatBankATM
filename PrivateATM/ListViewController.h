//
//  ListViewController.h
//  PrivateATM
//
//  Created by Maxim Ohrimenko on 10/12/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetPickerView.h"
#import "MapViewController.h"

@interface ListViewController : UIViewController {
    IBOutlet UIButton *buttonCity;
}

@property (nonatomic, strong) NSString *nameCity;

- (IBAction)nameCity:(id)sender;
- (IBAction)goToMaps:(id)sender;

@end
