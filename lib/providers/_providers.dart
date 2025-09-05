import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/appstate.dart';
import 'package:trinkgeld_app/providers/appstate_provider.dart';

import '../models/appstate.dart';
import 'appstate_provider.dart';

/// Definition eines NotifierProviders für den App-Zustand
final refAppState = NotifierProvider<AppstateProvider, Appstate>(
  () => AppstateProvider(),
);

/// Definition einer Instanz des Providers für den EmojiParser
final refEmojiParser = Provider<EmojiParser>((ref) => EmojiParser());
