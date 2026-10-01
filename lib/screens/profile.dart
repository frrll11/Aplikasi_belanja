import 'package:flutter/material.dart';
import 'home_page.dart';
import 'auth.dart';

// ---------- Model & state profil ----------
class UserProfile {
  final String name, email, phone, address;
  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  UserProfile copyWith({String? name, String? email, String? phone, String? address}) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}

final ValueNotifier<UserProfile> userProfile = ValueNotifier(
  const UserProfile(
    name: 'Cake Lover',
    email: 'cakelover@email.com',
    phone: '0812-3456-7890',
    address: 'Jl. Merdeka No. 10, Cirebon',
  ),
);

// =====================================================
//                    PROFILE PAGE
// =====================================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Keluar?', style: TextStyle(color: kTextDark)),
        content: const Text('Anda akan keluar dari akun ini.',
            style: TextStyle(color: kTextGray)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal', style: TextStyle(color: kTextGray)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Keluar', style: TextStyle(color: kPink)),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      AuthService.logout(); // simpan data akun, lalu keluar
      Navigator.pushNamedAndRemoveUntil(context, '/signin', (r) => false);
    }
  }

  void _showInfo(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: const TextStyle(color: kTextDark)),
        content: Text(message, style: const TextStyle(color: kTextGray)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Color(0xFFF9E6A8))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- Header ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 56),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF9E6A8), Color(0xFFF9E6A8)],
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(36)),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back_ios_new,
                                color: Colors.white, size: 20),
                          ),
                          const Text('Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          const CartIcon(color: Colors.white, size: 22),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Avatar
                    ValueListenableBuilder<UserProfile>(
                      valueListenable: userProfile,
                      builder: (_, p, __) => Column(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26, blurRadius: 12)
                              ],
                            ),
                            child: Text(
                              p.name.isNotEmpty ? p.name[0].toUpperCase() : '?',
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF9E6A8)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(p.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'serif',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          Text(p.email,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---------- Kartu statistik (menimpa header) ----------
            Transform.translate(
              offset: const Offset(0, -32),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 16)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ValueListenableBuilder<List<Order>>(
                      valueListenable: orders,
                      builder: (_, list, __) => _Stat(
                        value: '${list.length}',
                        label: 'Pesanan',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const OrdersPage())),
                      ),
                    ),
                    const _Divider(),
                    ValueListenableBuilder<List<Cake>>(
                      valueListenable: favorites,
                      builder: (_, list, __) => _Stat(
                        value: '${list.length}',
                        label: 'Favorit',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const FavoritesPage())),
                      ),
                    ),
                    const _Divider(),
                    ValueListenableBuilder<List<Cake>>(
                      valueListenable: cart,
                      builder: (_, items, __) => _Stat(
                        value: '${items.length}',
                        label: 'Keranjang',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const CartPage())),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---------- Info ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: ValueListenableBuilder<UserProfile>(
                valueListenable: userProfile,
                builder: (_, p, __) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Informasi Akun',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: kTextDark)),
                    const SizedBox(height: 12),
                    _InfoTile(
                        icon: Icons.person_outline, label: 'Nama', value: p.name),
                    _InfoTile(
                        icon: Icons.email_outlined, label: 'Email', value: p.email),
                    _InfoTile(
                        icon: Icons.phone_outlined, label: 'Telepon', value: p.phone),
                    _InfoTile(
                        icon: Icons.location_on_outlined,
                        label: 'Alamat',
                        value: p.address),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------- Menu ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pengaturan',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kTextDark)),
                  const SizedBox(height: 8),
                  _MenuTile(
                    icon: Icons.edit_outlined,
                    label: 'Edit Profil',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditProfilePage()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.receipt_long_outlined,
                    label: 'Riwayat Pesanan',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const OrdersPage())),
                  ),
                  _MenuTile(
                    icon: Icons.favorite_border,
                    label: 'Favorit Saya',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FavoritesPage())),
                  ),
                  _MenuTile(
                    icon: Icons.notifications_none,
                    label: 'Notifikasi',
                    onTap: () => _showInfo(
                        context, 'Notifikasi', 'Belum ada notifikasi baru.'),
                  ),
                  _MenuTile(
                    icon: Icons.help_outline,
                    label: 'Bantuan',
                    onTap: () => _showInfo(context, 'Bantuan',
                        'Hubungi kami di support@cakeworld.com'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ---------- Logout ----------
            Padding(
              padding: EdgeInsets.fromLTRB(
                  24, 0, 24, 24 + MediaQuery.of(context).padding.bottom),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _confirmLogout(context),
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text('Logout',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPink,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Widget kecil ----------
class _Stat extends StatelessWidget {
  final String value, label;
  final VoidCallback? onTap;
  const _Stat({required this.value, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF9E6A8))),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 11, color: kTextGray)),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 28, color: kStarOff);
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoTile(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFF9E6A8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Color(0xFFF9E6A8), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 10, color: kTextGray)),
                const SizedBox(height: 2),
                Text(value.isEmpty ? '-' : value,
                    style: const TextStyle(fontSize: 13, color: kTextDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuTile(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: kTextDark, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label,
                  style: const TextStyle(fontSize: 14, color: kTextDark)),
            ),
            const Icon(Icons.chevron_right, color: kTextGray, size: 20),
          ],
        ),
      ),
    );
  }
}

