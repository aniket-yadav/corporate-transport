class Feedback {
  String? feedbackid;
  String? comment;
  String? author;
  String? rate;
  String? date;
  String? email;
  Feedback({
    this.feedbackid,
    this.comment,
    this.author,
    this.rate,
    this.date,
    this.email,
  });

  factory Feedback.fromJson(Map<String, dynamic>? json) {
    return Feedback(
      author: json?['author'],
      comment: json?['comment'],
      date: json?['date'],
      email: json?['email'],
      feedbackid: json?['feedbackid'],
      rate: json?['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'author': author,
      'comment': comment,
      'date': date,
      'email': email,
      'feedbackid': feedbackid,
      'rate': rate,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
