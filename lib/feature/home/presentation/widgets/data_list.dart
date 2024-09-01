part of '../home.dart';

class _DataList extends StatelessWidget {
  const _DataList();

  @override
  Widget build(BuildContext context) {
    return _CardWidget(
        buttonTitle: LocaleKeys.home_see_more.tr(),
        onPressed: () {
          'Button pressed'.log;
        },
        title: LocaleKeys.home_report.tr(),
        icon: ProductIcon.weight.icon,
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            gridDelegate: const GridDelegate.dashBoard(),
            itemBuilder: (context, index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ProductColor().white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: ProductPadding.ten(),
                  child: SpaceColumn(
                    space: SpaceValues.xs.value,
                    children: [
                      CustomRichText(
                        title: LocaleKeys.home_weight.tr(),
                        subTitle: 'Sub Title',
                      ),
                      CustomRichText(
                        title: LocaleKeys.home_bmi.tr(),
                        subTitle: 'Sub Title',
                      ),
                      CustomRichText(
                        title: LocaleKeys.home_situation.tr(),
                        subTitle: 'Sub Title',
                      ),
                      CustomRichText(
                        title: LocaleKeys.home_change.tr(),
                        subTitle: 'Sub Title',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ]);
  }
}