// =====================================================
//                  EDIT PROFILE PAGE
// =====================================================
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameC;
  late final TextEditingController _emailC;
  late final TextEditingController _phoneC;
  late final TextEditingController _addressC;

  @override
  void initState() {
    super.initState();
    final p = userProfile.value;
    _nameC = TextEditingController(text: p.name);
    _emailC = TextEditingController(text: p.email);
    _phoneC = TextEditingController(text: p.phone);
    _addressC = TextEditingController(text: p.address);
  }

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _phoneC.dispose();
    _addressC.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      filled: true,
      fillColor: const Color(0xFFF5F5F8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFF9E6A8), width: 1.5),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final error = AuthService.changeEmail(_emailC.text.trim());
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    userProfile.value = userProfile.value.copyWith(
      name: _nameC.text.trim(),
      email: _emailC.text.trim(),
      phone: _phoneC.text.trim(),
      address: _addressC.text.trim(),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Profil berhasil disimpan')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextDark),
        title: const Text('Edit Profil',
            style: TextStyle(color: kPink, fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameC,
                decoration: _decoration('Nama', Icons.person_outline),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailC,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration('Email', Icons.email_outlined),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                  if (!v.contains('@')) return 'Email tidak valid';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneC,
                keyboardType: TextInputType.phone,
                decoration: _decoration('Telepon', Icons.phone_outlined),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressC,
                maxLines: 2,
                decoration: _decoration('Alamat', Icons.location_on_outlined),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPink,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Simpan',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// =====================================================
//                    FAVORITES PAGE
// =====================================================
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextDark),
        title: const Text('Favorit Saya',
            style: TextStyle(color: kPink, fontWeight: FontWeight.w500)),
      ),
      body: ValueListenableBuilder<List<Cake>>(
        valueListenable: favorites,
        builder: (context, items, _) {
          if (items.isEmpty) {
            return const Center(
              child: Text('Belum ada favorit',
                  style: TextStyle(color: kTextGray)),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            itemBuilder: (_, i) {
              final c = items[i];
              return BestBuyItemWithAction(
                cake: c,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailPage(cake: c))),
                onRemove: () => toggleFavorite(c),
              );
            },
          );
        },
      ),
    );
  }
}

class BestBuyItemWithAction extends StatelessWidget {
  final Cake cake;
  final VoidCallback onTap, onRemove;
  const BestBuyItemWithAction(
      {super.key,
      required this.cake,
      required this.onTap,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFF9E6A8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CakeImage(cake, 52),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cake.name,
                      style: const TextStyle(fontSize: 13, color: kTextDark)),
                  Text(cake.type,
                      style: const TextStyle(fontSize: 9, color: kTextGray)),
                  const SizedBox(height: 4),
                  Stars(cake.rating, size: 12),
                ],
              ),
            ),
            PriceText(cake.price),
            IconButton(
              icon: const Icon(Icons.favorite, color: kPink, size: 20),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
//                     ORDERS PAGE
// =====================================================
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  String _fmt(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}  ${two(d.hour)}:${two(d.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextDark),
        title: const Text('Riwayat Pesanan',
            style: TextStyle(color: kPink, fontWeight: FontWeight.w500)),
      ),
      body: ValueListenableBuilder<List<Order>>(
        valueListenable: orders,
        builder: (context, list, _) {
          if (list.isEmpty) {
            return const Center(
              child: Text('Belum ada pesanan',
                  style: TextStyle(color: kTextGray)),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final index = list.length - 1 - i; // terbaru di atas
              final o = list[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 12)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pesanan #${index + 1}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kTextDark)),
                        Text(_fmt(o.date),
                            style: const TextStyle(
                                fontSize: 10, color: kTextGray)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...o.items.map((c) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${c.emoji}  ${c.name}',
                                  style: const TextStyle(
                                      fontSize: 12, color: kTextDark)),
                              Text('\$ ${c.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 12, color: kTextGray)),
                            ],
                          ),
                        )),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style: TextStyle(fontSize: 12, color: kTextGray)),
                        Text('\$ ${o.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFF9E6A8))),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}