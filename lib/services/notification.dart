import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/notification.dart';
import 'package:imagesio/models/post.dart';

class NotificationService {
  Future<NotificationType> populateNotification(
      NotificationType notification) async {
    NotificationType populatedNotification = notification;

    // populate user send
    DocumentSnapshot userSendSnap = await notification.userSendRef.get();
    Author? userSendInfo =
        Author.fromJson(userSendSnap.data() as Map<String, dynamic>);
    populatedNotification.userSend = userSendInfo;

    // populate user receive
    // DocumentSnapshot userSendSnap = await notification.userSendRef.get();
    // Author? userSendInfo =
    //     Author.fromJson(userSendSnap.data() as Map<String, dynamic>);
    // populatedNotification.userSend = userSendInfo;

    //populate post if have
    if (notification.postRef != null) {
      DocumentSnapshot postSnap = await notification.postRef!.get();
      Post postInfor = Post.fromJson(postSnap.data() as Map<String, dynamic>);
      populatedNotification.post = postInfor;
    }

    return populatedNotification;
  }
}
