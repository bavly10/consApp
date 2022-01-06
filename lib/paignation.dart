import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/model/categories_model.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPagination extends StatefulWidget {
  @override
  _TestPaginationState createState() => _TestPaginationState();
}

class _TestPaginationState extends State<TestPagination> {

  int pagnitation=4;
  List<String> items = [];
  bool loading = false, allloaded = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    mockFetch();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !loading)
      {
        print("new Data Loading");
        getMoreData();
        mockFetch();
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  String imgurl = base_api;
  List<Categories>cubit=[];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cons_Cubit,cons_States>(
      builder: (ctx,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Pagination",
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: LayoutBuilder(
            builder: (context, constraint) {
              if (cubit.isNotEmpty) {
                return Stack(
                  children: [
                    ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          if (index < cubit.length) {
                            return Card(
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child:CachedNetworkImage(
                                          width: double.infinity,
                                          height: 250,
                                          imageUrl:imgurl+cubit[index].catImg.url!,
                                          placeholder: (context, url) => SpinKitCircle(color: Colors.green,),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                      ),
                                      const SizedBox(width: 15,),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const  Icon(Icons.verified,color:Colors.blue,size: 20,),
                                            const SizedBox(height: 8,),
                                            Text(cubit[index].title,style: TextStyle(fontSize: 14,color:Colors.blue)),
                                            const SizedBox(height: 8,),
                                            Row(children: [
                                              Icon(Icons.place_rounded,color: myAmber,),
                                              const SizedBox(width: 8,),
                                              const  Text("الشارقه")
                                            ],)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                          } return  const Text("No More Data");
                        },
                        itemCount: cubit.length + (allloaded ? 1 : 0)),
                    if (loading) ...[
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: constraint.maxWidth,
                          height: 80,
                          child: const Center(
                            child: CircularProgressIndicator(color: Colors.green,),
                          ),
                        ),
                      )
                    ]
                  ],
                );
              } else {
                return  const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  mockFetch() async {
    if (allloaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    List <Categories>cubitt =cons_Cubit.get(context).mycat.length >=15
        ? []
        : List.generate(4, (index) => cons_Cubit.get(context).mycat[index],);
    if (cubitt.isNotEmpty) {
    cubit.addAll(cubitt);
    }
    setState(() {
      loading = false;
    });
  }
  void getMoreData(){
    setState(() {
      pagnitation+2;
    });
  }
}
