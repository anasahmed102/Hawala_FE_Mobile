
import 'package:flutter/material.dart';
import 'package:hawala/localization/app_local.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/validator_service.dart';
import 'package:hawala/shared/logger.dart';




class Trans {
  static String calories = "calories";
  static String areYouSureToDelete = "areYouSureToDelete";
  static String close = "close";
  static String valueMustBeMoreThanZero = "valueMustBeMoreThanZero";
  static String plan = "plan";
  static String day = "day";
  static String assignedWorkOuts = "assignedWorkOuts";
  static String share = "share";
static String newUpdateIsAvailbe = "newUpdateIsAvailbe";
static String creditLimit = "creditLimit";
static String modelSavedToTheDeviceSyncLater =
      "modelSavedToTheDeviceSyncLater";
      static String failedToSync = "failedToSync";
static String successToSync = "successToSync";
static String failedToGetTotal = "failedToGetTotal";
static String successToGetTotal = "successToGetTotal";
static String yourAccountLicenseIsFinished = "yourAccountLicenseIsFinished";
static String newUpdateIsAvailbeYouMustUpdateTheApp =
      "newUpdateIsAvailbeYouMustUpdateTheApp";
 static String valueMustBeEqualOrMoreThanAndEqualAndLessThan =
      "valueMustBeEqualOrMoreThanAndEqualAndLessThan";
  static String assignedWorkOut = "assignedWorkOut";
  static String workOutPlan = "WorkOutPlan";
  static String appName = "appName";
static String synced = "synced";
static String outWorkTime = "outWorkTime";
static String limitUsageTimeSpan = "limitUsageTimeSpan";
static String insufficientQuantityInWarehouse =
      "insufficientQuantityInWarehouse";

