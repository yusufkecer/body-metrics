part of '../home.dart';

class _DataList extends StatelessWidget {
  final String period;

  const _DataList({required this.period});

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
                  child: Text(
                    'See All',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: ProductColor().white,
                    ),
                  ),
                ),
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Card(
                  color: ProductColor().white,
                  child: Padding(
                    padding: ProductPadding.ten(),
                    child: Column(
                      children: [
                        CustomRichText(
                          title: 'Title',
                          subTitle: 'Sub Title',
                        ),
                        HorizontalSpace.xxs(),
                        CustomRichText(
                          title: 'Title',
                          subTitle: 'Sub Title',
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
