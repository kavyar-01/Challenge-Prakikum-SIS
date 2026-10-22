/*
  Nama: Fajar Perdana Kurniawan Siagian
  Nrp: 162024007
  Tugas Akhir 2
*/

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media Profile',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const ProfilePage(),
    );
  }
}

enum ProfileTab { posts, saved, tagged }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileTab _selectedTab = ProfileTab.posts;

  void _showMenuAction(String action) {
    Navigator.of(context).pop();
    if (action != 'Profile') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$action selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 12, 16),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      key: const ValueKey('close-menu'),
                      tooltip: 'Close menu',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              _DrawerMenuItem(
                icon: Icons.person_outline,
                label: 'Profile',
                onTap: () => _showMenuAction('Profile'),
              ),
              _DrawerMenuItem(
                icon: Icons.settings_outlined,
                label: 'Settings',
                onTap: () => _showMenuAction('Settings'),
              ),
              _DrawerMenuItem(
                icon: Icons.logout,
                label: 'Log Out',
                onTap: () => _showMenuAction('Log Out'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'fajarprdn_',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              key: const ValueKey('open-menu'),
              tooltip: 'Open menu',
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.menu, color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 25),
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileStatistic(number: '12', label: 'Posts'),
                        ProfileStatistic(number: '1.2K', label: 'Followers'),
                        ProfileStatistic(number: '345', label: 'Following'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fajar Perdana',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('No bio yet.', style: TextStyle(fontSize: 14)),
                    Text('Busy', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Share Profile'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Divider(height: 1, thickness: 1),
            Row(
              children: [
                _ProfileTabButton(
                  tab: ProfileTab.posts,
                  selectedTab: _selectedTab,
                  icon: Icons.grid_on_outlined,
                  label: 'Posts',
                  onTap: () => setState(() => _selectedTab = ProfileTab.posts),
                ),
                _ProfileTabButton(
                  tab: ProfileTab.saved,
                  selectedTab: _selectedTab,
                  icon: Icons.bookmark_border,
                  label: 'Saved',
                  onTap: () => setState(() => _selectedTab = ProfileTab.saved),
                ),
                _ProfileTabButton(
                  tab: ProfileTab.tagged,
                  selectedTab: _selectedTab,
                  icon: Icons.tag,
                  label: 'Tagged',
                  onTap: () => setState(() => _selectedTab = ProfileTab.tagged),
                ),
              ],
            ),
            GridView.builder(
              key: ValueKey(_selectedTab),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _itemCountForTab(_selectedTab),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) => Container(
                color: Colors.grey.shade300,
                child: Center(
                  child: Icon(
                    _iconForTab(_selectedTab),
                    size: 35,
                    color: Colors.grey.shade500,
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

int _itemCountForTab(ProfileTab tab) => switch (tab) {
  ProfileTab.posts => 12,
  ProfileTab.saved => 6,
  ProfileTab.tagged => 4,
};

IconData _iconForTab(ProfileTab tab) => switch (tab) {
  ProfileTab.posts => Icons.image,
  ProfileTab.saved => Icons.bookmark,
  ProfileTab.tagged => Icons.tag,
};

class _DrawerMenuItem extends StatelessWidget {
  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}

class _ProfileTabButton extends StatelessWidget {
  const _ProfileTabButton({
    required this.tab,
    required this.selectedTab,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final ProfileTab tab;
  final ProfileTab selectedTab;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = tab == selectedTab;
    return Expanded(
      child: Semantics(
        button: true,
        selected: isSelected,
        label: label,
        child: InkWell(
          key: ValueKey('profile-tab-${tab.name}'),
          onTap: onTap,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected ? Colors.black : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileStatistic extends StatelessWidget {
  final String number;
  final String label;

  const ProfileStatistic({
    super.key,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 3),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}
