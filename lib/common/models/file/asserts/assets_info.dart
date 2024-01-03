import 'package:orginone/common/models/file/index.dart';

enum CardStatus {
  normal,
  transfer,
  handOver,
  dispose,
  change,
  borrow,
  returned,
}

extension ExCardStatus on CardStatus {
  String get string {
    switch (this) {
      case CardStatus.normal:
        return "正常";
      case CardStatus.transfer:
        return "资产移交中";
      case CardStatus.handOver:
        return "资产交回中";
      case CardStatus.dispose:
        return "资产处置中";
      case CardStatus.change:
        return "资产变动中";
      case CardStatus.borrow:
        return "资产借用中";
      case CardStatus.returned:
        return "已交回";
    }
  }

  String get toStatusId {
    switch (this) {
      case CardStatus.normal:
        return "00";
      case CardStatus.transfer:
        return "08";
      case CardStatus.handOver:
        return "12";
      case CardStatus.dispose:
        return "09";
      case CardStatus.change:
        return "07";
      case CardStatus.borrow:
        return "11";
      case CardStatus.returned:
        return "13";
    }
  }
}

class AssetsInfo {
  List<FileData>? fileList;
  dynamic assetType;
  String? assetTypeCodeAssetTypeCode;
  String? assetsEnglishName;
  String? geographicInformation;
  String? ownershipFormCode;
  String? ownershipCert;
  String? certifiDate;
  String? ownershipNo;
  double? ownershipArea;
  String? owner;
  String? assetName;
  String? assetCode;
  String? startDate;
  dynamic useDept;
  String? useDeptName;
  String? fixedAssAcqCode;
  dynamic estimatedUsefulLife;
  String? quderq;
  dynamic numOrArea;
  String? numUnit;
  dynamic haveUsedIt;
  int? netVal;
  dynamic residualRate;
  dynamic monthAccDep;
  dynamic accDepMonth;
  String? depreciationMethod;
  dynamic accDep;
  dynamic canZhi;
  dynamic initAssetVal;
  int? liuCzt;
  dynamic id;
  String? gmtCreate;
  String? updateTime;
  String? brand;
  String? specMod;
  String? location;
  dynamic invoiceNo;
  String? sourcesOfFunding;
  dynamic user;
  String? userName;
  String? manufacturer;
  String? fixedAssetStateCode;
  String? supplier;
  String? remark;
  Map<String, dynamic>? theDepository;
  String? gs1;
  String? minimumLimit;

  String? acquirementWay;

  bool? sfxc;

  CardStatus? kapianzt;

  int? status;
  String? stockTaskCode;
  String? assetRemark;

  bool? isDistribution;

  bool isOpen = false;

  bool isSelected = false;

  Map<String, dynamic>? allJson;
  AssetsInfo(
      {this.fileList,
      this.assetType,
      this.assetName,
      this.assetCode,
      this.startDate,
      this.useDept,
      this.fixedAssAcqCode,
      this.estimatedUsefulLife,
      this.quderq,
      this.numOrArea,
      this.numUnit,
      this.haveUsedIt,
      this.netVal,
      this.residualRate,
      this.monthAccDep,
      this.accDepMonth,
      this.depreciationMethod,
      this.accDep,
      this.canZhi,
      this.initAssetVal,
      this.liuCzt,
      this.id,
      this.gmtCreate,
      this.updateTime});

