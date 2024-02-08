class AzureB2cConfig {
  static const clientId = '1689eb93-8b4f-476f-bb17-8889533e4c65';
  static const redirectURL = 'com.trendit.mytaraji://oauthredirect';
  static const discoveryURL =
      'https://mytarajjib2c.b2clogin.com/myTarajjiB2c.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_mytarajji_signup_signin';
  static const List<String> scopes = [
    'https://myTarajjiB2c.onmicrosoft.com/myTarajjiBackAPI/access_as_user',
    'https://myTarajjiB2c.onmicrosoft.com/myTarajjiBackAPI/tasks.write',
    'https://myTarajjiB2c.onmicrosoft.com/myTarajjiBackAPI/tasks.read',
    'openid',
  ];
}
