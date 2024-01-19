class Errors{
  const Errors();

  static const String loginValidationError = 'Username or Password cannot be empty';
  static const String loginError = 'Authentication Failed';
  static const String unforseenException = 'Something went wrong';
  static const String connectionError = 'Connection Error, Please check your Internet';

  static const String searchFieldError = 'Search field cannot be empty';
}
class Success{
  const Success();

  static const String loginSuccess = 'Login Successful';
}