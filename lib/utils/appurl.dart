class AppUrl {
  static const String liveBaseURL = "https://jyngles-app.com/api/";
  static const String baseURL = liveBaseURL;
  static const String picurl = 'https://jyngles-app.com/';
  static const String login = baseURL + "login";
  static const String reg = baseURL + "register";
  static const String policy = baseURL + "policy";
  static const String otp = baseURL + 'otp';
  static const String otp_resend = baseURL + 'resend-otp';
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
  static const String profiel_show = baseURL + 'auth/profile/show';
  static const String notification = baseURL + 'auth/in/app/notification-count';

  static const String goalAdd = baseURL + 'auth/goal/post';
  static const String debtAdd = baseURL + 'auth/debt/post';

  static const String goalEdit = baseURL + 'auth/goal/post/edit/';
  static const String debtEdit = baseURL + 'auth/debt/post/edit/';
  static const String debt_delete = baseURL + 'auth/debt/post/delete/';
  static const String goal_delete = baseURL + 'auth/goal/post/delete/';
  static const String calender_show = baseURL + 'auth/calender/show';
  static const String calender_post_edit = baseURL + 'auth/calender/post/edit/';
  static const String calader_delete = baseURL + 'auth/calender/post/delete/';
  static const String calender_post = baseURL + 'auth/calender/post';
  static const String calender_show_search= baseURL + 'auth/calender/date/';
  static const String tax_show= baseURL + 'auth/tax/show';
  static const String taxt_post= baseURL + 'auth/tax/post';
  static const String home= baseURL + 'auth/dashboard/details';
  static const String bug_details= baseURL + 'auth/report-bug/post';
  static const String monthly= baseURL + 'auth/report/details/';
  static const String catagory= baseURL + 'auth/show/category/';
  static const String chart= baseURL + 'auth/sub-dashboard/';
  static const String compare= baseURL + 'auth/compare/report/details/';
  static const String notification_post= baseURL + 'auth/in/app/notification-post';
  static const String add_child= baseURL + 'auth/add/child/user';
  static const String show_child= baseURL + 'auth/show/child/user';
  static const String package= baseURL + 'auth/package/show';
  static const String google_login= baseURL + 'google-login';
  static const String facebook_login= baseURL + 'facebook-login';

}
