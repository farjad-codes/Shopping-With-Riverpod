/// Simple class representing the user UID and email.
class AppUser {
  
  final String uid;
  final String email;
  final String displayName;

  AppUser({required this.uid, required this.email, required this.displayName});

  @override
  String toString() => 'AppUser(uid: $uid, email: $email, displayName: $displayName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.uid == uid &&
        other.email == email &&
        other.displayName == displayName;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ displayName.hashCode;


  // TODO: Add other fields as needed (email, displayName etc.)
}