//
//  ATTextField.h
//  ATKlassen
//
//  Created by Florian Morath on 23.06.14.
//  Copyright (c) 2014 Florian Morath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATTextField : UITextField <UITextFieldDelegate>

- (id)initWithFrame:(CGRect)frame placeholder:(NSString*)placeholder;

- (CGRect)editingRectForBounds:(CGRect)bounds;
- (CGRect)textRectForBounds:(CGRect)bounds;


@property (nonatomic, strong) NSString *placeholder;

@end
