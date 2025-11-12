import 'package:hive/hive.dart';

part 'offline_user_model.g.dart';

@HiveType(typeId: 1)
class OfflineUserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final String imageUrl;

  OfflineUserModel({
    required this.id,
    required this.name,
    required this.url,
    required this.imageUrl,
  });
}
