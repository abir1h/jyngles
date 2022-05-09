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
}
