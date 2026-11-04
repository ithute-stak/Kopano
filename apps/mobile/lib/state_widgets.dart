import 'package:flutter/material.dart';

/// Unified UI states used by future FastAPI-backed screens.
enum KopanoViewStatus { loading, empty, error }

class KopanoStateView extends StatelessWidget {
  const KopanoStateView({
    super.key,
    required this.status,
    required this.title,
    required this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final KopanoViewStatus status;
  final String title;
  final String message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final loading = status == KopanoViewStatus.loading;
    final stateIcon = status == KopanoViewStatus.error
        ? Icons.error_outline
        : (icon ?? Icons.inbox_outlined);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (loading)
                const Semantics(
                  label: 'Loading',
                  child: CircularProgressIndicator(),
                )
              else
                Icon(
                  stateIcon,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                  semanticLabel: title,
                ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 9),
              Text(message, textAlign: TextAlign.center),
              if (!loading && onAction != null && actionLabel != null) ...[
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: onAction,
                  child: Text(actionLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Live endpoints will replace this disabled-by-default repository.
/// No HTTP request is made by this implementation.
abstract interface class KopanoDiscoveryGateway {
  Future<List<String>> loadMatches();
  Future<List<String>> loadConversations();
}

class DisabledDiscoveryGateway implements KopanoDiscoveryGateway {
  const DisabledDiscoveryGateway();

  @override
  Future<List<String>> loadMatches() async => const [];

  @override
  Future<List<String>> loadConversations() async => const [];
}
