enum QuestionType {
  socialMediaAction,
  numberVerification,
  emailVerification,
}

extension QuestionTypeExtension on QuestionType {
  String get value {
    switch (this) {
      case QuestionType.socialMediaAction:
        return "socialmediaaction";
      case QuestionType.numberVerification:
        return "number-verification";
      case QuestionType.emailVerification:
        return "email-verification";
    }
  }
}
