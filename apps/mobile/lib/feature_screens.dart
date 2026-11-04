import 'ui_components.dart';
import 'premium_screens.dart';
import 'package:flutter/material.dart';
import 'main.dart';

void openPreview(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
}

class PreviewScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  const PreviewScaffold({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800))),
    body: SafeArea(child: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 860),
      child: ListView(padding: const EdgeInsets.all(18), children: [child]),
    ))),
  );
}

class KopanoAction extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  const KopanoAction({super.key, required this.label, required this.onPressed, this.icon});
  @override
  Widget build(BuildContext context) => SizedBox(width: double.infinity, child: FilledButton.icon(
    onPressed: onPressed,
    icon: Icon(icon ?? Icons.arrow_forward),
    label: Padding(padding: const EdgeInsets.symmetric(vertical: 13), child: Text(label)),
  ));
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}
class _OnboardingScreenState extends State<OnboardingScreen> {
  int step = 0;
  static const messages = [
    ('Meet people', 'Make meaningful connections with people across Lesotho.', Icons.favorite),
    ('Make friends', 'Discover shared interests and new communities.', Icons.people),
    ('Explore together', 'Find places, activities and events worth experiencing.', Icons.explore),
  ];
  @override
  Widget build(BuildContext context) {
    final current = messages[step];
    return Scaffold(body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const BrandMark(), const Spacer(),
        Container(width: 170, height: 170,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(44),
            gradient: const LinearGradient(colors: [KopanoTheme.purple, KopanoTheme.pink])),
          child: Icon(current.$3, color: Colors.white, size: 90)),
        const SizedBox(height: 38),
        Text(current.$1, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
        const SizedBox(height: 14),
        Text(current.$2, textAlign: TextAlign.center, style: const TextStyle(fontSize: 17)),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(messages.length,
          (i) => Container(width: step == i ? 24 : 8, height: 8,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: step == i ? KopanoTheme.purple : Colors.black12,
              borderRadius: BorderRadius.circular(10))))),
        const Spacer(),
        KopanoAction(label: step == 2 ? 'Get started' : 'Continue', onPressed: () {
          if (step < 2) { setState(() => step++); }
          else { openPreview(context, const RegistrationScreen()); }
        }),
        TextButton(onPressed: () => openPreview(context, const RegistrationScreen()),
          child: const Text('Create account (demo)')),
      ]),
    )));
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  DateTime? birthDate;
  bool consent = false;
  @override
  void dispose() { name.dispose(); phone.dispose(); password.dispose(); super.dispose(); }
  Future<void> chooseBirthDate() async {
    final picked = await showDatePicker(context: context,
      initialDate: DateTime(1999), firstDate: DateTime(1900), lastDate: DateTime.now());
    if (picked != null) setState(() => birthDate = picked);
  }
  bool isAdult(DateTime date) {
    final now = DateTime.now();
    final cutoff = DateTime(now.year - 18, now.month, now.day);
    return !date.isAfter(cutoff);
  }
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Create your account', child:
    Form(key: formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Center(child: BrandMark()),
      const SizedBox(height: 24),
      KopanoTextInput(controller: name, label: 'Full name', icon: Icons.person_outline,
        textInputAction: TextInputAction.next, validator: KopanoFormValidation.requiredName),
      const SizedBox(height: 14),
      KopanoTextInput(controller: phone, label: 'Phone number', icon: Icons.phone_outlined,
        keyboardType: TextInputType.phone, validator: KopanoFormValidation.phone),
      const SizedBox(height: 14),
      OutlinedButton.icon(onPressed: chooseBirthDate, icon: const Icon(Icons.cake_outlined),
        label: Text(birthDate == null ? 'Select date of birth (18+)' :
          '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}')),
      const SizedBox(height: 14),
      KopanoTextInput(controller: password, label: 'Password', icon: Icons.lock_outline,
        obscureText: true, validator: KopanoFormValidation.password),
      CheckboxListTile(value: consent, onChanged: (v) => setState(() => consent = v ?? false),
        controlAffinity: ListTileControlAffinity.leading,
        title: const Text('I agree to the Terms and Privacy Policy', style: TextStyle(fontSize: 14))),
      const SizedBox(height: 12),
      KopanoAction(label: 'Sign up (preview)', onPressed: () {
        if (!(formKey.currentState?.validate() ?? false)) return;
        if (birthDate == null || !isAdult(birthDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kopano is for adults aged 18 and older.')));
          return;
        }
        if (!consent) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please review the Terms and Privacy Policy.')));
          return;
        }
        showDemo(context, 'Registration');
      }),
      const SizedBox(height: 10),
      const Text('No account will be created in preview mode.', textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey, fontSize: 12)),
    ])));
}

