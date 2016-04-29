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
    TablePlate   = 1,
    TableCarType = 2,
    TableDriving = 3
};

@interface ApplyCarViewController ()

@property (nonatomic, strong) UITableView     * tableView;

@property (nonatomic, strong) CustomLabel     * nameLabel;

@property (nonatomic, strong) CustomLabel     * carTypeLabel;

@property (nonatomic, strong) CustomLabel     * plateLabel;

@property (nonatomic, strong) CustomLabel     * drivingLicenseLabel;

@property (nonatomic, strong) CustomImageView * drivingLicenseImageView;

@property (nonatomic, strong) NSString        * carTypeCode;

@end

@implementation ApplyCarViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWidget];
    
    if (self.carModel.cid > 0) {
        [self initData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout

- (void)initWidget{

    self.nameLabel               = [[CustomLabel alloc] init];
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
    self.tableView.backgroundColor              = [UIColor clearColor];
    self.tableView.delegate                     = self;
    self.tableView.dataSource                   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces                      = NO;
    [self.view addSubview:self.tableView];
}

- (void)configUI{
    
    [self setNavBarTitle:GlobalString(@"ApplyCarSubmit")];
    
    [self configLabelFactory:self.nameLabel];
    [self configLabelFactory:self.carTypeLabel];
    [self configLabelFactory:self.drivingLicenseLabel];
    
    self.drivingLicenseLabel.text      = GlobalString(@"ApplyCarUpload");
    self.drivingLicenseLabel.textColor = [UIColor colorWithHexString:@"888888"];
    self.drivingLicenseLabel.font      = [UIFont systemFontOfSize:14];
    
    self.plateLabel.frame         = CGRectMake(self.viewWidth-75, 0, 60, 50);
    self.plateLabel.textAlignment = NSTextAlignmentRight;
    self.plateLabel.textColor     = [UIColor colorWithHexString:@"888888"];
    self.plateLabel.font          = [UIFont systemFontOfSize:14];
    
    self.drivingLicenseImageView.frame               = CGRectMake(self.viewWidth-75, 5, 60, 40);
    self.drivingLicenseImageView.contentMode         = UIViewContentModeScaleAspectFit;
    self.drivingLicenseImageView.layer.masksToBounds = YES;
    self.drivingLicenseImageView.hidden              = YES;
    
    self.carTypeLabel.text  = GlobalString(@"ApplyCarChoiceType");
    self.carTypeLabel.width = 165;
    
}

#pragma mark- method response

#pragma mark- Delegate & Datasource

#pragma mark- UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    if (!cell) {
        cell                             = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
        cell.textLabel.textColor         = [UIColor colorWithHexString:ColorTitle];
        cell.textLabel.font              = [UIFont systemFontOfSize:FontListName];
        cell.contentView.backgroundColor = [UIColor colorWithHexString:ColorWhite];
        cell.selectionStyle              = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case TableName:
                //姓名
                [cell.contentView addSubview:self.nameLabel];
                cell.textLabel.text = GlobalString(@"ApplyCarName");
                break;
            case TablePlate:
            {
                //车牌号
                CustomLabel * yueB = [[CustomLabel alloc] initWithFrame:CGRectMake(self.viewWidth-90, 0, 14, 50)];
                yueB.textColor     = [UIColor colorWithHexString:@"888888"];
                yueB.font          = [UIFont systemFontOfSize:14];
                yueB.text          = @"粤";
                [cell.contentView addSubview:yueB];
                [cell.contentView addSubview:self.plateLabel];
                cell.textLabel.text = GlobalString(@"ApplyCarPlate");
            }
                break;
            case TableCarType:
            {
                //车型
                [cell.contentView addSubview:self.carTypeLabel];
                cell.textLabel.text = GlobalString(@"ApplyCarCarType");
                CustomImageView * arrow = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
                arrow.image             = [UIImage imageNamed:@"right_arrow"];
                arrow.frame             = CGRectMake(self.viewWidth-28, 18, 13, 13);
                [cell.contentView addSubview:arrow];
            }
                break;
            case TableDriving:
                //行驶证
                [cell.contentView addSubview:self.drivingLicenseLabel];
                [cell.contentView addSubview:self.drivingLicenseImageView];
                cell.textLabel.text = GlobalString(@"ApplyCarDrivingLicense");
                break;
            default:
                break;
        }
        UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(15, 49, self.viewWidth-15, 1)];
        lineView.backgroundColor = [ UIColor colorWithHexString:ColorLineGray];
        [cell.contentView addSubview:lineView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, 150)];
    
    //btn样式处理
    CustomButton * btn      = [[CustomButton alloc] init];
    btn.frame               = CGRectMake(kCenterOriginX((self.viewWidth-30)), 30, (self.viewWidth-30), 45);
    btn.backgroundColor     = [UIColor colorWithHexString:ColorWhite];
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
        case TablePlate:
        {
            YSAlertView * alert = [YSAlertView initWithTitle:@"" message:nil completionBlock:^(NSUInteger buttonIndex, YSAlertView *alertView) {
                
                NSString * content = [[alertView textFieldAtIndex:0].text trim];
                
                if (buttonIndex == 1) {
                    if (indexPath.row == TableName) {
                        if ([ToolsManager validateName:content]) {
                            self.nameLabel.text = content;
                        }else{
                            [self showHint:GlobalString(@"ApplyCarPleaseEnterName")];
                        }
                    }else{
                        if ([ToolsManager validatePlateNumber:content]) {
                            self.plateLabel.text = [content uppercaseString];
                        }else{
                            [self showHint:GlobalString(@"ApplyCarPleaseEnterPlate")];
                        }
                    }
                }
            } cancelButtonTitle:StringCommonCancel otherButtonTitles:StringCommonConfirm, nil];
            
            alert.alertViewStyle    = UIAlertViewStylePlainTextInput;
            UITextField * textField = [alert textFieldAtIndex:0];
            NSString * title;
            if (indexPath.row == TableName) {
                title          = GlobalString(@"ApplyCarName");
                textField.text = self.nameLabel.text;
            }else{
                title          = GlobalString(@"ApplyCarPlate");
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
    label.frame         = CGRectMake(self.viewWidth-200, 0, 185, 50);
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor colorWithHexString:@"888888"];
    label.font = [UIFont systemFontOfSize:14];
}

