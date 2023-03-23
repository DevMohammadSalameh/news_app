import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("News"),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_rounded, size: 35)),
              IconButton(
                  onPressed: () {
                    NewsCubit.get(context).changeDarkTheme();
                  },
                  icon: NewsCubit.get(context).isDarkTheme
                      ? const Icon(Icons.dark_mode_outlined, size: 35)
                      : const Icon(Icons.light_mode, size: 35))
            ],
          ),
          body: NewsCubit.get(context)
              .screens[NewsCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              NewsCubit.get(context).changeBottomNavIndex(index);
            },
            currentIndex: NewsCubit.get(context).currentIndex,
            items: NewsCubit.get(context).bottomItems,
          ),
        );
      },
    );
  }
}