  AssetsInfo.fromJson(Map<String, dynamic> json) {
    allJson = json;
    if (json['fileList'] != null) {
      fileList = [];
      json[fileList]?.forEach((json) {
        fileList!.add(FileData.fromJson(json));
      });
    }
    assetType = json['ASSET_TYPE'] ?? json['category'];
    assetTypeCodeAssetTypeCode = json['ASSET_TYPE_CODE_ASSET_TYPE_CODE'];
    assetsEnglishName = json['ASSETS_ENGLISH_NAME'];
    geographicInformation = json['GEOGRAPHIC_INFORMATION'];
    ownershipFormCode = json['OWNERSHIP_FORM_CODE'];
    ownershipCert = json['OWNERSHIP_CERT'];
    certifiDate = json['CERTIFI_DATE'];
    ownershipNo = json['OWNERSHIP_NO'];
    ownershipArea = json['OWNERSHIP_AREA'];
    owner = json['OWNER'];
    assetName = json['ASSET_NAME'];
    assetCode = json['ASSET_CODE'];
    startDate = json['START_DATE'];
    useDept = json['USE_DEPT'];
    useDeptName = json['USE_DEPT_NAME'];
    fixedAssAcqCode = json['FIXED_ASS_ACQ_CODE'];
    estimatedUsefulLife = json['ESTIMATED_USEFUL_LIFE'];
    quderq = json['QUDERQ'];
    numOrArea = json['NUM_OR_AREA'];
    numUnit = json['NUM_UNIT'];
    haveUsedIt = json['HAVE_USED_IT'];
    netVal =
        json['NET_VAL'] != null ? int.tryParse(json['NET_VAL'].toString()) : 0;
    residualRate = json['RESIDUAL_RATE'];
    monthAccDep = json['MONTH_ACC_DEP'];
    accDepMonth = json['ACC_DEP_MONTH'];
    depreciationMethod = json['DEPRECIATION_METHOD'];
    accDep = json['ACC_DEP'];
    canZhi = json['CANZHI'];
    initAssetVal = json['INIT_ASSET_VAL'];
    liuCzt = json['LIUCZT'];
    sfxc = json['SFXC'] is bool ? json['SFXC'] : false;
    id = json['id'];
    gmtCreate = json['gmtCreate'];
    updateTime = json['UPDATE_TIME'];
    brand = json['BRAND'] ?? json['PINPAI'];
    specMod = json['SPEC_MOD'] ?? json['GUIGEXH'];
    location = json['LOCATION'];
    invoiceNo = json['INVOICE_NO'];
    sourcesOfFunding = json['SOURCES_OF_FUNDING'];
    user = json['USER'].toString();
    userName = json['USER_NAME'];
    manufacturer = json['MANUFACTURER'];
    fixedAssetStateCode = json['FIXED_ASSET_STATE_CODE'];
    supplier = json['SUPPLIER'];
    remark = json['REMARK'];
    theDepository = json['THE_DEPOSITORY'];
    gs1 = json['GS1'];
    minimumLimit = json['MINIMUM_LIMIT'];
    acquirementWay = json['ACQUIREMENT_WAY'];
    kapianzt = toStatus(json['KAPIANZT'] ?? "");
    status = json['status'];
    assetRemark = json['assetRemark'];
    stockTaskCode = json['stockTaskCode'];
    isDistribution = json['isDistribution'];
  }

  update(Map<String, dynamic> json) {
    if (json['fileList'] != null) {
      fileList = [];
      json[fileList]?.forEach((json) {
        fileList!.add(FileData.fromJson(json));
      });
    }
    assetType = json['ASSET_TYPE'] ?? assetType;
    assetName = json['ASSET_NAME'] ?? assetName;
    assetTypeCodeAssetTypeCode =
        json['ASSET_TYPE_CODE_ASSET_TYPE_CODE'] ?? assetName;
    assetsEnglishName = json['ASSETS_ENGLISH_NAME'] ?? assetsEnglishName;
    geographicInformation =
        json['GEOGRAPHIC_INFORMATION'] ?? geographicInformation;
    ownershipFormCode = json['OWNERSHIP_FORM_CODE'] ?? ownershipFormCode;
    ownershipCert = json['OWNERSHIP_CERT'] ?? ownershipCert;
    certifiDate = json['CERTIFI_DATE'] ?? certifiDate;
    ownershipNo = json['OWNERSHIP_NO'] ?? ownershipNo;
    ownershipArea = json['OWNERSHIP_AREA'] ?? ownershipArea;
    owner = json['OWNER'] ?? owner;
    assetCode = json['ASSET_CODE'] ?? assetCode;
    startDate = json['START_DATE'] ?? startDate;
    useDept = json['USE_DEPT'] ?? useDept;
    fixedAssAcqCode = json['FIXED_ASS_ACQ_CODE'] ?? fixedAssAcqCode;
    estimatedUsefulLife = json['ESTIMATED_USEFUL_LIFE'] ?? estimatedUsefulLife;
    quderq = json['QUDERQ'] ?? quderq;
    numOrArea = json['NUM_OR_AREA'] ?? numOrArea;
    numUnit = json['NUM_UNIT'] ?? numUnit;
    haveUsedIt = json['HAVE_USED_IT'] ?? haveUsedIt;
    netVal = json['NET_VAL'] ?? netVal;
    residualRate = json['RESIDUAL_RATE'] ?? residualRate;
    monthAccDep = json['MONTH_ACC_DEP'] ?? monthAccDep;
    accDepMonth = json['ACC_DEP_MONTH'] ?? accDepMonth;
    depreciationMethod = json['DEPRECIATION_METHOD'] ?? depreciationMethod;
    accDep = json['ACC_DEP'] ?? accDep;
    canZhi = json['CANZHI'] ?? canZhi;
    initAssetVal = json['INIT_ASSET_VAL'] ?? initAssetVal;
    liuCzt = json['LIUCZT'] ?? liuCzt;
    id = json['id'] ?? id;
    gmtCreate = json['gmtCreate'] ?? gmtCreate;
    updateTime = json['UPDATE_TIME'] ?? updateTime;
    brand = json['BRAND'] ?? brand;
    specMod = json['SPEC_MOD'] ?? specMod;
    location = json['LOCATION'] ?? location;
    invoiceNo = json['INVOICE_NO'] ?? invoiceNo;
    sourcesOfFunding = json['SOURCES_OF_FUNDING'] ?? sourcesOfFunding;
    user = json['USER'] ?? user;
    manufacturer = json['MANUFACTURER'] ?? manufacturer;
    fixedAssetStateCode = json['FIXED_ASSET_STATE_CODE'] ?? fixedAssetStateCode;
    supplier = json['SUPPLIER'] ?? supplier;
    remark = json['REMARK'] ?? remark;
    theDepository = json['THE_DEPOSITORY'] ?? theDepository;
    gs1 = json['GS1'] ?? gs1;
    minimumLimit = json['MINIMUM_LIMIT'] ?? minimumLimit;
    acquirementWay = json['ACQUIREMENT_WAY'] ?? acquirementWay;
    kapianzt = toStatus(json['KAPIANZT'] ?? "") ?? kapianzt;
    isDistribution = json['isDistribution'] ?? isDistribution;
    sfxc = json['SFXC'] ?? sfxc;
  }

