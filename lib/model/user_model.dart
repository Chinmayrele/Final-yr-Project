class UserBasicModel {
  final String userId;
  String name;
  String dob;
  String gender;
  String imageUrl;
  String coverImage;
  String about;
  String address;
  String status;
  int frontUid;
  int likesOnMe;

  UserBasicModel({
    required this.userId,
    required this.name,
    required this.dob,
    required this.gender,
    required this.imageUrl,
    required this.coverImage,
    required this.about,
    required this.address,
    required this.status,
    required this.frontUid,
    required this.likesOnMe,
  });
}