class DatingScreen extends StatefulWidget {
  const DatingScreen({super.key});
  @override
  State<DatingScreen> createState() => _DatingScreenState();
}
class _DatingScreenState extends State<DatingScreen> {
  int selection = 0;
  static const choices = ['Discover', 'Nearby', 'Liked you'];
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Dating', child: Column(children: [
    Wrap(spacing: 8, children: List.generate(choices.length, (i) => ChoiceChip(
      label: Text(choices[i]), selected: selection == i, onSelected: (_) => setState(() => selection = i)))),
    const SizedBox(height: 20),
    Container(width: double.infinity, padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(colors: [Color(0xFF371053), Color(0xFF873ABB)])),
      child: const Column(children: [
        Icon(Icons.favorite_border, size: 115, color: Colors.white),
        SizedBox(height: 20),
        Text('Discover meaningful connections', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Member discovery will become available when sign-in, preferences, age eligibility and safety checks are connected.',
          textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
      ])),
    const SizedBox(height: 18),
    KopanoAction(label: 'Dating preferences (preview)', icon: Icons.tune,
      onPressed: () => openPreview(context, const DatingCardPreview())),
  ]));
}

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Make friends', child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('Connect through shared interests'),
      const DiscoveryTile(icon: Icons.hiking, title: 'Outdoor adventures', subtitle: 'Explore Lesotho with new friends', tint: Colors.green),
      const DiscoveryTile(icon: Icons.music_note, title: 'Music lovers', subtitle: 'Discover music and culture', tint: KopanoTheme.pink),
      const DiscoveryTile(icon: Icons.groups, title: 'Local communities', subtitle: 'Find people with similar interests', tint: KopanoTheme.purple),
      const SizedBox(height: 12),
      const Text('Friend requests and profiles are previews until authentication and social APIs are active.',
        style: TextStyle(fontSize: 12, color: Colors.grey)),
    ]));
}

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});
  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}
class _PlacesScreenState extends State<PlacesScreen> {
  String filter = 'All';
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Find places', child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const TextField(readOnly: true, decoration: InputDecoration(
        prefixIcon: Icon(Icons.search), hintText: 'Search places (preview)')),
      const SizedBox(height: 15),
      Wrap(spacing: 8, children: ['All', 'Restaurants', 'Cafés', 'Outdoors', 'Hotels']
        .map((type) => ChoiceChip(label: Text(type), selected: filter == type,
          onSelected: (_) => setState(() => filter = type))).toList()),
      const SectionTitle('Explore around Lesotho'),
      if (filter == 'All' || filter == 'Cafés')
        DiscoveryTile(icon: Icons.local_cafe, title: 'Coffee date ideas', subtitle: 'Maseru • Category preview',
          tint: Colors.brown),
      if (filter == 'All' || filter == 'Restaurants')
        DiscoveryTile(icon: Icons.restaurant, title: 'Restaurants for two', subtitle: 'Maseru • Category preview',
          tint: Colors.deepOrange),
      if (filter == 'All' || filter == 'Outdoors')
        DiscoveryTile(icon: Icons.landscape, title: 'Scenic outings', subtitle: 'Lesotho • Category preview',
          tint: Colors.green),
      if (filter == 'All' || filter == 'Hotels')
        DiscoveryTile(icon: Icons.hotel, title: 'Weekend stays', subtitle: 'Lesotho • Category preview',
          tint: KopanoTheme.purple),
      KopanoAction(label: 'Explore sample place detail', icon: Icons.place_outlined,
        onPressed: () => openPreview(context, const PlaceDetailPreview())),
      const SizedBox(height: 12),
      const Text('Venue listings, prices and availability require verified business data.',
        style: TextStyle(color: Colors.grey, fontSize: 12)),
    ]));
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Discover events', child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('What is happening?'),
      const DiscoveryTile(icon: Icons.celebration, title: 'Singles social meetup',
        subtitle: 'Event concept • Date not scheduled', tint: KopanoTheme.pink),
      const DiscoveryTile(icon: Icons.music_note, title: 'Music and culture',
        subtitle: 'Event category • Lesotho', tint: KopanoTheme.purple),
      const DiscoveryTile(icon: Icons.people, title: 'Community activities',
        subtitle: 'Event category • Lesotho', tint: Colors.orange),
      const SizedBox(height: 12),
      KopanoAction(label: 'Explore example event details', icon: Icons.celebration,
        onPressed: () => openPreview(context, const EventDetailPreview())),
    ]));
}

class TicketPreviewScreen extends StatefulWidget {
  const TicketPreviewScreen({super.key});
  @override
  State<TicketPreviewScreen> createState() => _TicketPreviewScreenState();
}
class _TicketPreviewScreenState extends State<TicketPreviewScreen> {
  int tickets = 1;
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Tickets', child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('Event ticket preview'),
      const Text('Example ticket • M150', style: TextStyle(fontSize: 17)),
      const SizedBox(height: 14),
      Row(children: [
        IconButton(onPressed: tickets > 1 ? () => setState(() => tickets--) : null,
          icon: const Icon(Icons.remove_circle_outline)),
        Text('$tickets', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        IconButton(onPressed: tickets < 10 ? () => setState(() => tickets++) : null,
          icon: const Icon(Icons.add_circle_outline)),
        const Spacer(),
        Text('M${tickets * 150}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ]),
      const SizedBox(height: 22),
      KopanoAction(label: 'Checkout unavailable (preview)', icon: Icons.lock_outline,
        onPressed: () => showDemo(context, 'Ticket checkout')),
      const SizedBox(height: 10),
      const Text('No event, ticket inventory, reservation or payment is created.',
        style: TextStyle(color: Colors.grey, fontSize: 12)),
    ]));
}
