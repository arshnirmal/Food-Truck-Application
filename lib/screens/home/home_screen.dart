import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/controllers/home_repository.dart';
import 'package:food_truck/models/coupon.dart';
import 'package:food_truck/models/food_items/category.dart';
import 'package:food_truck/models/food_truck/food_truck.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/screens/home/bloc/home_bloc.dart';
import 'package:food_truck/screens/home/cubit/category_cubit.dart';
import 'package:food_truck/screens/home/cubit/location_cubit.dart';
import 'package:food_truck/utils/logger.dart';
import 'package:food_truck/utils/utils.dart';
import 'package:food_truck/widgets/coupon_widget.dart';
import 'package:food_truck/widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeRepository _homeRepository = HomeRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => HomeBloc(_homeRepository),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(homeRepository: _homeRepository),
                const Greetings(),
                const SearchBar(),
                Categories(homeRepository: _homeRepository),
                const Body(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  final HomeRepository homeRepository;
  const Header({super.key, required this.homeRepository});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late final LocationCubit _locationCubit;

  @override
  void initState() {
    super.initState();

    _locationCubit = LocationCubit(widget.homeRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              R.icons.menuButton,
              height: 45,
              width: 45,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CURRENT LOCATION',
                style: R.textStyles.fz12.merge(R.textStyles.fw700).merge(R.textStyles.fcPrimary),
              ),
              BlocBuilder<LocationCubit, LocationState>(
                bloc: _locationCubit,
                builder: (context, state) {
                  if (state is LocationInitial) {
                    _locationCubit.fetchLocations();
                  } else if (state is LocationError) {
                    logE('Failed to fetch locations');
                    return Text(
                      'Failed to fetch locations',
                      style: R.textStyles.fz14.merge(R.textStyles.fw400).merge(R.textStyles.fcTextGrey2),
                    );
                  } else if (state is LocationLoading) {
                    return SizedBox(
                      height: 4,
                      width: 64,
                      child: LinearProgressIndicator(
                        color: R.colors.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  } else if (state is LocationLoaded) {
                    logD('Locations: ${state.locations} Selected: ${state.selectedLocation}');
                    return DropdownButton(
                      value: state.selectedLocation,
                      padding: const EdgeInsets.all(0),
                      isDense: true,
                      hint: Text(
                        'Select Location',
                        style: R.textStyles.fz14.merge(R.textStyles.fw400).merge(R.textStyles.fcTextGrey2),
                      ),
                      items: state.locations.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: R.textStyles.fz14.merge(R.textStyles.fw400).merge(R.textStyles.fcTextGrey2),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        _locationCubit.selectLocation(value ?? '');
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
          const Spacer(),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Badge(
                label: Text(
                  state.cartCount.toString(),
                  // '2',
                  style: R.textStyles.fz16.merge(R.textStyles.fw700).merge(R.textStyles.fcWhite),
                ),
                isLabelVisible: state.cartCount != 0,
                alignment: Alignment.topRight,
                backgroundColor: R.colors.primaryColor,
                largeSize: 25,
                offset: const Offset(-8, 8),
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    R.icons.cartButton,
                    height: 45,
                    width: 45,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Greetings extends StatelessWidget {
  const Greetings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hey User, ', // 'Hey ${state.name},' //TODO: Uncomment this line
                  style: R.textStyles.fz16.merge(R.textStyles.fw400).merge(R.textStyles.fcTextBlack),
                ),
                TextSpan(
                  text: 'Good ${greetUser()}!',
                  style: R.textStyles.fz16.merge(R.textStyles.fw700).merge(R.textStyles.fcTextBlack),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: R.colors.bgWhite,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              R.icons.searchButton,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'Search dishes, restaurants',
              style: R.textStyles.fz14.merge(R.textStyles.fw400).merge(R.textStyles.fcTextGrey2),
            )
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final HomeRepository homeRepository;
  const Categories({super.key, required this.homeRepository});

  @override
  Widget build(BuildContext context) {
    final CategoryCubit categoryCubit = CategoryCubit(homeRepository);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          HomeTitleTile(
            title: 'Categories',
            onTap: () {},
          ),
          const SizedBox(
            height: 8,
          ),
          BlocBuilder<CategoryCubit, CategoryState>(
            bloc: categoryCubit,
            builder: (context, state) {
              return SizedBox(
                height: 65,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(right: 24),
                  itemCount: 10, // state.categories.length,
                  itemBuilder: (context, index) {
                    // final category = state.categories[index]; // TODO: Uncomment this line
                    final category = Category(
                      id: index,
                      name: 'Burger',
                      imageUrl: 'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_960_720.jpg',
                    );

                    if (index == 0) {
                      return CategoryTile(
                        onTap: () {
                          categoryCubit.selectCategory(0);
                        },
                        isSelected: state.selectedCategory == 0,
                        category: Category(
                          id: 0,
                          name: 'All',
                          imageUrl: 'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_960_720.jpg',
                        ),
                      );
                    }

                    return CategoryTile(
                      onTap: () {
                        categoryCubit.selectCategory(category.id);
                      },
                      isSelected: state.selectedCategory == category.id,
                      category: category,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          HomeTitleTile(
            title: 'Open Trucks',
            onTap: () {
              showCouponDialog(
                context,
                Coupon(code: 'ABC', description: "This is a test coupon"),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              final foodtruck = FoodTruck(
                name: 'Burger King',
                imageUrl: 'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_960_720.jpg',
                location: Loaction(
                  name: 'New York',
                  latitude: '40.7128',
                  longitude: '74.0060',
                ),
                description: 'Burger King is a fast food restaurant chain that specializes in hamburgers.',
                rating: 4.5,
                distance: 2.5,
                waitingTime: 20,
              );

              return FoodTruckTile(
                foodTruck: foodtruck,
              );
            },
          )
        ],
      ),
    );
  }
}
