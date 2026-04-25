import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../cubit/screens/category/category_cubit.dart';
import 'cuslistbutton.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["All", "Work", "Personal" , "Health", "Others"];

    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (context) => CategoryCubit(),
      child: Container(
        width: screenWidth,
        height: screenHeight * .05,
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected =
                    state is CategoryInitial &&
                    state.selectedcategory == category;
                return GestureDetector(
                  onTap: () {
                    context.read<CategoryCubit>().selectCategory(category);
                  },
                  child: Row(
                    children: [
                      Gap(screenWidth * .025),

                      Cuslistbutton(
                        color: isSelected ? Colors.blue : Colors.grey,
                        custext: '$category',
                      ),
                    ],
                  ),
                );
              },
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
            );
          },
        ),
      ),
    );
  }
}
