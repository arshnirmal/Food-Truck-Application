import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/controllers/home_repository.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/screens/home/bloc/home_bloc.dart';

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
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HomeBloc(_homeRepository),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              Greetings(),
              SearchBar(),
              Categories(),
              Body(),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

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
                'DELEVER TO',
                style: R.textStyles.fz12.merge(R.textStyles.fw700).merge(R.textStyles.fcPrimary),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Select Location',
                          // state.selectedLocation, //TODO: Uncomment this line
                          style: R.textStyles.fz14.merge(R.textStyles.fw400).merge(R.textStyles.fcTextGrey2),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(
                          R.icons.downArrow,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  R.icons.cartButton,
                ),
              ),
              Positioned(
                right: 8,
                top: 4,
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.cartCount == 0) {
                      return const SizedBox();
                    }

                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: 25,
                        height: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: R.colors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          // state.cartCount.toString(), //TODO: Uncomment this line
                          '0',
                          style: R.textStyles.fz16.merge(R.textStyles.fw700).merge(R.textStyles.fcWhite),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
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
                  text: 'Good Morning!',
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
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'All Categories',
                style: R.textStyles.fz20.merge(R.textStyles.fw400).merge(R.textStyles.fcTextBlack2),
              ),
              Text(
                'See All',
                style: R.textStyles.fz16.merge(R.textStyles.fw400).merge(R.textStyles.fcTextBlack3),
              ),
              SvgPicture.asset(
                R.icons.forwordArrow,
              ),
            ],
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
    return Container();
  }
}
