import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:static_i18n/static_i18n.dart';

import 'app_locales.dart';
import 'translation_keys.dart';

@injectable
class AppTranslations extends Translations {
  @override
  Map<Locale, Map<String, String>> get keys => <Locale, Map<String, String>>{
        AppLocales.localeKa: _kaGe,
      };

  final Map<String, String> _kaGe = <String, String>{
    TkCommon.signIn: 'ავტორიზაცია',
    TkCommon.signUp: 'რეგისტრაცია',
    TkCommon.and: 'და',
    TkCommon.lastUpdatedAt: 'ბოლოს განახლდა %1',
    TkCommon.continue_: 'გაგრძელება',
    TkCommon.all: 'ყველა',
    TkCommon.ok: 'კარგი',
    TkCommon.confirm: 'დადასტურება',
    TkCommon.cancel: 'გაუქმება',
    TkCommon.captionCodeSent: 'კოდი გამოგზავნილია',
    TkCommon.delete: 'წაშლა',
    TkCommon.edit: 'რედაქტირება',
    TkCommon.notesNotFound: 'ჩანაწერები ვერ მოიძებნა',
    TkCommon.back: 'უკან',
    TkCommon.save: 'შენახვა',
    TkCommon.send: 'გაგზავნა',
    TkCommon.close: 'დახურვა',
    TkCommon.openSettings: 'პარამეტრების გახსნა',
    TkCommon.feedback: 'უკუკავშირი',
    TkCommon.secondsShort: 'წმ',
    TkCommon.buy: 'ყიდვა',
    TkCommon.attention: 'ყურადღება',
    TkCommon.attachImage: 'სურათის მიმაგრება',
    TkCommon.notification: 'შეტყობინება',
    TkCommon.help: 'დახმარება',
    TkCommon.viewsWithCount: '%1 ნახვა',
    TkCommon.read: 'წაკითხვა',
    TkCommon.notFound: 'ვერ მოიძებნა',
    TkCommon.support: 'სერვისი',
    TkCommon.navigate: 'გადასვლა',
    TkCommon.loading: 'იტვირთება',
    TkCommon.image: 'სურათი',
    TkError.unknown: 'უცნობი პრობლემა',
    TkError.network: 'ქსელის პრობლემა, გთხოვთ შეამოწმოთ კავშირი ინტერნეტთან',
    TkError.invalidEmailOrPassword: 'მოცემული ელ. ფოსტა ან პაროლი არასწორია',
    TkError.emailAlreadyInUse: 'მოცემული ელ. ფოსტა უკვე რეგისტრირებულია',
    TkError.userNotFoundWithEmail: 'მოცემული ელ. ფოსტით მომხმარებელი ვერ მოიძებნა',
    TkError.invalidVerificationCode: 'ვერიფიკაციის კოდი არასწორია',
    TkError.recoverPasswordRequestNotFound: 'პაროლის აღდგენის მოთხოვნა ვერ მოიძებნა',
    TkError.recoverPasswordRequestTimedOut:
        'პაროლის აღდგენის მოთხოვნას გაუვიდა ვადა, გთხოვთ დაიწყოთ პროცესი ხელახლა',
    TkError.recoverPasswordRequestNotVerified: 'პაროლის მოთხოვნა არ არის დადასტურებული',
    TkError.noteNotFound: 'ჩანაწერი ვერ მოიძებნა',
    TkError.noteNotYours: 'ჩანაწერი თქვენ არ გეკუთვნით',
    TkError.chapterNotFound: 'ნაწარმოების თავი ვერ მოიძებნა',
    TkError.adminUserCantSignIn: 'ადმინს არ შეუძლია აპლიკაციაში შესვლა',
    TkSuccess.passwordChanged: 'პაროლი შეიცვალა წარმატებით',
    TkSuccess.allBookmarksDeleted: 'სანიშნები წაიშალა წარმატებით',
    TkSuccess.allNotesDeleted: 'ჩანაწერები წაიშალა წარმატებით',
    TkSuccess.noteDeleted: 'ჩანაწერი წაიშალა წარმატებით',
    TkSuccess.sentSuccessfully: 'წარმატებით გაიგზავნა',
    TkFieldHint.emailAddress: 'ელ. ფოსტა',
    TkFieldHint.username: 'სახელი',
    TkFieldHint.password: 'პაროლი',
    TkFieldHint.newPassword: 'ახალი პაროლი',
    TkFieldHint.repeatPassword: 'გაიმეორეთ პაროლი',
    TkFieldHint.fullName: 'სრული სახელი',
    TkFieldHint.genderOptional: 'სქესი (არასავალდებულო)',
    TkFieldHint.title: 'სათაური',
    TkFieldHint.startTyping: 'დაიწყეთ წერა...',
    TkFieldHint.searchDots: 'ძიება...',
    TkFieldHint.genre: 'ჟანრი',
    TkFieldHint.creation: 'ნაწარმოები',
    TkFieldHint.writeToUs: 'მოგვწერეთ...',
    TkFieldHint.notification: 'შეტყობინება',
    TkValidationError.fieldIsRequired: 'მითითება სავალდებულოა',
    TkValidationError.invalidEmail: 'ელ. ფოსტის ფორმა არასწორია',
    TkValidationError.emailContainsWhitespace: 'ელ. ფოსტა არ უნდა შეიცავდეს ცარიელ სივრცეს',
    TkValidationError.emailIsTooLong: 'ელ. ფოსტა უნდა შეიცავდეს მაქსიმუმ 255 სიმბოლოს',
    TkValidationError.passwordIsTooShort: 'პაროლი უნდა შეიცავდეს მინიმუმ 6 სიმბოლოს',
    TkValidationError.passwordIsTooLong: 'პაროლი უნდა შეიცავდეს მაქსიმუმ 255 სიმბოლოს',
    TkValidationError.passwordContainsWhitespace: 'პაროლი არ უნდა შეიცავდეს ცარიელ სივრცეს',
    TkValidationError.repeatedPasswordDoesNotMatch: 'გამეორებული პაროლი არ ემთხვევა',
    TkValidationError.nameIsTooShort: 'სახელი უნდა შეიცავდეს მინიმუმ 2 სიმბოლოს',
    TkValidationError.nameIsTooLong: 'სახელი უნდა შეიცავდეს მაქსიმუმ 255 სიმბოლოს',
    TkValidationError.invalidVerificationCode: 'ვერიფიკაციის კოდი უნდა იყოს 5 სიმბოლო',
    TkValidationError.textIsTooLong: 'ტექსტი უნდა შეიცავდეს მაქსიმუმ 255 სიმბოლოს',
    TkStatus.storagePermissionDenied: 'დართეთ წვდომა მეხსიერებასთან, რათა შეძლოთ სურათების ატვირთვა',
    TkStatus.storagePermissionPermanentlyDenied:
        'მეხსიერებასთან წვდომის მოთხოვნა უარყოფილია, თუკი გსურთ რომ შეძლოთ სურათების ატვირთვა, დართეთ ნებართვა აპლიკაციის პარამეტრებიდან.',
    TkStatus.resendVerificationCodeInfo:
        'არ მიგიღიათ კოდი? მოითხოვეთ ახალი @seconds წამში. მიღებული კოდით გაგრძელება შესაძლებელია მხოლოდ 30 წუთის განმავლობაში.',
  };
}
