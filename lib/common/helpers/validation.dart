abstract class Validation {
  String? validate(String? value);
}

class ValidationConstants {
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  static const String passwordRegex = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';

  static const String emailEmpty = 'Email address is required';
  static const String emailInvalid = 'Please enter a valid email address';
  static const String passwordEmpty = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 8 characters long';
  static const String passwordWeak = 'Password must include letters, numbers, and special characters';
}

class EmailValidation extends Validation {
  @override
  String? validate(String? value) {
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return ValidationConstants.emailEmpty;
    }

    if (!RegExp(ValidationConstants.emailRegex).hasMatch(trimmedValue)) {
      return ValidationConstants.emailInvalid;
    }

    return null;
  }
}

class PasswordValidation extends Validation {
  @override
  String? validate(String? value) {
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return ValidationConstants.passwordEmpty;
    }

    final strength = getPasswordStrength(trimmedValue);
    if (strength != PasswordStrength.strong) {
      return strength.message;
    }

    return null;
  }

  PasswordStrength getPasswordStrength(String value) {
    if (value.length < 8) return PasswordStrength.tooShort;
    if (!RegExp(r'[A-Za-z]').hasMatch(value)) return PasswordStrength.noLetters;
    if (!RegExp(r'\d').hasMatch(value)) return PasswordStrength.noNumbers;
    if (!RegExp(r'[@$!%*#?&]').hasMatch(value)) return PasswordStrength.noSpecial;
    return PasswordStrength.strong;
  }
}

enum PasswordStrength {
  tooShort('Too short'),
  noLetters('Add letters'),
  noNumbers('Add numbers'),
  noSpecial('Add special characters'),
  strong('Strong');

  final String message;
  const PasswordStrength(this.message);
}