import 'package:encrypt/encrypt.dart';

class Encryptor {
  static String encrypt(String plainText) {
    try {
      if (plainText.isNotEmpty) {
        final key = Key.fromLength(32);
        final iv = IV.fromLength(16);
        final encryptor = Encrypter(AES(key));

        return encryptor.encrypt(plainText, iv: iv).base64;
      } else {
        return '';
      }
    } catch (_) {
      return '';
    }
  }

  static String decrypt(String encryptText) {
    try {
      if (encryptText.isNotEmpty) {
        final key = Key.fromLength(32);
        final iv = IV.fromLength(16);
        final encryptor = Encrypter(AES(key));
        Encrypted encrypted = Encrypted.fromBase64(encryptText);
        return encryptor.decrypt(encrypted, iv: iv);
      } else {
        return '';
      }
    } catch (_) {
      return '';
    }
  }
}
