enum Status { initial, loading, success, failure, networkError, empty }

extension StatusExtension on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isLoadingOrInitial =>
      [Status.loading, Status.initial].contains(this);
  bool get isAnyError => [Status.networkError, Status.failure].contains(this);
  bool get isEmpty => this == Status.empty;
  bool get isNetworkError => this == Status.networkError;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
}

enum Pagination { match, loading, notMatch }

enum PopUpActions { delete, edit }

extension PaginationExtension on Pagination {
  bool get isLoading => this == Pagination.loading;
  bool get isMatch => this == Pagination.match;
  bool get isNotMatch => this == Pagination.notMatch;
}

enum ShowMessageEnum {
  showFailedAlert,
  showSuccessAlert,
  showBothAlert,
  showfailedToast,
  showSuccessToast,
  showBothToast,
  showFailedAlertSuccessToast,
  showFailedToastSuccessAlert,
  none
}

extension ShowMessageEnumExtension on ShowMessageEnum {
  bool get successAlert => [
        ShowMessageEnum.showSuccessAlert,
        ShowMessageEnum.showBothAlert,
        ShowMessageEnum.showFailedToastSuccessAlert
      ].contains(this);
  bool get failedAlert => [
        ShowMessageEnum.showFailedAlert,
        ShowMessageEnum.showBothAlert,
        ShowMessageEnum.showFailedAlertSuccessToast
      ].contains(this);
  bool get failedToast => [
        ShowMessageEnum.showBothToast,
        ShowMessageEnum.showfailedToast,
        ShowMessageEnum.showFailedToastSuccessAlert
      ].contains(this);

  bool get successToast => [
        ShowMessageEnum.showBothToast,
        ShowMessageEnum.showSuccessToast,
        ShowMessageEnum.showFailedAlertSuccessToast
      ].contains(this);
}

enum ParseBody { direct, row, towLevelList, none, thirdLevelList }

enum DataSource { local, remote, checkNetwork }

extension DataSourceExtension on DataSource {
  bool get isRemote => this == DataSource.remote;
  bool get isLocal => this == DataSource.local;
  bool get isCheckNetwork => this == DataSource.checkNetwork;
}

enum WorkOutStatus { Started, RestTime, BeReady }

enum WorkOutMatch { Start, End, None }

extension WorkOutMatchExtension on WorkOutMatch {
  bool get isStart => this == WorkOutMatch.Start;
  bool get isEnd => this == WorkOutMatch.End;
  bool get isNone => this == WorkOutMatch.None;
}

/// to check database table type
/// for sembast database
enum DataBaseType { Integer, Strings }

class Days {
  static String sat = "sat";
  static String sun = "sun";
  static String mon = "mon";
  static String tue = "tue";
  static String wed = "wed";
  static String thu = "thu";
  static String fri = "fri";
  static List<String> get all => [
        sat,
        sun,
        mon,
        tue,
        wed,
        thu,
        fri,
      ];
}

/// used in get default operation message
enum OperationType {
  SuccessGetAll,
  SuccessGetOne,
  SuccessAddAll,
  SuccessAddOne,
  SuccessUpdate,
  SuccessDelete,
  FailedAddAll,
  FailedGetAll,
  FailedGetOne,
  FailedAddOne,
  FailedUpdate,
  FailedDelete,
}

enum DataBaseFilterType {
  Equal,
  NotEqual,
  GreaterThan,
  GreaterOrEqual,
  IsInList,
  NotInList,
  LessThan,
  LessOrEqual,
}

enum DashBoardEnums { Orders, Mosts, ByGroups }

enum DashBoardGroupsEnums { Items, ItemsGroup, Territory, Others }

enum RefreshStatus { waiting, loading, error, success }

extension RefreshStatusExtension on RefreshStatus {
  bool get isWatting => this == RefreshStatus.waiting;
  bool get isError => this == RefreshStatus.error;
  bool get isSuccess => this == RefreshStatus.success;
  bool get isLoading => this == RefreshStatus.loading;
}

enum PrintType { SellOrder, Paymewnt, None }

enum PrinterType { hprt, apex }

enum ShowLoading { show, none, close, both }

extension ShowLoadingExtension on ShowLoading {
  bool get isShow => [ShowLoading.show, ShowLoading.both].contains(this);
  bool get isNone => this == ShowLoading.none;
  bool get isClose =>
      [ShowLoading.both, ShowLoading.show, ShowLoading.close].contains(this);
}

enum SortBy { date, territory, salesPerson }

enum GroupBy { territory, salesPerson }

enum SorttType { asc, desc }

enum GetLocationEnum { none, errroClose, bothClose, successClose }

extension GetLocationEnumExtension on GetLocationEnum {
  bool get errroClose => this == GetLocationEnum.errroClose;
  bool get bothClose => this == GetLocationEnum.bothClose;
  bool get successClose => this == GetLocationEnum.successClose;
  bool get none => this == GetLocationEnum.none;
}

enum TargetTypesOptions { VisitDaily, Orders, MaterialSells, NewCustomer }

enum TargetForOptions { CustomerGroup, Territory, Customer, Item, ItemGroup }

/// gps  is off  / permission dined  //
enum LocationStatus { off, permssion, unknown }
