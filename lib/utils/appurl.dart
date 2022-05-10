class AppUrl {
  static const String liveBaseURL = "http://mamun.click/api/";
  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "login";
  static const String reg = baseURL + "register";
  static const String otp = baseURL + 'otp';
  static const String homePage = baseURL + 'auth/homepage';

  static const String showExpence = baseURL + 'auth/expense/show';
  static const String showIncome = baseURL + 'auth/income/show';
  static const String addIncome = baseURL + 'auth/income/post';
  static const String addExpence = baseURL + 'auth/expense/post';

  static const String sendPhoneNumber = baseURL + 'forget/password';
  static const String changePassword = baseURL + 'forget/password/verify';
  static const String resetPassword = baseURL + 'auth/change/password';

  static const String deleteIncome = baseURL + 'auth/income/delete/';
  static const String deleteExpense = baseURL + 'auth/expense/delete/';

  static const String editIncome = baseURL + 'auth/income/edit/';
  static const String editExpense = baseURL + 'auth/expense/edit/';

  static const String editProfile = baseURL + 'auth/profile/edit';

  static const String goalShow = baseURL + 'auth/goal/show';
  static const String debtShow = baseURL + 'auth/debt/show';

  static const String goalAdd = baseURL + 'auth/goal/post';
  static const String debtAdd = baseURL + 'auth/debt/post';
}
