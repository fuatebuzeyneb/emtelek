class EndPoints {
  static String baseUrl = "https://emtelek.com/api/";
  static String signIn = "clients/login";
  static String signUp = "clients/signup";
  static String adsAdd = "ads/add";
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  static String emtelekAuthUsername =
      'IIdJEQKxY!CBKnybLaTGqq?2dOZasq95Iqhyh2e6KClkcR3tOb5ewNyXftV-Pawo';
  static String emtelekAuthPass =
      'QRpmsnr4ma//DwKvNic=uqyix1!9IjwJMWUUTM3rA01zgN1jHrU-N9pY818!kG0o';
  static String status = 'status';
  static String errorMessage = 'msg';
  static String email = 'email';
  static String password = 'password';
  static String token = 'token';
  static String id = 'id';
  static String message = 'message';
  static String profilePic = 'profilePic';
  static String name = 'name';
  static String phone = 'phone';
  static String location = 'location';
  static String confirmPassword = 'confirmPassword';
}
