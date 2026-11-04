import 'package:flutter/material.dart';
import 'main.dart';
import 'feature_screens.dart';

class DatingCardPreview extends StatefulWidget {
  const DatingCardPreview({super.key});
  @override
  State<DatingCardPreview> createState() => _DatingCardPreviewState();
}
class _DatingCardPreviewState extends State<DatingCardPreview> {
  int page = 0;
  static const cards = [
    ('Your next connection', 'Shared interests • Lesotho', Icons.favorite_outline),
    ('Explore compatibility', 'Set your relationship intentions', Icons.tune),
    ('Meet respectfully', 'Safety first • Mutual matching', Icons.verified_user_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    final card = cards[page];
    return PreviewScaffold(title: 'Discover dating', child: Column(children: [
      Container(height: 320, width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF3D1162), KopanoTheme.purple, KopanoTheme.pink])),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(card.$3, size: 94, color: Colors.white),
          const SizedBox(height: 25),
          Text(card.$1, textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 9),
          Text(card.$2, textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70)),
        ])),
      const SizedBox(height: 17),
      const Text('Sample cards only — no real user profiles', style: TextStyle(color: Colors.grey, fontSize: 12)),
      const SizedBox(height: 18),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton.filledTonal(onPressed: next, icon: const Icon(Icons.close), tooltip: 'Skip preview card'),
        IconButton.filledTonal(onPressed: () => showDemo(context, 'Match preferences'),
          icon: const Icon(Icons.tune), tooltip: 'Preferences'),
        IconButton.filled(onPressed: next, icon: const Icon(Icons.favorite), tooltip: 'Next sample card'),
      ]),
      const SizedBox(height: 10),
      TextButton(onPressed: () => openPreview(context, const MatchCelebrationPreview()),
        child: const Text('View mutual-match animation preview')),
    ]));
  }
  void next() => setState(() => page = (page + 1) % cards.length);
}

class MatchCelebrationPreview extends StatelessWidget {
  const MatchCelebrationPreview({super.key});
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Match preview', child: Column(children: [
    const SizedBox(height: 35),
    const Icon(Icons.favorite, size: 115, color: KopanoTheme.pink),
    const SizedBox(height: 18),
    const Text("It's a match!", style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900)),
    const SizedBox(height: 12),
    const Text('This is an example celebration screen, not a real match.', textAlign: TextAlign.center),
    const SizedBox(height: 22),
    KopanoAction(label: 'View chat demonstration', icon: Icons.chat_bubble_outline,
      onPressed: () => openPreview(context, const ChatPreviewScreen())),
  ]));
}

class ChatPreviewScreen extends StatefulWidget {
  const ChatPreviewScreen({super.key});
  @override
  State<ChatPreviewScreen> createState() => _ChatPreviewScreenState();
}
class _ChatPreviewScreenState extends State<ChatPreviewScreen> {
  final controller = TextEditingController();
  final messages = <(String, bool)>[
    ('Dumela! 👋', false),
    ('Lumela! How are you?', true),
    ('Any favourite cafés in Maseru?', false),
  ];
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  void send() {
    final value = controller.text.trim();
    if (value.isEmpty) return;
    setState(() => messages.add((value, true)));
    controller.clear();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Demo conversation'),
      actions: [IconButton(icon: const Icon(Icons.shield_outlined), tooltip: 'Safety information',
        onPressed: () => showDemo(context, 'Chat safety'))]),
    body: SafeArea(child: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 760),
      child: Column(children: [
        const Padding(padding: EdgeInsets.all(12), child: Text(
          'Local demonstration: messages are not sent or saved.', style: TextStyle(color: Colors.grey))),
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return Align(alignment: message.$2 ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
                constraints: const BoxConstraints(maxWidth: 300),
                decoration: BoxDecoration(color: message.$2 ? KopanoTheme.lavender : Colors.white,
                  borderRadius: BorderRadius.circular(17)),
                child: Text(message.$1)));
          })),
        Padding(padding: const EdgeInsets.all(12), child: Row(children: [
          Expanded(child: TextField(controller: controller,
            onSubmitted: (_) => send(),
            decoration: const InputDecoration(hintText: 'Type a demo message'))),
          IconButton.filled(onPressed: send, icon: const Icon(Icons.send), tooltip: 'Add demo message'),
        ])),
      ]),
    ))),
  );
}

class PlaceDetailPreview extends StatelessWidget {
  const PlaceDetailPreview({super.key});
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Place details', child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(height: 230, width: double.infinity, decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(colors: [Color(0xFF257C70), Color(0xFF6BB79A)])),
        child: const Icon(Icons.restaurant, color: Colors.white, size: 88)),
      const SectionTitle('A perfect place to meet'),
      const Text('Example venue listing • Maseru, Lesotho'),
      const SizedBox(height: 16),
      const Wrap(spacing: 8, children: [
        Chip(label: Text('Dining')), Chip(label: Text('Date night')), Chip(label: Text('Public venue')),
      ]),
      const SizedBox(height: 14),
      const Text('Discover places, view photos and explore amenities once verified business listings are connected.'),
      const SizedBox(height: 20),
      KopanoAction(label: 'Plan a date (preview)', icon: Icons.calendar_today,
        onPressed: () => openPreview(context, const DatePlannerPreview())),
      const SizedBox(height: 10),
      const Text('No real availability, prices or booking is represented.',
        style: TextStyle(color: Colors.grey, fontSize: 12)),
    ]));
}

