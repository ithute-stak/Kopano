import 'package:flutter/material.dart';
import 'main.dart';
import 'feature_screens.dart';

/// Local-only preferences preview. Real enforcement belongs in the API.
class PrivacySafetyPreview extends StatefulWidget {
  const PrivacySafetyPreview({super.key});
  @override
  State<PrivacySafetyPreview> createState() => _PrivacySafetyPreviewState();
}
class _PrivacySafetyPreviewState extends State<PrivacySafetyPreview> {
  bool dating = false;
  bool friendships = false;
  bool readReceipts = false;
  bool showDistrict = false;
  @override
  Widget build(BuildContext context) => PreviewScaffold(
    title: 'Privacy & Safety',
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('You control your visibility'),
      const Text('These controls demonstrate the intended privacy design. They do not change a live account.',
        style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 12),
      SwitchListTile.adaptive(
        key: const Key('dating-visibility'),
        title: const Text('Dating visibility'),
        subtitle: const Text('Only discoverable after eligibility and privacy checks'),
        value: dating, onChanged: (v) => setState(() => dating = v)),
      SwitchListTile.adaptive(
        title: const Text('Friendship visibility'),
        subtitle: const Text('Control whether others can discover you'),
        value: friendships, onChanged: (v) => setState(() => friendships = v)),
      SwitchListTile.adaptive(
        title: const Text('Message read receipts'),
        value: readReceipts, onChanged: (v) => setState(() => readReceipts = v)),
      SwitchListTile.adaptive(
        title: const Text('Show my district'),
        subtitle: const Text('Never exposes precise coordinates'),
        value: showDistrict, onChanged: (v) => setState(() => showDistrict = v)),
      const SectionTitle('Stay safe'),
      const _SafetyTile(icon: Icons.block, title: 'Blocked accounts', subtitle: 'No accounts blocked in this demo'),
      const _SafetyTile(icon: Icons.flag_outlined, title: 'Report a concern', subtitle: 'Moderation reporting requires the backend'),
      const _SafetyTile(icon: Icons.contact_emergency_outlined, title: 'Meeting safety', subtitle: 'Choose a public place and tell someone you trust'),
      const SizedBox(height: 14),
      OutlinedButton.icon(
        onPressed: () => showDemo(context, 'Privacy settings'),
        icon: const Icon(Icons.info_outline),
        label: const Text('How privacy settings work')),
    ]),
  );
}

class _SafetyTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  const _SafetyTile({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    leading: Icon(icon, color: KopanoTheme.purple),
    title: Text(title), subtitle: Text(subtitle),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => showDemo(context, title),
  ));
}

class AppSettingsPreview extends StatefulWidget {
  const AppSettingsPreview({super.key});
  @override
  State<AppSettingsPreview> createState() => _AppSettingsPreviewState();
}
class _AppSettingsPreviewState extends State<AppSettingsPreview> {
  String language = 'English';
  bool notifications = true;
  bool reducedAnimations = false;
  @override
  Widget build(BuildContext context) => PreviewScaffold(title: 'Settings', child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('App preferences'),
      DropdownButtonFormField<String>(
        key: const Key('language-preference'),
        initialValue: language,
        decoration: const InputDecoration(labelText: 'Language'),
        items: const [
          DropdownMenuItem(value: 'English', child: Text('English')),
          DropdownMenuItem(value: 'Sesotho', child: Text('Sesotho (planned)')),
        ],
        onChanged: (value) { if (value != null) setState(() => language = value); },
      ),
      const SizedBox(height: 14),
      SwitchListTile.adaptive(title: const Text('Notifications'),
        subtitle: const Text('Demo preference; no push messages will be sent'),
        value: notifications, onChanged: (v) => setState(() => notifications = v)),
      SwitchListTile.adaptive(title: const Text('Reduce animations'),
        subtitle: const Text('Demo preference; system accessibility settings are respected'),
        value: reducedAnimations, onChanged: (v) => setState(() => reducedAnimations = v)),
      const SectionTitle('About Kopano'),
      const ListTile(leading: Icon(Icons.info_outline), title: Text('Version 0.1.0'),
        subtitle: Text('Preview frontend • No live services')),
      const SizedBox(height: 12),
      KopanoAction(label: 'Explore onboarding preview', icon: Icons.auto_awesome,
        onPressed: () => openPreview(context, const OnboardingScreen())),
    ]),
  );
}
