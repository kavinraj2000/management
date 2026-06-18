// lib/presentation/widgets/discovery/profile_card.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profilediscovery/src/core/theme/app_theme.dart';
import 'package:profilediscovery/src/data/domain/user_entity.dart';


class ProfileCard extends StatelessWidget {
  final ProfileEntity profile;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const ProfileCard({
    super.key,
    required this.profile,
    this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Image
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildImage(),
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 80.h,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Age badge
                  if (profile.age != null)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '${profile.age}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  // Favorite button
                  Positioned(
                    top: 4.h,
                    right: 4.w,
                    child: GestureDetector(
                      onTap: onFavorite,
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          profile.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: profile.isFavorite
                              ? Colors.red
                              : Colors.grey[600],
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Info section
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.fullName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (profile.occupation != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      profile.occupation!,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (profile.location != null) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 10,
                          color: AppTheme.primaryColor,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            profile.location!,
                            style: TextStyle(
                              fontSize: 10,
                              color: AppTheme.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (profile.profilePicture != null &&
        profile.profilePicture!.isNotEmpty &&
        profile.profilePicture!.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: profile.profilePicture!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppTheme.surfaceColor,
          child: Icon(
            Icons.person_rounded,
            color: AppTheme.primaryColor.withOpacity(0.3),
            size: 48,
          ),
        ),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppTheme.primaryColor.withOpacity(0.08),
      child: Center(
        child: Icon(
          Icons.person_rounded,
          color: AppTheme.primaryColor.withOpacity(0.4),
          size: 48,
        ),
      ),
    );
  }
}
