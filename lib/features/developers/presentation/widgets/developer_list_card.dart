




import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../resourses/styles/colors_class.dart';
import '../../../../resourses/styles/text_style_class.dart';
import '../../../../resourses/widgets/app_text.dart';
import '../../../../resourses/widgets/box.dart';



/// Developer List Card for Home Screen
/// Shows avatar, name, username, and bio
class DeveloperListCard extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String username;
  final String? bio;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const DeveloperListCard({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.username,
    this.bio,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Box(
      onTap: onTap,
      margin: const EdgeInsets.symmetric( vertical: 8),
      borderRadius: 16,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Palette.white,
          Palette.blueBaby.withOpacity(0.2),
        ],
      ),
      borderColor: Palette.borderGrey.withOpacity(0.5),
      borderWidth: 1,
      boxShadow: [
        BoxShadow(
          color: Palette.blue.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      child: Stack(
        children: [
          // Decorative circle
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Palette.purpleLavender.withOpacity(0.1),
                    Palette.blueSky.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar with gradient border
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Palette.blue,
                        Palette.purpleLight,
                      ],
                    ),
                  ),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.white,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: avatarUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Palette.bluePastel,
                                Palette.purpleTint,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Palette.bluePastel,
                                Palette.purpleTint,
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Palette.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Developer Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      AppText(
                        name,
                        style: Styles.roboto16Bold,
                        color: Palette.textPrimary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Username with icon
                      Row(
                        children: [
                          Icon(
                            Icons.alternate_email,
                            size: 12,
                            color: Palette.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: AppText(
                              username,
                              style: Styles.roboto12Medium,
                              color: Palette.blue,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      // Bio (if available)
                      if (bio != null && bio!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        AppText(
                          bio!,
                          style: Styles.roboto12,
                          color: Palette.textMuted,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Favorite & Arrow
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Favorite Button
                    GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFavorite
                              ? Palette.red.withOpacity(0.15)
                              : Palette.greyLight.withOpacity(0.3),
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFavorite ? Palette.red : Palette.textMuted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Arrow
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Palette.blue.withOpacity(0.1),
                            Palette.purple.withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: Palette.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Example usage:
//
// DeveloperListCard(
//   avatarUrl: 'https://avatars.githubusercontent.com/u/1?v=4',
//   name: 'Tom Preston-Werner',
//   username: 'mojombo',
//   bio: 'Co-founder of GitHub, creator of Jekyll',
//   isFavorite: false,
//   onTap: () {
//     // Navigate to detail screen
//   },
//   onFavoriteToggle: () {
//     // Toggle favorite status
//   },
// )