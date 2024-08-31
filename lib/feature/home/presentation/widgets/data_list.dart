part of '../home.dart';

class DataList extends StatelessWidget {
  final String period;

  const DataList({required this.period, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
