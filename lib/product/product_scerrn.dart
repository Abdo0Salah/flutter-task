import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../cubit/user_cubit.dart';
import '../../../../cubit/user_state.dart';
import '../apiModels/ProductModel.dart';
import '../theme/my_theme.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = 'ProductScreen';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 83.w,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SvgPicture.asset('assets/images/route.svg'),
          ),
        ),
        backgroundColor: const Color(0xffF5F9FE),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserFailureState) {
              print(state.errMessage);
              return Center(
                child: Text(
                  'Failed to load products: ${state.errMessage}',
                ),
              );
            } else {
              final products = context.read<UserCubit>().products;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: _buildProductList(products),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildProductList(List<Products> products) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 5.h),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1, color: MyTheme.primary,),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF004182)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(
                        size: 30.sp,
                        Icons.search,
                        color: MyTheme.primary,
                      ),
                      hintText: 'what do you search for?',
                      hintStyle: Theme.of(context).textTheme.bodySmall,),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.shopping_cart,
                  size: 30.0.sp,
                  color:  MyTheme.primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (192 / 250),
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 1.w,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductItem(product, index + 1);
          },
        ),
      ],
    );
  }

  Widget _buildProductItem(Products product, int index) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
          left: index.isEven ? 16.w : 0,
          right: index.isOdd ? 16.w : 0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(width: 2.w, color: Colors.blueGrey),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        product.images != null && product.images!.isNotEmpty
                            ? product.images!.first
                            : "",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline, size: 40),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 7.w,
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.all(2.h.w),
                          margin: EdgeInsets.only(left: 6.w),
                          decoration: BoxDecoration(
                            color:  MyTheme.whiteColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: const Icon(
                            Icons.favorite_outline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        product.description ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:Theme.of(context).textTheme.bodyMedium,

                ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Text("EGP ${product.price?.toString() ?? ""}",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Spacer(),
                           Text("EGP 12",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.w,
                  bottom: 5.h,
                  right: 8.w,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                           Text(
                            "Review",
                           style:  Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "(${product.rating?.toString() ?? " "})",
                            style:  Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(width: 4.w),
                           Icon(
                            Icons.star,
                            color: MyTheme.yellowColor,
                          ),
                          const Spacer(),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.all(5.w.h),
                              decoration: BoxDecoration(
                                color: MyTheme.primary,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child:  Icon(
                                Icons.add,
                                color: MyTheme.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
