import 'package:common_models/common_models.dart';
import 'package:static_i18n/static_i18n.dart';

import '../translation_keys.dart';

extension EmailExt on Email {
  String? translateFailure() {
    return failureToString(
      (EmailFailure l) => l.when(
        empty: () => TkValidationError.fieldIsRequired.i18n,
        invalid: () => TkValidationError.invalidEmail.i18n,
        tooLong: () => TkValidationError.emailIsTooLong.i18n,
        containsWhitespace: () => TkValidationError.emailContainsWhitespace.i18n,
      ),
    );
  }
}

extension VerificationCodeExt on VerificationCode {
  String? translateFailure() {
    return failureToString(
      (ValueFailure l) => l.when(
        empty: () => TkValidationError.fieldIsRequired.i18n,
        invalid: () => TkValidationError.invalidVerificationCode.i18n,
      ),
    );
  }
}

extension SimpleContentValueExt on SimpleContentValue {
  String? translateFailure() {
    return failureToString(
      (SimpleContentValueFailure l) => l.when(
        empty: () => TkValidationError.fieldIsRequired.i18n,
        tooLong: () => TkValidationError.textIsTooLong.i18n,
      ),
    );
  }
}

extension NameExt on Name {
  String? translateFailure() {
    return failureToString(
      (NameFailure l) => l.when(
        empty: () => TkValidationError.fieldIsRequired.i18n,
        tooShort: () => TkValidationError.nameIsTooShort.i18n,
        tooLong: () => TkValidationError.nameIsTooLong.i18n,
      ),
    );
  }
}

extension PasswordExt on Password {
  String? translateFailure() {
    return failureToString(
      (PasswordFailure l) => l.maybeWhen(
        empty: () => TkValidationError.fieldIsRequired.i18n,
        tooShort: () => TkValidationError.passwordIsTooShort.i18n,
        tooLong: () => TkValidationError.passwordIsTooLong.i18n,
        orElse: () => null,
      ),
    );
  }
}

extension RepeatedPasswordExt on RepeatedPassword {
  String? translateFailure() {
    return failureToString(
      (RepeatedPasswordFailure l) => l.when(
        empty: () => TkValidationError.fieldIsRequired.i18n,
        doesNotMatch: () => TkValidationError.repeatedPasswordDoesNotMatch.i18n,
      ),
    );
  }
}