  bool get notLockStatus =>
      kapianzt != CardStatus.change &&
      kapianzt != CardStatus.transfer &&
      kapianzt != CardStatus.dispose &&
      kapianzt != CardStatus.borrow &&
      kapianzt != CardStatus.handOver;

  CardStatus? toStatus(String status) {
    switch (status) {
      case "11":
        return CardStatus.borrow;
      case "12":
        return CardStatus.handOver;
      case "13":
        return CardStatus.returned;
      case "00":
        return CardStatus.normal;
      case "07":
        return CardStatus.change;
      case "08":
        return CardStatus.transfer;
      case "09":
        return CardStatus.dispose;
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (assetType != null) {
      data['ASSET_TYPE'] = assetType;
    }
    data['ASSET_NAME'] = assetName;
    data['ASSET_TYPE_CODE_ASSET_TYPE_CODE'] = assetTypeCodeAssetTypeCode;
    data['ASSETS_ENGLISH_NAME'] = assetsEnglishName;
    data['GEOGRAPHIC_INFORMATION'] = geographicInformation;
    data['OWNERSHIP_FORM_CODE'] = ownershipFormCode;
    data['OWNERSHIP_CERT'] = ownershipCert;
    data['CERTIFI_DATE'] = certifiDate;
    data['OWNERSHIP_NO'] = ownershipNo;
    data['OWNERSHIP_AREA'] = ownershipArea;
    data['OWNER'] = owner;
    data['ASSET_CODE'] = assetCode;
    data['START_DATE'] = startDate;
    data['USE_DEPT'] = useDept;
    data['FIXED_ASS_ACQ_CODE'] = fixedAssAcqCode;
    data['ESTIMATED_USEFUL_LIFE'] = estimatedUsefulLife;
    data['QUDERQ'] = quderq;
    data['NUM_OR_AREA'] = numOrArea;
    data['NUM_UNIT'] = numUnit;
    data['HAVE_USED_IT'] = haveUsedIt;
    data['NET_VAL'] = netVal;
    data['RESIDUAL_RATE'] = residualRate;
    data['MONTH_ACC_DEP'] = monthAccDep;
    data['ACC_DEP_MONTH'] = accDepMonth;
    data['DEPRECIATION_METHOD'] = depreciationMethod;
    data['ACC_DEP'] = accDep;
    data['CANZHI'] = canZhi;
    data['INIT_ASSET_VAL'] = initAssetVal;
    data['LIUCZT'] = liuCzt;
    data['id'] = id;
    data['gmtCreate'] = gmtCreate;
    data['UPDATE_TIME'] = updateTime;
    data['SPEC_MOD'] = specMod;
    data['BRAND'] = brand;
    data['LOCATION'] = location;
    data['INVOICE_NO'] = invoiceNo;
    data['SOURCES_OF_FUNDING'] = sourcesOfFunding;
    data['USER'] = user;
    data['MANUFACTURER'] = manufacturer;
    data['FIXED_ASSET_STATE_CODE'] = fixedAssetStateCode;
    data['SUPPLIER'] = supplier;
    data['REMARK'] = remark;
    data['THE_DEPOSITORY'] = theDepository;
    data['GS1'] = gs1;
    data['MINIMUM_LIMIT'] = minimumLimit;
    data['ACQUIREMENT_WAY'] = acquirementWay;
    data['KAPIANZT'] = kapianzt?.toStatusId;
    data['status'] = status;
    data["stockTaskCode"] = stockTaskCode;
    data['assetRemark'] = assetRemark;
    data['isDistribution'] = isDistribution;
    data['USE_DEPT_NAME'] = useDeptName;
    data['USER_NAME'] = userName;
    data['SFXC'] = sfxc;
    return data;
  }

  void initStatus() {
    isOpen = false;
    isSelected = false;
  }
}
