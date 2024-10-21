import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/models/coupon.dart';
import 'package:food_truck/resources/res.dart';

class CouponWidget extends StatelessWidget {
  final Coupon coupon;
  const CouponWidget({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 395,
          width: 327,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xffe76f00), Color(0xffffeb34)],
              stops: [0, 1],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.circular(35),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
            child: Stack(
              children: [
                Positioned(
                  child: SvgPicture.asset(
                    R.images.couponBackground,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hurry Offers!',
                      style: R.textStyles.fz40.merge(R.textStyles.fw900).merge(R.textStyles.fcWhite),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      coupon.code,
                      style: R.textStyles.fz30.merge(R.textStyles.fw700).merge(R.textStyles.fcWhite),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      coupon.description,
                      style: R.textStyles.fz18.merge(R.textStyles.fw700).merge(R.textStyles.fcWhite),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 62,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: R.colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'GOT IT',
                          style: R.textStyles.fz16.merge(R.textStyles.fw700).merge(R.textStyles.fcWhite),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -0,
          right: -0,
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              R.icons.couponCloseButton,
              height: 45,
              width: 45,
            ),
          ),
        ),
      ],
    );
  }
}

showCouponDialog(BuildContext context, Coupon coupon) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        content: CouponWidget(coupon: coupon),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      );
    },
  );
}
