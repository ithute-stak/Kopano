import 'state_widgets.dart';
import 'account_welcome_screen.dart';
import 'sign_in_screen.dart';
import 'settings_screens.dart';
import 'premium_screens.dart';
import 'feature_screens.dart';
import 'package:flutter/material.dart';

void main() => runApp(const KopanoApp());

class KopanoTheme {
  static const purple = Color(0xFF6500AE);
  static const pink = Color(0xFFE83E8C);
  static const ink = Color(0xFF240C35);
  static const lavender = Color(0xFFF7F0FC);
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: purple, primary: purple, secondary: pink),
    scaffoldBackgroundColor: const Color(0xFFFCFAFD),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, foregroundColor: ink, centerTitle: false),
    cardTheme: CardThemeData(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
    ),
  );
}

class KopanoApp extends StatelessWidget {
  const KopanoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Kopano • Meet Connect Explore',
    debugShowCheckedModeBanner: false,
    theme: KopanoTheme.light,
    home: const KopanoShell(),
  );
}

class KopanoShell extends StatefulWidget {
  const KopanoShell({super.key});
  @override
  State<KopanoShell> createState() => _KopanoShellState();
}

class _KopanoShellState extends State<KopanoShell> {
  int tab = 0;
  final pages = const [HomePage(), DiscoverPage(), MatchesPage(), MessagesPage(), ProfilePage()];
  static const destinations = [
    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Discover'),
    NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Matches'),
    NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Messages'),
    NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
  ];
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 850;
    return Scaffold(
      body: SafeArea(
        child: Row(children: [
          if (wide) NavigationRail(
            selectedIndex: tab, onDestinationSelected: (index) => setState(() => tab = index),
            labelType: NavigationRailLabelType.all,
            leading: const Padding(padding: EdgeInsets.all(16), child: BrandMark(showName: false)),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')),
              NavigationRailDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: Text('Discover')),
              NavigationRailDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: Text('Matches')),
              NavigationRailDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: Text('Messages')),
              NavigationRailDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: Text('Profile')),
            ],
          ),
          Expanded(child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1040), child: pages[tab]))),
        ]),
      ),
      bottomNavigationBar: wide ? null : NavigationBar(
        selectedIndex: tab, onDestinationSelected: (index) => setState(() => tab = index),
        indicatorColor: KopanoTheme.lavender, destinations: destinations,
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  final bool showName;
  const BrandMark({super.key, this.showName = true});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [KopanoTheme.purple, KopanoTheme.pink]), borderRadius: BorderRadius.circular(14)),
      child: const Icon(Icons.favorite, color: Colors.white, size: 24),
    ),
    if (showName) const Padding(padding: EdgeInsets.only(left: 10), child: Text('Kopano', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: KopanoTheme.ink))),
  ]);
}

class PageContent extends StatelessWidget {
  final Widget child;
  const PageContent({super.key, required this.child});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 32), children: [child]);
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w800, color: KopanoTheme.ink, fontSize: 21)),
  );
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  const FeatureCard({super.key, required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias, child: InkWell(onTap: onTap, child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: color.withValues(alpha: .12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: color, size: 31), const SizedBox(height: 12),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(subtitle, style: const TextStyle(fontSize: 12)),
      ]),
    )),
  );
}

void showDemo(BuildContext context, String feature) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('$feature is a preview. Live services are not connected yet.'),
    behavior: SnackBarBehavior.floating,
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => PageContent(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      BrandMark(), Icon(Icons.notifications_outlined, color: KopanoTheme.purple),
    ]),
    const SizedBox(height: 24),
    Container(
      width: double.infinity, padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF320853), KopanoTheme.purple, Color(0xFFAB218E)]),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Dumela! 👋', style: TextStyle(color: Colors.white70, fontSize: 16)),
        SizedBox(height: 8),
        Text('Meet • Connect • Explore', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
        SizedBox(height: 7),
        Text('Find people, places and experiences across Lesotho.', style: TextStyle(color: Colors.white, fontSize: 14)),
      ]),
    ),
    const SectionTitle('What would you like to do?'),
    GridView.count(
      crossAxisCount: MediaQuery.sizeOf(context).width >= 600 ? 4 : 2,
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 10, mainAxisSpacing: 10,
      childAspectRatio: 1.10,
      children: [
        FeatureCard(icon: Icons.favorite, title: 'Dating', subtitle: 'Find a partner', color: KopanoTheme.pink, onTap: () => openPreview(context, const DatingScreen())),
        FeatureCard(icon: Icons.people_alt, title: 'Friends', subtitle: 'Make new friends', color: KopanoTheme.purple, onTap: () => openPreview(context, const FriendsScreen())),
        FeatureCard(icon: Icons.place, title: 'Places', subtitle: 'Find great spots', color: Colors.green.shade700, onTap: () => openPreview(context, const PlacesScreen())),
        FeatureCard(icon: Icons.event, title: 'Events', subtitle: 'What is happening?', color: Colors.deepOrange, onTap: () => openPreview(context, const EventsScreen())),
      ],
    ),
    const SectionTitle('Explore Lesotho'),
    DiscoveryTile(icon: Icons.landscape, title: 'Weekend in the mountains', subtitle: 'Places • Lesotho', tint: const Color(0xFF24775A), onTap: () => openPreview(context, const PlacesScreen())),
    DiscoveryTile(icon: Icons.local_cafe, title: 'Coffee and conversations', subtitle: 'Date ideas • Maseru', tint: const Color(0xFF9F5A2E), onTap: () => openPreview(context, const PlacesScreen())),
  ]));
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});
  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}
