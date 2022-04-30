import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/modules/Deatils_Special/deatils_specail.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialList extends StatefulWidget {
  final String cat;
  SpecialList(this.cat);

  @override
  State<SpecialList> createState() => _SpecialListState();
}

class _SpecialListState extends State<SpecialList> {
  bool loading = false, allloaded = false;

  final ScrollController _scrollController = ScrollController();

  String imgurl = base_api;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsCubit, cons_States>(
      builder: (context, state) {
        final cubit = ConsCubit.get(context)
            .myspec
            .where((element) => element.catTitle.title == widget.cat);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: myAmber,
                  ))
            ],
            title: Text(
              widget.cat,
              style: TextStyle(color: myAmber, fontSize: 22),
            ),
          ),
          body: ListView(
            controller: _scrollController,
            children: cubit
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        navigateTo(
                            context, IntroducerSpecial(e.specTitle, e.id));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e.specTitle,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700]),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