  static String workOutPlans = "WorkOutPlans";
  static String monthly = "monthly";
  static String weekly = "weekly";
  static String lastWeek = "lastWeek";
  static String dark = "dark";
  static String light = "light";
  static String system = "system";
  static String empty = "empty";
  static String weight = "weight";
  static String height = "height";
  static String chest = "chest";
  static String shoulder = "shoulder";
  static String calves = "calves";
  static String hamstrings = "hamstrings";
  static String quadriceps = "quadriceps";
  static String biceps = "biceps";
  static String gluteus = "gluteus";
  static String forearms = "forearms";
  static String trapezius = "trapezius";
  static String lats = "lats";
  static String itIsNetritionTime = "itIsNetritionTime";
  static String userAcitvityies = "userAcitvityies";
  static String netritionSchedule = "netritionSchedule";
  static String notAllowed = "notAllowed";
  static String userAcitvity = "userAcitvity";
  static String from = "from";
  static String to = "to";
  static String years = "years";
  static String exercises = "exercises";
  static String trainees = "trainees";
  static String doYouWantToSaveProgress = "doYouWantToSaveProgress";
  static String restTime = "restTime";
  static String reps = "reps";
  static String sec = "sec";
  static String users = "users";
  static String expireAt = "expireAt";
  static String exp = "exp";
  static String next = "next";
  static String areYouSureToCloseWorkout = "areYouSureToCloseWorkout";
  static String timeLines = "timeLines";
  static String netritionNotifications = "netritionNotifications";
  static String scoop = "scoop";
  static String weightHistory = "weightHistory";
  static String lastWeekActivity = "lastWeekActivity";
  static String yourActivity = "yourActivity";
  static String measurementHistory = "measurementHistory";
  static String changesInLast7Days = "changesInLast7Days";
  static String exerciseTimeInLast7Days = "exerciseTimeInLast7Days";
  static String consumed = "consumed";
  static String takeYourRest = "takeYourRest";
  static String doYourExcrsie = "doYourExcrsie";
  static String beReady = "beReady";
  static String exrsiceDetalis = "exrsiceDetalis";
  static String viewMore = "viewMore";
  static String yourMeasurement = "yourMeasurement";
  static String cm = "cm";
  static String sets = "sets";
  static String kg = "kg";
  static String birthDay = "birthDay";
  static String viewHistory = "viewHistory";
  static String selectYourHeight = "selectYourHeight";
  static String selectYourWeight = "selectYourWeight";
  static String selectYourWaist = "selectYourWaist";
  static String selectYourBirthday = "selectYourBirthday";
  static String waist = "waist";
  static String successfullyGeUserDetalis = "successfullyGeUserDetalis";
  static String failedGeUserDetalis = "failedGeUserDetalis";
  static String loginScucced = "loginScucced";
  static String appMode = "appMode";
  static String reciveNetrotionNotifications = "reciveNetrotionNotifications";
  static String appLang = "appLang";
  static String todayNetrition = "todayNetrition";
  static String statistics = "statistics";
  static String startAll = "startAll";
  static String start = "start";
  static String darkTheme = "darkTheme";
  static String sat = "sat";
  static String sun = "sun";
  static String mon = "mon";
  static String tue = "tue";
  static String wen = "wen";
  static String thu = "thu";
  static String fri = "fri";
  static String saturday = "saturday";
  static String sunday = "sunday";
  static String monday = "monday";
  static String tuesday = "tuesday";
  static String wednesday = "wednesday";
  static String thursday = "thursday";
  static String friday = "friday";
  static String viewAll = "viewAll";
  static String workOuts = "workOuts";
  static String todayWorkOuts = "todayWorkOuts";
  static String startTraining = "startTraining";
  static String welcomeBackToApp = "welcomeBackToApp";
  static String settings = "settings";
  static String workOut = "workOut";
  static String netrition = "netrition";
  static String page1Desc = "page1Desc";
  static String page2Desc = "page2Desc";
  static String page3Desc = "page3Desc";
  static String page1Title = "page1Title";
  static String page2Title = "page2Title";
  static String page3Title = "page3Title";
  static String fullName = "fullName";
  static String female = "female";
  static String male = "male";
  static String welcomeToGymApplication = "welcomeToGymApplication";
  static String filterByDiscount = "filterByDiscount";
  static String filterByGroups = "filterByGroups";
  static String printSetting = "printSetting";
  static String printedAt = "printedAt";
  static String customerSignature = "customerSignature";
  static String itemName = "itemName";
  static String noDataToExport = "noDataToExport";
  static String youHaveNotPermissonToDoThat = "youHaveNotPermissonToDoThat";
  static String rePrintReciveInvoice = "rePrintReciveInvoice";
  static String view = "view";
  static String createVisit = "createVisit";
  static String internetConnectionError = "internetConnectionError";
  static String others = "others";
  static String elementsWastFound = "elementsWastFound";
  static String name = "name";
  static String mostSoldItem = "mostSoldItem";
  static String mostOrders = "mostOrders";
  static String mostVisits = "mostVisits";
  static String mostCollected = "mostCollected";
  static String topItem = "topItem";
  static String distinctItem = "distinctItem";
  static String distinctItemGroup = "distinctItemGroup";
  static String dashboard = 'dashboard';
  static String mostTerritory = 'mostTerritory';
  static String mostItemGroup = 'mostItemGroup';
  static String mostItem = 'mostItem';
  static String soldAmount = 'soldAmount';
  static String collectedAmount = 'collectedAmount';
  static String routeVisits = 'routeVisits';
  static String newCustomer = 'newCustomer';
  static String visited = 'visited';
  static String doneTrnsactions = 'doneTrnsactions';
  static String checkInternetConnectionAndRetryAgain =
      'checkInternetConnectionAndRetryAgain';
  static String unKnownErrorPleaseRetryLater = 'unKnownErrorPleaseRetryLater';
  static String successToGetAllData = "successToGetAllData";
  static String failedToGetAllData = "failedToGetAllData";
  static String failedToGetOne = "failedToGetOne";
  static String successToGetOne = "successToGetOne";
  static String successToUpdateOne = "successToUpdateOne";
  static String failedToUpdateOne = "failedToUpdateOne";
  static String successToAddOne = "successToAddOne";
  static String failedToAddOne = "failedToAddOne";
  static String successToAddAll = "successToAddAll";
  static String failedToAddAll = "failedToAddAll";
  static String successToDeleteOne = "successToDeleteOne";
  static String failedToDeleteOne = "failedToDeleteOne";

