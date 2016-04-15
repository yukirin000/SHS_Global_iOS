//
//  ApplyCarViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/13.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ApplyCarViewController.h"
#import "ChoiceCarTypeViewController.h"

NS_ENUM(NSInteger){
    TableName    = 0,
    TableMobile  = 1,
    TablePlate   = 2,
    TableCarType = 3,
    TableDriving = 4
};

@interface ApplyCarViewController ()

@property (nonatomic, strong) UITableView     * tableView;

@property (nonatomic, strong) CustomLabel     * nameLabel;

@property (nonatomic, strong) CustomLabel     * mobileLabel;

@property (nonatomic, strong) CustomLabel     * carTypeLabel;

@property (nonatomic, strong) CustomLabel     * plateLabel;

@property (nonatomic, strong) CustomLabel     * drivingLicenseLabel;

@property (nonatomic, strong) CustomImageView * drivingLicenseImageView;

@property (nonatomic, strong) NSString * carTypeCode;

@end

@implementation ApplyCarViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWidget];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout

- (void)initWidget{

    self.nameLabel               = [[CustomLabel alloc] init];
    self.mobileLabel             = [[CustomLabel alloc] init];
    self.carTypeLabel            = [[CustomLabel alloc] init];
    self.plateLabel              = [[CustomLabel alloc] init];
    self.drivingLicenseLabel     = [[CustomLabel alloc] init];
    self.drivingLicenseImageView = [[CustomImageView alloc] init];
    
    [self initTable];
    [self configUI];
}

- (void)initTable
{
    self.tableView                              = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight) style:UITableViewStylePlain];
    self.tableView.delegate                     = self;
    self.tableView.dataSource                   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces                      = NO;
    [self.view addSubview:self.tableView];
}

- (void)configUI{
    
    [self setNavBarTitle:@"提交爱车"];
    
    [self configLabelFactory:self.nameLabel];
    [self configLabelFactory:self.mobileLabel];
    [self configLabelFactory:self.carTypeLabel];
    [self configLabelFactory:self.drivingLicenseLabel];
    
    self.drivingLicenseLabel.text      = @"上传";
    self.drivingLicenseLabel.textColor = [UIColor blueColor];
    
    self.plateLabel.frame                            = CGRectMake(self.viewWidth-100, 0, 70, 60);
    self.plateLabel.textAlignment                    = NSTextAlignmentRight;
    self.drivingLicenseImageView.frame               = CGRectMake(self.viewWidth-80, 5, 50, 50);
    self.drivingLicenseImageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.drivingLicenseImageView.layer.masksToBounds = YES;
    self.drivingLicenseImageView.hidden              = YES;
    
}

#pragma mark- method response

#pragma mark- Delegate & Datasource

