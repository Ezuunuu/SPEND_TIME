import 'package:flutter/material.dart';
import 'package:spend_time/config/config.dart';

class DevelopExampleView extends StatelessWidget {
  const DevelopExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layout = Layout(context);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(width: 200.0 * layout.widthPercent, height: 100.0 * layout.heightPercent,),
              SizedBox(width: 100.0 * layout.widthPercent, height: 200.0 * layout.heightPercent,),
              Text('ABCDEFG 가나다라마바사 12345 - displayLarge',
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center
              ),
              Text('ABCDEFG 가나다라마바사 12345 - displayMedium',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center
              ),
              Text('ABCDEFG 가나다라마바사 12345 - displaySmall',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center
              ),
              Text('ABCDEFG 가나다라마바사 12345 - bodyLarge',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center
              ),
              Text('ABCDEFG 가나다라마바사 12345 - bodyMedium',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center
              ),
              Text('ABCDEFG 가나다라마바사 12345 - titleLarge',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center
              ),
              Text('ABCDEFG 가나다라마바사 12345 - titleMedium',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center
              ),
              Text('ABCDEFG 가나다라마바사 12345 - labelLarge',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center
              ),
              Text('ABCDEFG 가나다라마바사 12345 - labelMedium',
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center
              ),
              Text('ABCDEFG 가나다라마바사 12345 - labelSmall',
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center
              ),
            ],
          ),
        ),
      ),
    );
  }
}
