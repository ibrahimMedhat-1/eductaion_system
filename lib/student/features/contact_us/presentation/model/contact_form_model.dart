class ContactFormModel {
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String letter;

  ContactFormModel(this.name, this.email, this.phone, this.subject, this.letter);

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'phone': phone,
        'subject': subject,
        'letter': letter,
      };
}
