part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class OnGetUserAuthenticationEvent extends UserEvent {}

class OnRegisterUserEvent extends UserEvent {
  final String fullname;
  final String username;
  final String email;
  final String password;

  OnRegisterUserEvent(this.fullname, this.username, this.email, this.password);
}

class OnVerifyEmailEvent extends UserEvent {
  final String email;
  final String code;

  OnVerifyEmailEvent(this.email, this.code);
}

class OnUpdatePictureCover extends UserEvent {
  final String pathCover;

  OnUpdatePictureCover(this.pathCover);
}

class OnUpdatePictureProfile extends UserEvent {
  final String pathProfile;

  OnUpdatePictureProfile(this.pathProfile);
}

class OnUpdateProfileEvent extends UserEvent {
  final String user;
  final String description;
  final String fullname;
  final String phone;

  OnUpdateProfileEvent(this.user, this.description, this.fullname, this.phone);
}

class OnChangePasswordEvent extends UserEvent {
  final String currentPassword;
  final String newPassword;

  OnChangePasswordEvent(this.currentPassword, this.newPassword);

}

class OnToggleButtonProfile extends UserEvent {
  final bool isPhotos;

  OnToggleButtonProfile(this.isPhotos);
}

class OnChangeAccountToPrivacy extends UserEvent {}

class OnLogOutUser extends UserEvent{}

class OnAddNewFollowingEvent extends UserEvent {
  final String uidFriend;

  OnAddNewFollowingEvent(this.uidFriend);
}

class OnAcceptFollowerRequestEvent extends UserEvent {
  final String uidFriend;
  final String uidNotification;

  OnAcceptFollowerRequestEvent(this.uidFriend, this.uidNotification);
}

class OnDeletefollowingEvent extends UserEvent {
  final String uidUser;

  OnDeletefollowingEvent(this.uidUser);
}

class OnDeletefollowersEvent extends UserEvent {
  final String uidUser;

  OnDeletefollowersEvent(this.uidUser);
}




