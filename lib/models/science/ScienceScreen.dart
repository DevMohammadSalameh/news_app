import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).scienceArticles;
        // print("THE Sc LIST \n ${list.toString()}");
        return state is! NewsLoadingScienceState
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildArticleItem(list[index], context),
                separatorBuilder: (context, index) => itemsDivider(),
                itemCount: list.length)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
