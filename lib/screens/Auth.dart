import 'home_page.dart';
import 'profile.dart';

/// Satu akun terdaftar beserta datanya (profil, favorit, pesanan).
class Account {
  String email; // disimpan huruf kecil sebagai kunci
  String password;
  UserProfile profile;
  List<Cake> favorites;
  List<Order> orders;

  Account({
    required this.email,
    required this.password,
    required this.profile,
    this.favorites = const [],
    this.orders = const [],
  });
}

/// Layanan akun sederhana yang tersimpan di memori.
/// CATATAN: data hilang saat aplikasi ditutup, dan password belum di-hash.
/// Untuk aplikasi sungguhan, pakai Firebase Auth / backend.
class AuthService {
  static final Map<String, Account> _accounts = {};
  static Account? current;

  static String _key(String email) => email.trim().toLowerCase();

  /// Mengembalikan pesan error, atau null jika berhasil.
  static String? signUp({
    required String name,
    required String email,
    required String password,
  }) {
    final key = _key(email);
    if (_accounts.containsKey(key)) {
      return 'Email sudah terdaftar, silakan Sign In';
    }
    final account = Account(
      email: key,
      password: password,
      profile: UserProfile(
        name: name.trim(),
        email: email.trim(),
        phone: '',
        address: '',
      ),
    );
    _accounts[key] = account;
    _load(account);
    return null;
  }

  /// Mengembalikan pesan error, atau null jika berhasil.
  static String? signIn({required String email, required String password}) {
    final account = _accounts[_key(email)];
    if (account == null) {
      return 'Akun tidak ditemukan, silakan Sign Up dulu';
    }
    if (account.password != password) {
      return 'Password salah';
    }
    _load(account);
    return null;
  }

  /// Simpan data akun yang sedang aktif, lalu keluar.
  static void logout() {
    final account = current;
    if (account != null) {
      account.profile = userProfile.value;
      account.favorites = favorites.value;
      account.orders = orders.value;
    }
    current = null;
    cart.value = [];
  }

  /// Dipanggil saat email diubah di Edit Profil.
  /// Mengembalikan pesan error, atau null jika berhasil.
  static String? changeEmail(String newEmail) {
    final account = current;
    if (account == null) return null;
    final newKey = _key(newEmail);
    if (newKey == account.email) return null;
    if (_accounts.containsKey(newKey)) {
      return 'Email sudah dipakai akun lain';
    }
    _accounts.remove(account.email);
    account.email = newKey;
    _accounts[newKey] = account;
    return null;
  }

  static void _load(Account account) {
    current = account;
    userProfile.value = account.profile;
    favorites.value = account.favorites;
    orders.value = account.orders;
    cart.value = [];
  }
}