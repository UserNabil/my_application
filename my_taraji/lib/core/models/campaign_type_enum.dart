enum QuestionType {
  socialMediaAction,
  phoneVerification,
  emailVerification,
  number,
  textarea,
  datepicker,
  leadGeneration,
  select,
  rating,
  toggle,
  calculated,
  smiley
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
      case QuestionType.leadGeneration:
        return "lead-generation";
      case QuestionType.select:
        return "select";
      case QuestionType.rating:
        return "rating";
      case QuestionType.toggle:
        return "toggle";
      case QuestionType.calculated:
        return "calculated";
      case QuestionType.smiley:
        return "smiley";
    }
  }
}
