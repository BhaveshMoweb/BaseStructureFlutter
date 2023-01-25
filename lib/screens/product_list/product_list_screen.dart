import 'package:base_structure/components/custom_gridview.dart';
import 'package:base_structure/components/custom_network_image.dart';
import 'package:base_structure/components/custom_text.dart';
import 'package:base_structure/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../model/product_response.dart';
import '../../utils/strings.dart';
import '../base_screen/base_screen.dart';
import 'bloc/products_bloc.dart';
import 'data/product_list_datasource.dart';
import 'data/product_list_repository.dart';

///    Created By Bhavesh Makwana on 11/01/23
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductsResponse?>? productList = [];

  /// this is the variable to manage loading
  bool isInLoadingState = false;

  ProductsBloc productsBloc = ProductsBloc(
      productListRepository: ProductListRepository(
          productListDataSource: ProductListDataSource()));

  @override
  void initState() {
    /// Api call to get list of products
    getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: getListScreenBody(),
      title: Label.productList,
      shouldShowBackButton: true,
    );
  }

  getListScreenBody() {
    return SafeArea(
      child: BlocListener<ProductsBloc, ProductsState>(
        bloc: productsBloc,
        listener: (context, state) {
          if (state is ProductsListStateFailure) {
            isInLoadingState = false;
          }
          if (state is ProductsListStateBusy) {
            isInLoadingState = true;
          }
          if (state is ProductsListStateSuccess) {
            isInLoadingState = false;
            productList = state.productsResponse;
          }
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
          bloc: productsBloc,
          builder: (context, state) {
            /// CustomGridView<TYPE OF YOUR LIST, index>, change your list class like below is String
            /// dataList : pass your list in dataList params
            /// noDataFoundText: if list empty, what message we want to show when list is empty
            return CustomGridView(
              dataList: productList!,
              shrinkWrap: true,
              columnCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 4.0,
              isInLoadingState: isInLoadingState,
              listItemView: (ProductsResponse? item, int index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Column(
                      children: [
                        /// network image view
                        Expanded(
                          child: CustomNetworkImage(
                            imageUrl: item!.image!,
                            placeHolderImage: ImageConstant.placeholderImage,
                            cache: true,
                          ),
                        ),

                        /// product title
                        SizedBox(
                            width: 80.w,
                            child: CustomText(
                              maxLine: 2,
                              text: item.title!,
                            )),
                      ],
                    ),
                  ),
                );
              },
              noDataFoundText: "No Products found!",
            );
          },
        ),
      ),
    );
  }

  void getProductList() {
    productsBloc.add(ProductListEvent());
  }
}
