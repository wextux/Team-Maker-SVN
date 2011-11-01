//
//  CreateTeamsAlertView.m
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-12.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import "CreateTeamsAlertView.h"

@implementation CreateTeamsAlertView
@synthesize textField;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle {
    
    if (self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:okButtonTitle, nil])
    {
        UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)]; 
        [theTextField setBackgroundColor:[UIColor whiteColor]]; 
        [self addSubview:theTextField];
        self.textField = theTextField;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.returnKeyType = UIReturnKeyDone;
        CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 0.0); 
        [self setTransform:translate];
    }
    return self;
}


- (void)show
{
    [textField becomeFirstResponder];
    [super show];
}


- (NSString *)enteredText
{
    return textField.text;
}


@end
