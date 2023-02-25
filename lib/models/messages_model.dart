class MessageModel {
  List<Messages>? messages;
  String? nextPageToken;
  int? resultSizeEstimate;

  MessageModel({
    this.messages,
    this.nextPageToken,
    this.resultSizeEstimate,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
    nextPageToken = json['nextPageToken'];
    resultSizeEstimate = json['resultSizeEstimate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['nextPageToken'] = nextPageToken;
    data['resultSizeEstimate'] = resultSizeEstimate;
    return data;
  }
}

class Messages {
  String? id;
  String? threadId;
  String? subject;

  Messages({
    this.id,
    this.threadId,
    this.subject,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    threadId = json['threadId'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['threadId'] = threadId;
    data['subject'] = subject;
    return data;
  }
}
