import 'package:shartflix/core/error/failures.dart';

class FailureMessageMapper {
  static String map(Failure failure) {
    if (failure is ConnectionFailure) {
      return "İnternet bağlantınızı kontrol edin.";
    }

    if (failure is ServerFailure) {
      // Detaylı kontrol burada yapılabilir
      if (failure.message.contains("TOKEN_UNAVAILABLE")) {
        return "Geçersiz e-posta ya da şifre.";
      }

      if (failure.message.contains("User already exists")) {
        return "Bu e-posta adresi zaten kayıtlı.";
      }

      if (failure.message.contains("INVALID_CREDENTIALS")) {
        return "Kullanıcı adı veya Şifre Yanlış.";
      }

      return "Bir sunucu hatası oluştu. Lütfen tekrar deneyin.";
    }

    if (failure is CacheFailure) {
      return "Veri alınırken bir hata oluştu.";
    }

    return "Bilinmeyen bir hata oluştu.";
  }
}
