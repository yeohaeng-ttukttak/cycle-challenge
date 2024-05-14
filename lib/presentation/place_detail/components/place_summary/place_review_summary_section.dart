import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak/domain/model/place_review.dart';
import 'package:yeohaeng_ttukttak/presentation/place_detail/components/place_review_list_item.dart';
import 'package:yeohaeng_ttukttak/presentation/place_detail/components/place_review_report_section.dart';

class PlaceReviewSummarySection extends StatelessWidget {
  final List<PlaceReview> reviews;
  final List<double> ratings;

  const PlaceReviewSummarySection(
      {super.key, required this.reviews, required this.ratings});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
        color: colorScheme.surface,
        padding: const EdgeInsets.only(top: 30, bottom: 15),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('방문자 리뷰',
                        style: textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    PlaceReviewReportSection(ratings: ratings),
                    const SizedBox(height: 12),
                    ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: min(2, reviews.length),
                        itemBuilder: (context, index) =>
                            PlaceReviewListItem(review: reviews[index]),
                        separatorBuilder: (_, __) => const Divider())
                  ])),
          Align(
              alignment: Alignment.centerRight,
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_left),
                      label: const Text('리뷰 더보기'))))
        ]));
  }
}