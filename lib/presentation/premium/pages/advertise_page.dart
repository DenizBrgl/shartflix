import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/app_colors.dart';
import 'package:shartflix/core/theme/app_styles.dart';

class AdvertisePage extends StatelessWidget {
  const AdvertisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            const Color.fromARGB(255, 122, 14, 14),
            const Color.fromARGB(255, 56, 22, 22),
            Colors.black,
          ],
          stops: const [0.0, 0.4, 1.0],
          center: Alignment.topCenter,
          radius: 1.5,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    "Sınırlı Teklif",
                    style: AppStyles.euclidCircularABold.copyWith(
                      fontSize: 20,
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Jeton paketinizi seçerek bonus kazanın ve yeni bölümlerin kilidini açın!",
                    style: AppStyles.euclidCircularARegular.copyWith(
                      fontSize: 12,
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            _buildBonusSection(),
            const SizedBox(height: 20),
            Text(
              "Kilidi açmak için bir jeton paketi seçin",
              style: AppStyles.euclidCircularAMedium.copyWith(
                fontSize: 15,
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            _buildTokenPackages(),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tüm Jetonları Gör tıklandı!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Tüm Jetonları Gör",
                    style: AppStyles.euclidCircularAMedium.copyWith(
                      fontSize: 15,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBonusSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grey.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Alacağınız Bonuslar",
                style: AppStyles.euclidCircularAMedium.copyWith(
                  fontSize: 15,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBonusItem("assets/icons/premium.png", "Premium \nHesap"),
                _buildBonusItem(
                  "assets/icons/more_heart.png",
                  "Daha Fazla \nEşleşme",
                ),
                _buildBonusItem("assets/icons/muscle.png", "Öne \nÇıkarma"),
                _buildBonusItem(
                  "assets/icons/heart.png",
                  "Daha Fazla \nBeğeni",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBonusItem(String imagePath, String text) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/icons/eclipse.png", width: 70, height: 70),
            Image.asset(imagePath, width: 35, height: 35),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTokenPackages() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: [
          _buildTokenPackageCard(
            originalTokens: "200",
            bonusTokens: "330",
            price: "₺99,99",
            period: "Başına haftalık",
            discount: "+10%",
            gradientColors: [
              const Color.fromARGB(255, 124, 1, 1),

              const Color.fromARGB(255, 216, 37, 37),
            ],
          ),
          SizedBox(width: 5),
          _buildTokenPackageCard(
            originalTokens: "2.000",
            bonusTokens: "3.375",
            price: "₺799,99",
            period: "Başına haftalık",
            discount: "+70%",
            gradientColors: [
              const Color.fromARGB(255, 100, 0, 200),
              const Color.fromARGB(255, 255, 50, 50),
            ],
          ),
          SizedBox(width: 5),

          _buildTokenPackageCard(
            originalTokens: "1.000",
            bonusTokens: "1.350",
            price: "₺399,99",
            period: "Başına haftalık",
            discount: "+35%",
            gradientColors: [
              const Color.fromARGB(255, 124, 1, 1),

              const Color.fromARGB(255, 216, 37, 37),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTokenPackageCard({
    required String originalTokens,
    required String bonusTokens,
    required String price,
    required String period,
    required String discount,
    required List<Color> gradientColors,
  }) {
    return SizedBox(
      width: 110,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Kartın Arka Planı
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  originalTokens,
                  style: const TextStyle(
                    fontFamily: AppStyles.euclidCircularA,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.white,
                    decorationThickness: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  bonusTokens,
                  style: AppStyles.montserratBlack.copyWith(
                    fontSize: 25,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  "Jeton",
                  style: AppStyles.euclidCircularAMedium.copyWith(
                    fontSize: 15,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    color: Color.fromARGB(55, 255, 255, 255),
                    thickness: 0.8,
                    height: 24,
                  ),
                ),
                Text(
                  price,
                  style: AppStyles.montserratBlack.copyWith(
                    fontSize: 15,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  period,
                  style: AppStyles.euclidCircularARegular.copyWith(
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              discount,
              style: AppStyles.euclidCircularARegular.copyWith(
                fontSize: 12,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