#pragma mark- UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
        
        switch (indexPath.row) {
            case TableName:
                [cell.contentView addSubview:self.nameLabel];
                cell.textLabel.text = @"姓名";
                break;
            case TableMobile:
                [cell.contentView addSubview:self.mobileLabel];
                cell.textLabel.text = @"电话";
                break;
            case TablePlate:
            {
                CustomLabel * yueB = [[CustomLabel alloc] initWithFrame:CGRectMake(self.viewWidth-140, 0, 35, 60)];
                yueB.text          = @"粤B";
                [cell.contentView addSubview:yueB];
                [cell.contentView addSubview:self.plateLabel];
                cell.textLabel.text = @"车牌号";
            }
                break;
            case TableCarType:
                [cell.contentView addSubview:self.carTypeLabel];
                cell.textLabel.text = @"车型";
                break;
            case TableDriving:
                [cell.contentView addSubview:self.drivingLicenseLabel];
                [cell.contentView addSubview:self.drivingLicenseImageView];
                cell.textLabel.text = @"行驶证";
                break;
            default:
                break;
        }
        UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(0, 59, self.viewWidth, 1)];
        lineView.backgroundColor = [ UIColor colorWithHexString:ColorLineGray];
        [cell.contentView addSubview:lineView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, 150)];
    
    //btn样式处理
    CustomButton * btn      = [[CustomButton alloc] init];
    btn.frame               = CGRectMake(kCenterOriginX((self.viewWidth-30)), 80, (self.viewWidth-30), 45);
    btn.layer.cornerRadius  = 5;
    btn.layer.borderWidth   = 1;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    btn.fontSize            = FontLoginButton;
    [btn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:ColorLoginBtnGray] forState:UIControlStateHighlighted];
    [btn setTitle:StringCommonSubmit forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(applyCar) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case TableName:
        case TableMobile:
        case TablePlate:
        {
            
            YSAlertView * alert = [YSAlertView initWithTitle:@"" message:nil completionBlock:^(NSUInteger buttonIndex, YSAlertView *alertView) {
                
                NSString * content = [[alertView textFieldAtIndex:0].text trim];
                
                if (buttonIndex == 1) {
                    if (indexPath.row == TableName) {
                        if ([ToolsManager validateName:content]) {
                            self.nameLabel.text = content;
                        }else{
                            [self showHint:@"请输入2-4位中文"];
                        }
                    }else if (indexPath.row == TableMobile){
                        if ([ToolsManager validateMobile:content]) {
                            self.mobileLabel.text = content;
                        }else{
                            [self showHint:@"请输入电话号码"];
                        }
                    }else{
                        if ([ToolsManager validatePlateNumber:content]) {
                            self.plateLabel.text = [content uppercaseString];
                        }else{
                            [self showHint:@"请输入正确的车牌号"];
                        }
                    }
                }
            } cancelButtonTitle:StringCommonCancel otherButtonTitles:StringCommonConfirm, nil];
            alert.alertViewStyle    = UIAlertViewStylePlainTextInput;
            UITextField * textField = [alert textFieldAtIndex:0];
            NSString * title;
            if (indexPath.row == TableName) {
                title          = @"姓名";
                textField.text = self.nameLabel.text;
            }else if (indexPath.row == TableMobile){
                title          = @"电话";
                textField.text = self.mobileLabel.text;
            }else{
                title          = @"车牌号";
                textField.text = self.plateLabel.text;
            }
            textField.placeholder = title;
            alert.title           = title;
            [alert show];
        }
            break;
        case TableCarType:
        {
            ChoiceCarTypeViewController * cctvc = [[ChoiceCarTypeViewController alloc] init];
            cctvc.level                         = 1;
            cctvc.returnVC                      = self;
            [cctvc setBlock:^(NSString *carType, NSString *carTypeCode) {
                self.carTypeLabel.text = carType;
                self.carTypeCode       = carTypeCode;
            }];
            [self pushVC:cctvc];
        }
            break;
        case TableDriving:
        {
            UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:StringCommonCancel destructiveButtonTitle:nil otherButtonTitles:GlobalString(@"CommonCamera"), GlobalString(@"CommonGallery"), nil];
            [sheet showInView:self.view];
        }
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //选照片
    if (buttonIndex != 2) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        if (buttonIndex == 0) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            }
        }
        if (buttonIndex == 1) {
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        
        picker.delegate = self;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
    
}

#pragma mark- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image                     = info[UIImagePickerControllerOriginalImage];
    self.drivingLicenseImageView.image  = image;
    self.drivingLicenseImageView.hidden = NO;
    self.drivingLicenseLabel.hidden     = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark- private method
- (void)configLabelFactory:(CustomLabel *)label{
    label.frame         = CGRectMake(self.viewWidth-200, 0, 170, 60);
    label.textAlignment = NSTextAlignmentRight;
}

- (void)applyCar{

    //车类型不能为空
    if (self.carTypeLabel.text.length < 1) {
        [self showHint:@"请选择车型"];
        return;
    }
    //请上传驾驶证
    if (self.drivingLicenseImageView.image == nil) {
        [self showHint:@"请上传驾驶证"];
        return;
    }
    
    NSDictionary * params = @{@"user_id":[NSString stringWithFormat:@"%ld", [UserService getUserID]],
                              @"name":[self.nameLabel.text trim],
                              @"mobile":[self.mobileLabel.text trim],
                              @"plate_number":[self.plateLabel.text trim],
                              @"car_type":self.carTypeLabel.text,
                              @"car_type_code":self.carTypeCode};
    
    NSArray * files = @[@{FileDataKey:UIImageJPEGRepresentation(self.drivingLicenseImageView.image,0.8),FileNameKey:[NSString stringWithFormat:@"%ld%d.jpg", [UserService sharedService].user.user_id, (int)[NSDate date].timeIntervalSince1970]}];
    
    [HttpService postFileWithUrlString:API_AddCar params:params files:files andCompletion:^(id responseData) {
        
        NSInteger status = [responseData[HttpStatus] integerValue];
        if (status == HttpStatusCodeSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showFail:responseData[HttpMessage]];
        }
        
    } andFail:^(NSError *error) {
        [self showFail:StringCommonUploadDataFail];
    }];
    
}

- (void)initData
{
    
}

@end