  static String clickHereToShowTodaySellOrders =
      'clickHereToShowTodaySellOrders';
  static String clickHereToShowTodayPayments = 'clickHereToShowTodayPayments';
  static String appHasNotAccessToFiles = 'appHasNotAccessToFiles';
  static String sellOrders = 'sellOrders';

  static String clickHereToChangePrintSettingLikeWidthAndFontSizeAndLogoSize =
      'clickHereToChangePrintSettingLikeWidthAndFontSizeAndLogoSize';

  static String dailySalesReport = 'dailySalesReport';
  static String failedToCaptureData = 'failedToCaptureData';
  static String pleaseSelectPrinterAndTryAgain =
      'pleaseSelectPrinterAndTryAgain';
  static String pleaseWaitUntilPrintFinished = 'pleaseWaitUntilPrintFinished';
  static String visitWasAddedSuccessfully = 'visitWasAddedSuccessfully';
  static String visitWasAddedToLocalSuccessfully =
      'visitWasAddedToLocalSuccessfully';
  static String failedToAddvisit = 'failedToAddvisit';
  static String failedToPrintPage = 'failedToPrintPage';
  static String pageWasPrintedSuccessFully = 'pageWasPrintedSuccessFully';
  static String paid = 'paid';
  static String voucherId = 'voucherId';
  static String mySignature = 'mySignature';
  static String balanceBefore = 'balanceBefore';
  static String balanceAfter = 'balanceAfter';
  static String paydBy = 'paydBy';
  static String exchange = 'exchange';
  static String pm = 'pm';
  static String am = 'am';
  static String symbol = 'symbol';
  static String rate = 'rate';
  static String disconnect = 'disconnect';
  static String print = 'print';
  static String fontSize = 'fontSize';
  static String printWidth = 'printWidth';
  static String refresh = 'refresh';
  static String logoSize = 'logoSize';
  static String printPage = 'printPage';
  static String receiver = 'receiver';
  static String failedToAddVisit = 'failedToAddVisit';
  static String customer = 'customer';
  static String reprsentative = 'reprsentative';
  static String reciveInvoice = 'reciveInvoice';
  static String generalLedgerReport = 'generalLedgerReport';
  static String endDate = 'endDate';
  static String startDate = 'startDate';
  static String end = 'end';
  static String emptyEmpty = 'emptyEmpty';
  static String operationFalied = 'operationFalied';
  static String export = 'export';
  static String accountStatments = 'accountStatments';
  static String fileWasSavedIn = 'fileWasSavedIn';
  static String appHavenotAccessToFiles = 'appHavenotAccessToFiles';
  static String open = 'open';
  static String series = 'series';
  static String date = 'date';
  static String current = 'current';
  static String debit = 'debit';
  static String balance = 'balance';
  static String voucherType = "voucherType";
  static String postingDate = "postingDate";
  static String credit = "credit";
  static String remarks = "remarks";
  static String loadedSuccessfully = 'loadedSuccessfully';
  static String customerSavedToTheDeviceSyncLater =
      'customerSavedToTheDeviceSyncLater';
  static String failedToLoad = 'failedToLoad';
  static String dataLoadedSuccessfully = 'dataLoadedSuccessfully';
  static String itemGroups = 'itemGroups';
  static String defaultCurrency = 'defaultCurrency';
  static String youDontHavLocalDataToSync = 'youDontHavLocalDataToSync';
  static String internetConnectionWasBack = 'internetConnectionWasBack';
  static String internetConnectionWasLost = 'internetConnectionWasLost';
  static String dataWasSyncedSuccessfully = 'dataWasSyncedSuccessfully';
  static String ignore = 'ignore';
  static String failedToSyncAllData = 'failedToSyncAllData';
  static String retryLater = 'retryLater';
  static String allow = 'allow';
  static String skip = 'skip';
  static String youCanSwapRightToDeleteOrder = 'youCanSwapRightToDeleteOrder';
  static String areYouSureoEmptyCart = 'areYouSureoEmptyCart';
  static String areYouSureToSaveThisPayment = 'areYouSureToSaveThisPayment';
  static String edit = 'edit';
  static String moreOptions = 'moreOptions';
  static String updateCustomerLocation = 'updateCustomerLocation';
  static String offlineData = 'offlineData';
  static String sellOrder = 'sellOrder';
  static String updateLocation = 'updateLocation';
  static String phoneNo = 'phoneNo';
  static String cellPhone = 'cellPhone';
  static String selectMap = 'selectMap';
  static String km = 'km';
  static String newCustomers = 'newCustomers';
  static String openingAccount = 'openingAccount';
  static String numberOfOrders = 'numberOfOrders';
  static String discount = 'discount';
  static String nearest = 'nearest';
  static String dueDate = 'dueDate';
  static String call = 'call';
  static String result = 'result';
  static String subject = 'subject';
  static String target = 'target';
  static String acheived = 'acheived';
  static String all = 'all';
  static String today = 'today';
  static String report = 'report';
  static String targetOverviewChart = 'targetOverviewChart';
  static String askForDelete = 'askForDelete';
  static String execute = 'execute';
  static String information = 'information';
  static String goThere = 'goThere';
  static String selles = 'selles';
  static String salesTarget = 'salesTarget';
  static String creditCollectionTarget = 'creditCollectionTarget';
  static String paymentTermDetalis = 'paymentTermDetalis';
  static String contactPersonFullName = 'contactPersonFullName';
  static String contactNumber = 'contactNumber';
  static String mobileNo = 'mobileNo';
  static String exchangeRateIsNotFoundForSelectedCurrecny =
      'exchangeRateIsNotFoundForSelectedCurrecny';
  static String emptyOrder = 'emptyOrder';
  static String orginaizationName = 'orginaizationName';
  static String customerProfile = 'customerProfile';
  static String price = 'price';
  static String invoices = 'invoices';
  static String viewInvoices = 'viewInvoices';
  static String netTotal = 'netTotal';
  static String customerGroup = 'customerGroup';
  static String addNote = 'addNote';
  static String territory = 'territory';
  static String territories = 'territories';
  static String location = 'location';
  static String retrunSellOrder = 'retrunSellOrder';
  static String areYouSureToCloseApp = 'areYouSureToCloseApp';
  static String filterBy = 'filterBy';
  static String priceList = 'priceList';
  static String dailyPerformance = 'dailyPerformance';
  static String targetPerformance = 'targetPerformance';
  static String stock = 'stock';
  static String collection = 'collection';
  static String items = 'items';
  static String priceListIsEmpty = 'priceListIsEmpty';
  static String customers = 'customers';
  static String address = 'address';
  static String soFarFromCustomer = 'soFarFromCustomer';
  static String canNotGetTheCurrentLocationRetryAgain =
      'canNotGetTheCurrentLocationRetryAgain';
  static String addOrder = 'addOrder';
  static String pleaseEnableGpsToContinue = 'pleaseEnableGpsToContinue';
  static String appHasNotAccessToLocation = 'appHasNotAccessToLocation';
  static String addCheck = 'addCheck';
  static String failedToDeleteCustomer = 'failedToDeleteCustomer';
  static String failedToAddCustomer = 'failedToAddCustomer';
  static String failedToOrder = 'failedToOrder';
  static String failedToEditCustomer = 'failedToEditCustomer';
  static String customerwasUpdated = 'customerwasUpdated';
  static String customerwasAdded = 'customerwasAdded';
  static String customerWasDeleted = 'customerWasDeleted';
  static String addCustomer = 'addCustomer';
  static String updateCustomer = 'updateCustomer';
  static String deleteCustomer = 'deleteCustomer';
  static String firstName = 'firstName';
  static String retry = 'retry';
  static String middleName = 'middleName';
  static String lastName = 'lastName';
  static String pullDownToRefresh = 'pullDownToRefresh';
  static String homeScreen = 'homeScreen';
  static String noDataFound = 'noDataFound';
  static String failedLoadData = 'failedLoadData';
  static String email = 'email';
  static String appHasNotAccessToCamera = 'appHasNotAccessToCamera';
  static String appHasNotAccessToAlbum = 'appHasNotAccessToAlbum';
  static String login = 'login';
  static String phone = 'phone';
  static String delete = 'delete';
  static String gallery = 'gallery';
  static String camera = 'camera';
  static String selectImage = 'selectImage';
  static String profile = 'profile';
  static String cropImage = 'cropImage';
  static String username = 'username';
  static String password = 'password';
  static String personInfomations = 'personInfomations';
  static String newPasswordIsSameToOldPasswrd = 'newPasswordIsSameToOldPasswrd';
  static String confirmPasswrod = 'confirmPasswrod';
  static String newPassword = 'newPassword';
  static String oldPassword = 'oldPassword';
  static String tooShort = 'tooShort';
  static String changePassword = 'changePassword';
  static String newPasswordNotMatchWithConferm =
      'newPasswordNotMatchWithConferm';
  static String version = 'version';
  static String required = 'required';
  static String loginFalied = 'loginFalied';
  static String faliedUpdatePassword = 'faliedUpdatePassword';
  static String faliedUpdatePasswordRetryAgain =
      'faliedUpdatePasswordRetryAgain';
  static String worngPassword = 'worngPassword';
  static String passwordWasUpdatedSuccessFully =
      'passwordWasUpdatedSuccessFully';
  static String sellPoint = 'sellPoint';
  static String checkYourInternetConnectionAndRetry =
      'checkYourInternetConnectionAndRetry';
  static String unKnownErrorPleaseRelogin = 'unKnownErrorPleaseRelogin';
  static String success = 'success';
  static String failed = 'failed';
  static String personalInformationWasUpdated = 'personalInformationWasUpdated';
  static String faliedUpdatePersonalInformation =
      'faliedUpdatePersonalInformation';
  static String operationFailedUnKnownError = 'operationFailedUnKnownError';
  static String operaionFailed = 'operaionFailed';
  static String youAreNotAuthorizedReloginAndRetryAgain =
      'youAreNotAuthorizedReloginAndRetryAgain';
  static String yes = 'yes';
  static String areYouSureToLogOut = 'areYouSureToLogOut';
  static String areYouSureToContinues = 'areYouSureToContinues';
  static String no = 'no';
  static String customerName = 'customerName';
  static String contactPerson = 'contactPerson';
  static String editCustomer = 'editCustomer';
  static String addNewCustomer = 'addNewCustomer';
  static String customerNameIsRequired = 'customerNameIsRequired';
  static String contactPersonIsRequired = 'contactPersonIsRequired';
  static String fullAddressIsRequired = 'fullAddressIsRequired';
  static String currencyIsRequired = 'currencyIsRequired';
  static String customerAddSuccessfully = 'customerAddSuccessfully';
  static String pleaseCheckYourInternet = 'pleaseCheckYourInternet';
  static String yourCustomerIsAlreadyExist = 'yourCustomerIsAlreadyExist';
  static String somethingWentWrongPleaseTryAgain =
      'somethingWentWrongPleaseTryAgain';
  static String phoneNumberIsRequired = 'phoneNumberIsRequired';
  static String phoneNumber = 'phoneNumber';
  static String fullAddress = 'fullAddress';
  static String search = 'search';
  static String save = 'save';
  static String salesOrder = 'salesOrder';
  static String creditCollection = 'creditCollection';
  static String orderBy = 'orderBy';
  static String noneVisited = 'noneVisited';
  static String inactiveSalesWise = 'inactiveSalesWise';
  static String clear = 'clear';
  static String applyFilter = 'applyFilter';
  static String reasons = 'reasons';
  static String notPresent = 'notPresent';
  static String doesntWant = 'doesntWant';
  static String creditOverdue = 'creditOverdue';
  static String closed = 'closed';
  static String extraNotes = 'extraNotes';
  static String checkOut = 'checkOut';
  static String syncData = 'syncData';
  static String sync = 'sync';
  static String syncVouchers = 'syncVouchers';
  static String logOut = 'logOut';
  static String warning = 'warning';
  static String yourDataWillBeDeletedAreYouSure =
      'yourDataWillBeDeletedAreYouSure';
  static String cancel = 'cancel';
  static String ok = 'ok';
  static String userProfile = 'userProfile';
  static String orders = 'orders';
  static String qty = 'qty';
  static String uom = 'uom';
  static String note = 'note';
  static String add = 'add';
  static String addedToCart = 'addedToCart';
  static String total = 'total';
  static String cart = 'cart';
  static String deliveryDate = 'deliveryDate';
  static String paymentDate = 'paymentDate';
  static String signature = 'signature';
  static String theCartIsEmptyAddItemsAndTryAgain =
      'theCartIsEmptyAddItemsAndTryAgain';
  static String backToShopping = 'backToShopping';
  static String payments = 'payments';
  static String payment = 'payment';
  static String currency = 'currency';
  static String usd = 'USD';
  static String iqd = 'IQD';
  static String amount = 'amount';
  static String exchangeRate = 'exchangeRate';
  static String remaining = 'remaining';
  static String yourOrderHasBeenSubmitedToPos = 'yourOrderHasBeenSubmitedToPos';
  static String yourOrderSavedToTheDeviceSyncLater =
      'yourOrderSavedToTheDeviceSyncLater';
  static String yourPaymentHasBeenSubmitedToPos =
      'yourPaymentHasBeenSubmitedToPos';
  static String yourPaymentSavedToTheDeviceSyncLater =
      'yourPaymentSavedToTheDeviceSyncLater';
  static String reports = 'reports';
  static String inactivePaymentWise = 'inactivePaymentWise';
  static String durationInMins = "durationInMins";
}

