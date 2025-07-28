import 'package:flutter/material.dart';
import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/core/theme/app_colors.dart';
import 'package:shartflix/core/theme/app_styles.dart';

class MovieCard extends StatefulWidget {
  final MovieEntity movie;
  final Future<void> Function(bool newValue) onLikeTap;

  const MovieCard({super.key, required this.movie, required this.onLikeTap});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard>
    with SingleTickerProviderStateMixin {
  late bool isFavorite;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.movie.isFavorite;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleFavorite() async {
    final newValue = !isFavorite;
    setState(() => isFavorite = newValue);
    _controller.forward().then((_) => _controller.reverse());
    await widget.onLikeTap(newValue);

    final snackBar = SnackBar(
      content: Text(
        newValue ? 'Favorilere eklendi' : 'Favorilerden çıkarıldı',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.grey[900],
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );

    if (mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.movie.poster.replaceFirst('http://', 'https://'),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => const Center(
                    child: Icon(Icons.broken_image, color: Colors.white),
                  ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 5,
            child: GestureDetector(
              onTap: toggleFavorite,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          isFavorite
                              ? 'assets/icons/like_filled.png'
                              : 'assets/icons/like_bg.png',
                          width: 60,
                          height: 70,
                        ),
                        Image.asset(
                          'assets/icons/like.png',
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/icons/icon.png',
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.montserratBold.copyWith(
                          fontSize: 18,
                          color: AppColors.white,
                        ), // AppStyles kullanıldı
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.movie.plot,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.montserratRegular.copyWith(
                          fontSize: 13,
                          color: AppColors.white,
                        ), // AppStyles kullanıldı
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