class _DiscoverPageState extends State<DiscoverPage> {
  int filter = 0;
  static const labels = ['Dating', 'Friends', 'Places', 'Events'];
  static const examples = [
    [('Meet people in Maseru', 'Dating • Discover compatible adults'), ('Meaningful connections', 'Dating • Set your preferences')],
    [('Find your people', 'Friendship • Shared interests'), ('Explore social groups', 'Friendship • Communities')],
    [('Coffee in Maseru', 'Places • Cafés'), ('Explore the mountains', 'Places • Outdoor experiences')],
    [('Meetups and gatherings', 'Events • Social'), ('Music and culture', 'Events • Across Lesotho')],
  ];
  @override
  Widget build(BuildContext context) => PageContent(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Discover', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900, color: KopanoTheme.ink)),
    const SizedBox(height: 8), const Text('People and experiences, all in one place.'),
    const SizedBox(height: 18),
    const TextField(readOnly: true, decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search (preview)')),
    const SizedBox(height: 18),
    SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: List.generate(labels.length, (i) => Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(label: Text(labels[i]), selected: filter == i, onSelected: (_) => setState(() => filter = i)),
    )))),
    const SectionTitle('Recommended for you'),
    ...examples[filter].map((item) => DiscoveryTile(
      icon: [Icons.favorite, Icons.people, Icons.place, Icons.event][filter],
      title: item.$1,
      subtitle: item.$2,
      tint: [KopanoTheme.pink, KopanoTheme.purple, Colors.green, Colors.deepOrange][filter],
      onTap: () => openPreview(context, [
        const DatingScreen(), const FriendsScreen(), const PlacesScreen(), const EventsScreen(),
      ][filter]),
    )),
    const SizedBox(height: 12),
    const Text('Preview content. No real member profiles, venue availability or events are displayed.', style: TextStyle(color: Colors.grey, fontSize: 12)),
  ]));
}

class DiscoveryTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final Color tint;
  final VoidCallback? onTap;
  const DiscoveryTile({super.key, required this.icon, required this.title, required this.subtitle, required this.tint, this.onTap});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    contentPadding: const EdgeInsets.all(12),
    leading: Container(width: 64, height: 64, decoration: BoxDecoration(color: tint.withValues(alpha: .13), borderRadius: BorderRadius.circular(15)),
      child: Icon(icon, color: tint, size: 28)),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(subtitle),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap ?? () => showDemo(context, title),
  ));
}

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) => PageContent(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Matches', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
        SizedBox(height: 8),
        Text('Meaningful connections begin with mutual interest.'),
        KopanoStateView(
          status: KopanoViewStatus.empty,
          title: 'Your matches will appear here',
          message: 'No live matches yet. Dating discovery will be connected to your account after safety and eligibility checks.',
          icon: Icons.favorite_outline,
        ),
      ],
    ),
  );
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) => PageContent(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Messages', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text('Chat securely with your connections.'),
        const KopanoStateView(
          status: KopanoViewStatus.empty,
          title: 'No conversations yet',
          message: 'Real-time WebSocket messaging will be available after backend integration.',
          icon: Icons.forum_outlined,
        ),
        KopanoAction(
          label: 'Open demo conversation',
          icon: Icons.chat_bubble_outline,
          onPressed: () => openPreview(context, const ChatPreviewScreen()),
        ),
      ],
    ),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => PageContent(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('My Profile', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
    const SizedBox(height: 20),
    const Center(child: CircleAvatar(radius: 44, backgroundColor: KopanoTheme.lavender, child: Icon(Icons.person, size: 44, color: KopanoTheme.purple))),
    const SizedBox(height: 12),
    const Center(child: Text('Welcome to Kopano', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
    const Center(child: Text('Demo mode • Not signed in')),
    const SizedBox(height: 16),
    KopanoAction(label: 'Join Kopano or sign in', icon: Icons.login,
      onPressed: () => openPreview(context, const AccountWelcomeScreen())),
    const SizedBox(height: 22),
    ...[
      (Icons.edit_outlined, 'Edit Profile'),
      (Icons.favorite_border, 'Dating Preferences'),
      (Icons.shield_outlined, 'Privacy & Safety'),
      (Icons.notifications_outlined, 'Notifications'),
      (Icons.settings_outlined, 'Settings'),
    ].map((entry) => Card(child: ListTile(
      leading: Icon(entry.$1, color: KopanoTheme.purple),
      title: Text(entry.$2),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        if (entry.$2 == 'Edit Profile') {
          openPreview(context, const EditProfilePreview());
        } else if (entry.$2 == 'Privacy & Safety') {
          openPreview(context, const PrivacySafetyPreview());
        } else if (entry.$2 == 'Settings') {
          openPreview(context, const AppSettingsPreview());
        } else if (entry.$2 == 'Dating Preferences') {
          openPreview(context, const DatingCardPreview());
        } else {
          showDemo(context, entry.$2);
        }
      },
    ))),
    const SizedBox(height: 15),
    const Center(child: Text('Kopano • Meet • Connect • Explore', style: TextStyle(color: Colors.grey))),
  ]));
}
