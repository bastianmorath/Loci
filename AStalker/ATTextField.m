//
//  ATTextField.m
//  ATKlassen
//
//  Created by Florian Morath on 23.06.14.
//  Copyright (c) 2014 Florian Morath. All rights reserved.
//

#import "ATTextField.h"
//#import "AntumColor.h"

@implementation ATTextField

@synthesize placeholder = _placeholder;

// Wenn im Storyboard TextField erstellt wird, wird diese Methode aufgerufen
-(id)initWithCoder:(NSCoder *)aDecoder{
   
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setupTextField];
        
    }
    
    return self;
}

// convenience constructor
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        
        [self setupTextField];
        self.placeholder = placeholder;
        self.text = self.placeholder;
    }
    return self;
}

-(void)setupTextField
{
    [self setTextColor:[UIColor whiteColor]];
   // self.backgroundColor = [AntumColor settingsColor];
    //[[UITextField appearance] setFont:(UIFont*)[ATFont placeholerFont]];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self setBorderStyle:UITextBorderStyleNone];
    self.delegate = self;
}


// Setters überschreiben
-(void)setPlaceholder:(NSString*)placeholder{
    
    _placeholder = placeholder;
    self.text = self.placeholder;

}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset( bounds, 10 , 8);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset( bounds, 10 , 8);
}


#pragma mark Delegates

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text
{
    //Wenn der Return-Button auf dem Keyboard gedrückt wird, verschwindet das Keyboard
    if ([text isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:self.placeholder]) {
        textField.text = @"";
    }
    [textField becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        textField.text = self.placeholder;
    }
    [textField resignFirstResponder];
}


@end