String _translateFun(context, String str, bool? capital,
    {List<dynamic> args = const []}) {
  final currentContext = context ?? getItClient<AppConfigurationService>().navigatorKey.currentContext;
  if (ValidatorService.checkIsNullOrEmpty(AppLocalizations.of(currentContext!)?.translate(str))) {
    //Split key by uppercase letter and rejoin them
    final beforeCapitalLetter = RegExp(r"(?=[A-Z])");
    logger("str $str args $args");
    var parts = str.split(beforeCapitalLetter);
    return "${parts.join(" ").toLowerCase().capitalize(capital)} ${args.join(" ")}";
  } else {
    String s = AppLocalizations.of(currentContext!)!
        .translate(str)
        .capitalize(capital);
    for (int i = 0; i < args.length; i++) {
      s = s.replaceFirst("{args}", args[i]);
    }
    return s.replaceAll("{args}", "");
  }
}

extension StringExtension on String {
  String capitalize(bool? capital) {
    if (isEmpty || capital != true) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String trans({BuildContext? context, bool? capital, List<dynamic>? args}) {
    return _translateFun(context, this, capital ?? true, args: args ?? []);
  }

  String getHM() {
    final list = split(":");
    logger("listlistlist $list");
    return "${list.first}:${(list.length > 1) ? (list[1]) : ""}";
  }
}