- (void)applyCar{

    //请输入名字
    if (self.nameLabel.text.length < 1) {
        [self showHint:GlobalString(@"ApplyCarPleaseEnterName")];
        return;
    }
    //请输入车牌
    if (self.plateLabel.text.length < 1) {
        [self showHint:GlobalString(@"ApplyCarPleaseEnterPlate")];
        return;
    }
    
    //车类型不能为空
    if (self.carTypeCode.length < 1) {
        [self showHint:GlobalString(@"ApplyCarPleaseChoiceCar")];
        return;
    }
    //请上传驾驶证
    if (self.drivingLicenseImageView.image == nil) {
        [self showHint:GlobalString(@"ApplyCarPleaseUploadLicense")];
        return;
    }
    
    NSArray * files = @[@{FileDataKey:UIImageJPEGRepresentation(self.drivingLicenseImageView.image,0.5),FileNameKey:[NSString stringWithFormat:@"%ld%d.jpg", [UserService sharedService].user.user_id, (int)[NSDate date].timeIntervalSince1970]}];
    
    NSDictionary * params;
    NSString * url;
    
    //更新车辆
    if (self.carModel.cid > 0) {
        url = API_UpdateCar;
        params = @{@"car_id":[NSString stringWithFormat:@"%ld", self.carModel.cid],
                   @"user_id":[NSString stringWithFormat:@"%ld", [UserService getUserID]],
                   @"name":[self.nameLabel.text trim],
                   @"plate_number":[self.plateLabel.text trim],
                   @"car_type":self.carTypeLabel.text,
                   @"car_type_code":self.carTypeCode};
    }else{
        url = API_AddCar;
        params = @{@"user_id":[NSString stringWithFormat:@"%ld", [UserService getUserID]],
                   @"name":[self.nameLabel.text trim],
                   @"plate_number":[self.plateLabel.text trim],
                   @"car_type":self.carTypeLabel.text,
                   @"car_type_code":self.carTypeCode};
    }
    
    [self showHudInView:self.view hint:StringCommonUploadData];
    [HttpService postFileWithUrlString:url params:params files:files andCompletion:^(id responseData) {
        
        NSInteger status = [responseData[HttpStatus] integerValue];
        if (status == HttpStatusCodeSuccess) {
            [self showSuccess:nil];
            if (self.carModel.cid > 0) {
                [self popToTabBarViewController];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [self showFail:responseData[HttpMessage]];
        }
        
    } andFail:^(NSError *error) {
        [self showFail:StringCommonUploadDataFail];
    }];
    
}

- (void)initData
{
    
    self.nameLabel.text    = self.carModel.name;
    self.carTypeLabel.text = self.carModel.car_type;
    self.carTypeCode       = self.carModel.car_type_code;
    self.plateLabel.text   = [self.carModel.plate_number stringByReplacingOccurrencesOfString:@"粤" withString:@""];
    
    self.drivingLicenseLabel.hidden     = YES;
    self.drivingLicenseImageView.hidden = NO;
    [self.drivingLicenseImageView sd_setImageWithURL:[NSURL URLWithString:self.carModel.driving_license_url]];
    
}

@end
