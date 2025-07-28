import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/presentation/auth/pages/login_page.dart';
import 'package:shartflix/presentation/premium/pages/advertise_page.dart';
import 'package:shartflix/presentation/profile/bloc/profile_bloc.dart';
import 'package:shartflix/presentation/profile/bloc/profile_event.dart';
import 'package:shartflix/presentation/profile/bloc/profile_state.dart';
import 'package:shartflix/presentation/profile/pages/photo_upload_page.dart';
import 'package:shartflix/core/theme/app_colors.dart';
import 'package:shartflix/core/theme/app_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  Future<void> _logout() async {
    const storage = FlutterSecureStorage();

    // Token'i temizle
    await storage.delete(key: 'token');

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: _logout,
        ),
        title: Text(
          "Profil Detayı",
          style: AppStyles.euclidCircularAMedium.copyWith(
            fontSize: 15,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              child: Row(
                children: [
                  Icon(Icons.diamond, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    "Sınırlı Teklif",
                    style: AppStyles.montserratMedium.copyWith(
                      fontSize: 12,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return const AdvertisePage();
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is ProfileLoaded) {
            final user = state.user;
            final likedMovies = state.likedMovies;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,

                        backgroundImage: NetworkImage(
                          user.photoUrl ?? 'https://via.placeholder.com/150',
                        ),
                        backgroundColor: Colors.grey.shade800,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: AppStyles.euclidCircularAMedium.copyWith(
                              fontSize: 15,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "ID: ${user.id.substring(0, 7)}",
                            style: AppStyles.euclidCircularAMedium.copyWith(
                              fontSize: 12,
                              color: const Color.fromARGB(106, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PhotoUploadPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Fotoğraf Ekle",
                          style: AppStyles.euclidCircularABold.copyWith(
                            fontSize: 13,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Beğendiğim Filmler",
                    style: AppStyles.euclidCircularABold.copyWith(
                      fontSize: 13,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (likedMovies.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Text(
                          "Henüz beğenilen filminiz yok.",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.7,
                          ),
                      itemCount: likedMovies.length,
                      itemBuilder: (context, index) {
                        final movie = likedMovies[index];
                        return _MovieCard(movie: movie);
                      },
                    ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Text(
                "Profil yüklenirken bir hata oluştu: ${state.message}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(
            child: Text(
              "Profil bilgileri yükleniyor...",
              style: TextStyle(color: Colors.white70),
            ),
          );
        },
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    final imageUrl = (movie.poster ?? '').replaceFirst('http://', 'https://');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    color: Colors.grey.shade700,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.white54,
                    ),
                  ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.title,
          style: AppStyles.euclidCircularAMedium.copyWith(
            fontSize: 12,
            color: AppColors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          movie.director,
          style: AppStyles.euclidCircularARegular.copyWith(
            fontSize: 13,
            color: AppColors.white70,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
