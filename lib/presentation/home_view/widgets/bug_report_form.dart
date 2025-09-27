import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <- za Clipboard
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/email_validation.dart';
import 'package:trinkgeld_app/providers/_providers.dart';
import 'package:url_launcher/url_launcher.dart';

/// Bug report form
class BugReportForm extends ConsumerStatefulWidget {
  final String route = '/bugReportPage';
  BugReportForm({super.key});

  @override
  ConsumerState<BugReportForm> createState() => _BugReportFormState();
}

class _BugReportFormState extends ConsumerState<BugReportForm> {
  final describeTheBugNode = FocusNode();
  final bugTextController = TextEditingController();

  static const String kRecipientEmail = 'sedoed58@gmail.com';
  @override
  void dispose() {
    describeTheBugNode.dispose();
    bugTextController.dispose();
    super.dispose();
  }

  Uri _buildMailtoUri({String? body}) {
    final appstate = ref.read(refAppState);
    final lang = appstate.selectedLanguage.ownName;
    final country = appstate.selectedCountryObject.name;

    return Uri(
      scheme: 'mailto',
      path: kRecipientEmail,
      queryParameters: {
        'subject': 'Trinkgeld – Bug report',
        'body': '''
Platform: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}
Language: $lang
Country: $country

----- Bug report -----
${(body ?? '').trim()}
''',
      },
    );
  }

  Future<void> _sendEmail(BuildContext context) async {
    final uri = _buildMailtoUri(body: bugTextController.text);
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!mounted) return;
      if (!ok) {
        _showFallbackDialog(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Otvoren e-mail klijent')),
        );
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (!mounted) return;
      _showFallbackDialog(context);
    }
  }

  void _showFallbackDialog(BuildContext context) {
    final theme = Theme.of(context);
    final linkStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.primary,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.w600,
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nema e-mail klijenta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'No email client found.\n\n'
              'Tap the address below to open your mail app with the To field pre-filled:',
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final mailto = Uri(scheme: 'mailto', path: kRecipientEmail);
                final ok = await launchUrl(mailto, mode: LaunchMode.externalApplication);
                if (!ok && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unable to open mail client')),
                  );
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.email_outlined, size: 18),
                  const SizedBox(width: 6),
                  Text('📧  $kRecipientEmail', style: linkStyle),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(const ClipboardData(text: kRecipientEmail));
              if (ctx.mounted) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('E-mail address copied to clipboard')),
                );
              }
            },
            child: const Text('Copy address'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    const settingsButtonsBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(translate.bugReportAppBarTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // e-mail field (opcional, user address)
              EmailValidation(nextNode: describeTheBugNode),
              const SizedBox(height: 25),

              // opis greške
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: bugTextController,
                  maxLines: null,
                  focusNode: describeTheBugNode,
                  decoration: InputDecoration(
                    border: settingsButtonsBorder,
                    label: Text(translate.describeTheBug),
                  ),
                ),
              ),

              // Pošalji
              ElevatedButton(
                onPressed: () => _sendEmail(context),
                child: const Text('Senden'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
