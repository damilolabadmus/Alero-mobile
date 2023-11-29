class Errors{
  const Errors();

  static const String loginValidationError = 'Username or Password cannot be empty';
  static const String loginError = 'Authentication Failed';
  static const String unforseenException = 'Something went wrong';
  static const String connectionError = 'Connection Error, Please check your Internet';

  static const String searchFieldError = 'Search field cannot be empty';
  static const String nullInputError = 'Please select a customer in the dashboard';
  static const String nullSearchError = 'Please use the search box in the dashboard';
}
class Success{
  const Success();

  static const String loginSuccess = 'Login Successful';
}