class DatePlannerPreview extends StatefulWidget {
  const DatePlannerPreview({super.key});
  @override
  State<DatePlannerPreview> createState() => _DatePlannerPreviewState();
}
class _DatePlannerPreviewState extends State<DatePlannerPreview> {
  DateTime? date;
  TimeOfDay? time;
  int guests = 2;
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Plan a date', child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('Your date plan'),
      const Text('Choose a date and time for a local demonstration.'),
      const SizedBox(height: 15),
      OutlinedButton.icon(onPressed: () async {
        final today = DateTime.now();
        final selected = await showDatePicker(context: context, firstDate: today,
          lastDate: today.add(const Duration(days: 365)), initialDate: today);
        if (selected != null) setState(() => date = selected);
      }, icon: const Icon(Icons.calendar_month),
        label: Text(date == null ? 'Select a day' : '${date!.day}/${date!.month}/${date!.year}')),
      const SizedBox(height: 10),
      OutlinedButton.icon(onPressed: () async {
        final selected = await showTimePicker(context: context, initialTime: TimeOfDay.now());
        if (selected != null) setState(() => time = selected);
      }, icon: const Icon(Icons.access_time),
        label: Text(time == null ? 'Select a time' : time!.format(context))),
      Row(children: [
        const Text('Guests'), const Spacer(),
        IconButton(onPressed: guests > 1 ? () => setState(() => guests--) : null,
          icon: const Icon(Icons.remove_circle_outline)),
        Text('$guests'),
        IconButton(onPressed: guests < 10 ? () => setState(() => guests++) : null,
          icon: const Icon(Icons.add_circle_outline)),
      ]),
      const SizedBox(height: 20),
      KopanoAction(label: 'Preview itinerary', icon: Icons.map_outlined,
        onPressed: () {
          if (date == null || time == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Select a date and time first.')));
            return;
          }
          showDialog<void>(context: context, builder: (dialogContext) => AlertDialog(
            title: const Text('Date plan preview'),
            content: Text('Selected: ${date!.day}/${date!.month}/${date!.year} at ${time!.format(context)} • $guests people.\n\nThis is not a reservation.'),
            actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Close'))],
          ));
        }),
    ]));
}

class EventDetailPreview extends StatelessWidget {
  const EventDetailPreview({super.key});
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Event details', child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(height: 220, width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(colors: [KopanoTheme.purple, KopanoTheme.pink])),
        child: const Icon(Icons.celebration, color: Colors.white, size: 86)),
      const SectionTitle('Community meetup concept'),
      const Text('Illustrative event • No scheduled date or actual organizer'),
      const SizedBox(height: 15),
      const Text('Meet new friends and explore local culture. Real event listings will include venue, organizer, date, safety guidance, accessibility and ticket terms.'),
      const SizedBox(height: 23),
      KopanoAction(label: 'View ticket selection', icon: Icons.confirmation_number_outlined,
        onPressed: () => openPreview(context, const TicketPreviewScreen())),
    ]));
}

class EditProfilePreview extends StatefulWidget {
  const EditProfilePreview({super.key});
  @override
  State<EditProfilePreview> createState() => _EditProfilePreviewState();
}
class _EditProfilePreviewState extends State<EditProfilePreview> {
  final name = TextEditingController();
  final bio = TextEditingController();
  String district = 'Maseru';
  bool datingVisible = false;
  bool friendshipVisible = true;
  @override
  void dispose() { name.dispose(); bio.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Edit profile', child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SectionTitle('Your profile settings'),
      TextField(controller: name, maxLength: 80, decoration: const InputDecoration(labelText: 'Display name')),
      const SizedBox(height: 12),
      TextField(controller: bio, maxLines: 3, maxLength: 300,
        decoration: const InputDecoration(labelText: 'About me')),
      DropdownButtonFormField<String>(initialValue: district,
        decoration: const InputDecoration(labelText: 'District'),
        items: const ['Maseru','Berea','Leribe','Mafeteng','Mohale’s Hoek','Quthing','Qacha’s Nek','Thaba-Tseka','Mokhotlong','Butha-Buthe']
          .map((name) => DropdownMenuItem(value: name, child: Text(name))).toList(),
        onChanged: (value) { if (value != null) setState(() => district = value); }),
      SwitchListTile(title: const Text('Show me in dating discovery'),
        subtitle: const Text('Off by default in preview'),
        value: datingVisible, onChanged: (value) => setState(() => datingVisible = value)),
      SwitchListTile(title: const Text('Show me in friendship discovery'),
        value: friendshipVisible, onChanged: (value) => setState(() => friendshipVisible = value)),
      KopanoAction(label: 'Preview profile changes', icon: Icons.save_outlined,
        onPressed: () => showDemo(context, 'Profile changes')),
      const SizedBox(height: 10),
      const Text('Changes are local to this screen and are not saved to an account.',
        style: TextStyle(color: Colors.grey, fontSize: 12)),
    ]));
}
