import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';
import 'package:trinkgeld_app/models/my_text_field.dart';
import 'package:trinkgeld_app/models/quality.dart';

class InputSection extends ConsumerWidget {
  InputSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appstate = ref.watch(refAppState);
    final appstateProvider = ref.read(
      refAppState.notifier,
    );
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 15,
            ),
            child: MyTextfield(
              onChanged: (value) {
                final intValue = int.tryParse(value);
                if (intValue == null) {
                  appstateProvider.resetNet();
                  return;
                }
                appstateProvider.setNet(intValue);
              },
              labelText: 'Your bill amount',
              textInputType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(child: Text(appstate.net.toString())),
          ),
          const Text(
            'Please rate the service!',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  minRating: 1,
                  maxRating: 3,
                  itemCount: 3,
                  initialRating: appstate.quality.stars.toDouble(),
                  itemSize: 50,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  updateOnDrag: true,
                  onRatingUpdate: (rating) {
                    appstateProvider.setQualityByStars(rating.toInt());
                  },
                ),
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('X'),
                Text(appstate.quality != Quality.low ? 'X' : '-'),
                Text(appstate.quality == Quality.high ? 'X' : '-'),
                // appstate.quality == Quality.high ? const Text('X') :
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              // height: 50,
              child: Text(
                'Tip Amount: ${appstate.gros - appstate.net}',
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          const Text(
            'Total',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Text(appstate.gros.toString()),
        ],
      ),
    );
  }
}
