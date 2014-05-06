//
//  DropDownList.m
//  myCombox
//
//  Created by ChenHao on 5/5/14.
//  Copyright (c) 2014 ChenHao. All  rights reserved.
//

#import "DropDownList.h"


@implementation DropDownList

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withData:nil];
}
- (id)initWithFrame:(CGRect)frame withData:(NSArray *)data
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.list = data;
        borderStyle = UITextBorderStyleRoundedRect;
        self.showList = NO;
        oldFrame = frame;//未下拉
        newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height * ([self.list count] +  1));
        lineColor =  [UIColor lightGrayColor];
        listBgColor = [UIColor whiteColor];
        lineWidth = 1;
        self.selectedInter = 0;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;

}

- (id)initWithFrame:(CGRect)frame withData:(NSArray *)data withSelectedInter:(NSInteger )selectedNum
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.list = data;
        self.filterlist = [self.list objectAtIndex:selectedNum];
        
        borderStyle = UITextBorderStyleRoundedRect;
        self.showList = NO;
        oldFrame = frame;//未下拉
        newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height * ([self.filterlist count] +  1));
        lineColor =  [UIColor lightGrayColor];
        listBgColor = [UIColor whiteColor];
        lineWidth = 1;
        [self setValue:[NSNumber numberWithInt:0] forKey:@"selectedInter"];
        //self.selectedInter = 0;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;

}
- (void)drawRect:(CGRect)rect
{
    self.textField  = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, oldFrame.size.width, oldFrame.size.height)];
    self.textField.borderStyle = borderStyle;
    self.textField.enabled = NO;
    self.textField.font = [UIFont boldSystemFontOfSize:30.0];
    [self.textField addTarget:self action:@selector(textFieldClick) forControlEvents:UIControlEventAllEvents];
    
    [self addSubview:self.textField];
    
    self.buttonDropDown = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonDropDown setFrame:CGRectMake(oldFrame.size.width - 50 , 0, 50, oldFrame.size.height)];
    [self.buttonDropDown setBackgroundImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    
    [self.buttonDropDown addTarget:self action:@selector(dropDown) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.buttonDropDown];
    
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, oldFrame.size.height
                                                                 , oldFrame.size.width, oldFrame.size.height *([self.list count]))];

    self.listView.dataSource=self;
    self.listView.delegate=self;
    self.listView.backgroundColor = listBgColor;
    self.listView.layer.borderWidth = 1;
    self.listView.layer.borderColor = [[UIColor grayColor]CGColor];
    self.listView.separatorColor = lineColor;
    self.listView.hidden = !self.showList;
    [self addSubview:self.listView];
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.filterlist = [self.list objectAtIndex:self.selectedInter];
    if ( 1== tableView.superview.tag) {
        return [self.list count];
    }
    else
        return [self.filterlist count];
    
    //NSLog(@"%lu",(unsigned long)[self.list count]);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"list";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    if ( 1 == tableView.superview.tag) {
        cell.textLabel.text =  (NSString *)[self.list objectAtIndex:indexPath.row];
    }
    else
        cell.textLabel.text = (NSString *)[self.filterlist objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:25.0];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (1 == tableView.superview.tag ) {
        self.textField.text = (NSString*)[self.list objectAtIndex:indexPath.row];
        NSLog(@"hehe1");
        [self setNewListFrame:NO];
        [self setValue:[NSNumber numberWithInt:indexPath.row] forKey:@"selectedInter"];
        //self.selectedInter = indexPath.row;
        NSLog(@"%ld",(long)self.selectedInter);
    }
    else
    {
        self.textField.text = (NSString*)[self.filterlist objectAtIndex:indexPath.row];
        NSLog(@"hehe2");
        [self setNewListFrame:NO];
        self.selectedInter = indexPath.row;
        NSLog(@"%ld",(long)self.selectedInter);
    }
    
}

- (void)textFieldClick
{
    [self.textField resignFirstResponder];
}
- (void)dropDown
{
  
    if (self.showList) {
        [self setNewListFrame:NO];
       // [self.buttonDropDown setBackgroundImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlEventTouchUpInside];
        
    }
    else
    {
        [self.superview bringSubviewToFront:self];
        [self setNewListFrame:YES];
    }

}
- (void)setNewListFrame:(BOOL)b
{
    
    _showList = b;
    if (self.showList) {
        self.frame = newFrame;
        
    }
    else
        self.frame = oldFrame;
    self.listView.hidden = !b;
   // [self setNeedsDisplay];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
