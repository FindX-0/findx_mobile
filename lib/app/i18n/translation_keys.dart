// ignore_for_file: avoid_field_initializers_in_const_classes

abstract class TkCommon {
  static const String signIn = 'TkCommon.signIn';
  static const String signUp = 'TkCommon.signUp';
  static const String and = 'TkCommon.and';
  static const String lastUpdatedAt = 'TkCommon.lastUpdatedAt';
  static const String continue_ = 'TkCommon.continue';
  static const String all = 'TkCommon.all';
  static const String ok = 'TkCommon.ok';
  static const String confirm = 'TkCommon.confirm';
  static const String cancel = 'TkCommon.cancel';
  static const String captionCodeSent = 'TkCommon.captionCodeSent';
  static const String delete = 'TkCommon.delete';
  static const String edit = 'TkCommon.edit';
  static const String notesNotFound = 'TkCommon.notesNotFound';
  static const String back = 'TkCommon.back';
  static const String save = 'TkCommon.save';
  static const String send = 'TkCommon.send';
  static const String close = 'TkCommon.close';
  static const String openSettings = 'TkCommon.openSettings';
  static const String feedback = 'TkCommon.feedback';
  static const String secondsShort = 'TkCommon.secondsShort';
  static const String buy = 'TkCommon.buy';
  static const String attention = 'TkCommon.attention';
  static const String attachImage = 'TkCommon.attachImage';
  static const String notification = 'TkCommon.notification';
  static const String help = 'TkCommon.help';
  static const String viewsWithCount = 'TkCommon.viewsWithCount';
  static const String read = 'TkCommon.read';
  static const String notFound = 'TkCommon.notFound';
  static const String support = 'TkCommon.support';
  static const String navigate = 'TkCommon.navigate';
  static const String loading = 'TkCommon.loading';
  static const String image = 'TkCommon.image';
}

abstract class TkError {
  static const String unknown = 'TkError.unknown';
  static const String network = 'TkError.network';
  static const String invalidEmailOrPassword = 'TkError.invalidEmailOrPassword';
  static const String emailAlreadyInUse = 'TkError.emailAlreadyInUse';
  static const String userNotFoundWithEmail = 'TkError.userNotFoundWithEmail';
  static const String invalidVerificationCode = 'TkError.invalidVerificationCode';
  static const String recoverPasswordRequestNotFound = 'TkError.recoverPasswordRequestNotFound';
  static const String recoverPasswordRequestTimedOut = 'TkError.recoverPasswordRequestTimedOut';
  static const String recoverPasswordRequestNotVerified = 'TkError.recoverPasswordRequestNotVerified';
  static const String noteNotFound = 'TkError.noteNotFound';
  static const String noteNotYours = 'TkError.noteNotYours';
  static const String chapterNotFound = 'TkError.chapterNotFound';
  static const String adminUserCantSignIn = 'TkError.adminUserCantSignIn';
}

abstract class TkSuccess {
  static const String passwordChanged = 'TkSuccess.passwordChanged';
  static const String allBookmarksDeleted = 'TkSuccess.allBookmarksDeleted';
  static const String allNotesDeleted = 'TkSuccess.allNotesDeleted';
  static const String noteDeleted = 'TkSuccess.noteDeleted';
  static const String sentSuccessfully = 'TkSuccess.sentSuccessfully';
}

abstract class TkFieldHint {
  static const String emailAddress = 'TkFieldHint.emailAddress';
  static const String username = 'TkFieldHint.username';
  static const String password = 'TkFieldHint.password';
  static const String newPassword = 'TkFieldHint.newPassword';
  static const String repeatPassword = 'TkFieldHint.repeatPassword';
  static const String fullName = 'TkFieldHint.fullName';
  static const String genderOptional = 'TkFieldHint.genderOptional';
  static const String title = 'TkFieldHint.title';
  static const String startTyping = 'TkFieldHint.startTyping';
  static const String searchDots = 'TkFieldHint.searchDots';
  static const String genre = 'TkFieldHint.genre';
  static const String creation = 'TkFieldHint.creation';
  static const String writeToUs = 'TkFieldHint.writeToUs';
  static const String notification = 'TkFieldHint.notification';
}

abstract class TkValidationError {
  static const String fieldIsRequired = 'TkValidationError.fieldIsRequired';
  static const String invalidEmail = 'TkValidationError.invalidEmail';
  static const String emailContainsWhitespace = 'TkValidationError.emailContainsWhitespace';
  static const String emailIsTooLong = 'TkValidationError.emailIsTooLong';
  static const String passwordIsTooShort = 'TkValidationError.passwordIsTooShort';
  static const String passwordIsTooLong = 'TkValidationError.passwordIsTooLong';
  static const String passwordContainsWhitespace = 'TkValidationError.passwordContainsWhitespace';
  static const String repeatedPasswordDoesNotMatch = 'TkValidationError.repeatedPasswordDoesNotMatch';
  static const String nameIsTooShort = 'TkValidationError.nameIsTooShort';
  static const String nameIsTooLong = 'TkValidationError.nameIsTooLong';
  static const String invalidVerificationCode = 'TkValidationError.invalidVerificationCode';
  static const String textIsTooLong = 'TkValidationError.textIsTooLong';
}

abstract class TkStatus {
  static const String storagePermissionDenied = 'TkStatus.storagePermissionDenied';
  static const String storagePermissionPermanentlyDenied = 'TkStatus.storagePermissionPermanentlyDenied';
  static const String resendVerificationCodeInfo = 'TkStatus.resendVerificationCodeInfo';
}
