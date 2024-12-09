import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urban_bites/models/food_items/category.dart';
import 'package:urban_bites/models/food_truck/food_truck.dart';
import 'package:urban_bites/resources/res.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final Function() onTap;
  final bool isSelected;
  const CategoryTile({super.key, required this.category, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? R.colors.secondaryOrange : R.colors.white,
            borderRadius: BorderRadius.circular(50),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  category.imageUrl,
                  height: 44,
                  width: 44,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                category.name,
                style: R.textStyles.fz14.merge(R.textStyles.fw700).merge(R.textStyles.fcTextBlack2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTitleTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  const HomeTitleTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: R.textStyles.fz20.merge(R.textStyles.fw400).merge(R.textStyles.fcTextBlack2),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Text(
                  'See All',
                  style: R.textStyles.fz16.merge(R.textStyles.fw400).merge(R.textStyles.fcTextBlack3),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  R.icons.forwardArrow,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FoodTruckTile extends StatelessWidget {
  final FoodTruck foodTruck;

  const FoodTruckTile({
    super.key,
    required this.foodTruck,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      margin: const EdgeInsets.only(bottom: 24),
      color: R.colors.white,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              foodTruck.imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodTruck.name,
                  style: R.textStyles.fz16.merge(R.textStyles.fw700).merge(R.textStyles.fcTextBlack2),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  foodTruck.location.name,
                  style: R.textStyles.fz14.merge(R.textStyles.fw400).merge(R.textStyles.fcHintText),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      R.icons.starRating,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      foodTruck.rating.toString(),
                      style: R.textStyles.fz16.merge(R.textStyles.fw700).merge(R.textStyles.fcTextBlack3),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    SvgPicture.asset(
                      R.icons.timeToDestination,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      foodTruck.distance.toString(),
                      style: R.textStyles.fz16.merge(R.textStyles.fw700).merge(R.textStyles.fcTextBlack3),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    SvgPicture.asset(
                      R.icons.waitingTime,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      foodTruck.waitingTime.toString(),
                      style: R.textStyles.fz16.merge(R.textStyles.fw700).merge(R.textStyles.fcTextBlack3),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
