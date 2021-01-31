
const COUNTRY_ISO = "CI";

class Constants{


  static final String MAIN_FONT_FAMILY = "Montserrat";

  static bool isInDebugMode  = true;

  static final String BASE_URL = "https://backend.dix.adjemincloud.com";
  static final String API_URL = "https://backend.dix.adjemincloud.com/api/";


  static final String ADJEMINPAY_API_KEY = "eyJpdiI6IkpNQ05tWmtGc0FVbWc1VFhFM";
  static final String ADJEMINPAY_APPLICATION_ID = "99f99e";
  static final String ADJEMINPAY_NOTIFICATION_URL = "${API_URL}invoice_payments_adjeminpay_notify";


  static final CINET_PAY_API_KEY = "18122291995d9845221e7d53.99745292";
  static final CINET_PAY_SITE_ID = 182538;
  static final CINET_PAY_NOTIFICATION_URL =  '${API_URL}invoice_payments_notify';


  static const DOMAIN_URL = "https://dix.ci";
  static const String ADJEMIN_ANDROID = "https://adjem.in/AdjeminAndroid";
  static const String ADJEMIN_IOS = "https://adjem.in/AdjeminIOS";
  static const String TERMS = DOMAIN_URL + "/terms";


  static const String VERSION_NAME = "1.7.5";







}