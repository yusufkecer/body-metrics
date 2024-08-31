part of '../home.dart';

class _DataList extends StatelessWidget {
  final String period;

  const _DataList({required this.period, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: ProductPadding.ten(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(period),
                ),
                TextButton(
                  onPressed: () {
                    'Button pressed'.log;
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
