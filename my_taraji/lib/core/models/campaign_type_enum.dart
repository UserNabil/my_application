enum QuestionType {
  socialMediaAction,
  phoneVerification,
  emailVerification,
  number,
  textarea,
  datepicker
}

extension QuestionTypeExtension on QuestionType {
  String get value {
    switch (this) {
      case QuestionType.socialMediaAction:
        return "socialmediaaction";
      case QuestionType.phoneVerification:
        return "number-verification";
      case QuestionType.emailVerification:
        return "email-verification";
      case QuestionType.number:
        return "number";
      case QuestionType.textarea:
        return "textarea";
      case QuestionType.datepicker:
        return "datePicker";
    }
  }
}
