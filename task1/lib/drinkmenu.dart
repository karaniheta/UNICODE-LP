import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:task1/Models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task1/provider/cart_provider.dart';

List<PostsModel> Dmenu = [];

class Mydrinkmenu extends StatefulWidget {
  const Mydrinkmenu({super.key});

  @override
  State<Mydrinkmenu> createState() => _MydrinkmenuState();
}

class _MydrinkmenuState extends State<Mydrinkmenu> {
  int _selectedChipIndex = 0;
  String currentSelectedCat = "All";
  final TextEditingController searchController = TextEditingController();

  List<String> Categories = [
    "All",
    "Hot Beverages",
    "ICED BEVERAGES",
    "ADD-INS",
    "SYRUPS",
    "FOOD"
  ];

  Future<List<PostsModel>>? _cachedFuture;

  @override
  void initState() {
    super.initState();
    _cachedFuture = getPostApi();
  }

  Future<List<PostsModel>> getPostApi() async {
    final response;
    if (Categories[_selectedChipIndex] == "All") {
      response = await http.get(Uri.parse(
          'https://unicode-flutter-lp-new-final.onrender.com/get_all_products'));
    } else {
      response = await http.get(Uri.parse(
          'https://unicode-flutter-lp-new-final.onrender.com/get_products_by_category?category=' +
              Categories[
                  _selectedChipIndex])); //updated api url with category vagriable and categoty as Categories[_selectedChipIndex]
    }

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(data);
      Dmenu = data.map<PostsModel>((i) => PostsModel.fromJson(i)).toList();
      print(Dmenu[1].category);

      return Dmenu;
    } else {
      return Dmenu;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    print('Rebuilding again ');
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: _cachedFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('loaing...');
                } else {
                  return Column(
                    children: [
                      AppBar(
                        backgroundColor: Color(0xFFF8E3B6),
                        title: Text(
                          "What would you like to \n Drink Today?",
                          style:
                              TextStyle(color: Color(0xFF834D1E), fontSize: 18),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.notifications)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.menu))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              width: double.infinity,
                              height: 690,
                              decoration:
                                  BoxDecoration(color: Color(0xFFF8E3B6)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20, left: 20),
                                    child: SearchBar(
                                      controller: searchController,
                                      leading: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.search)),
                                      trailing: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.mic),
                                        )
                                      ],
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.white),
                                      hintText: 'Search...',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Wrap(
                                      spacing: 8.0,
                                      children: [
                                        ChoiceChip(
                                          backgroundColor: Color(0xFF834D1E),
                                          label: Text('All',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          selected: _selectedChipIndex == 0,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _selectedChipIndex =
                                                  (selected ? 0 : null)!;
                                            });
                                          },
                                        ),
                                        ChoiceChip(
                                          backgroundColor: Color(0xFF834D1E),
                                          label: Text('Hot Beverages',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          selected: _selectedChipIndex == 1,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _selectedChipIndex =
                                                  (selected ? 1 : null)!;
                                            });
                                          },
                                        ),
                                        ChoiceChip(
                                          backgroundColor: Color(0xFF834D1E),
                                          label: Text('Iced Beverages',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          selected: _selectedChipIndex == 2,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _selectedChipIndex =
                                                  (selected ? 2 : null)!;
                                            });
                                          },
                                        ),
                                        ChoiceChip(
                                          backgroundColor: Color(0xFF834D1E),
                                          label: Text(
                                            'Add-Ins',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          selected: _selectedChipIndex == 3,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _selectedChipIndex =
                                                  (selected ? 3 : null)!;
                                            });
                                          },
                                        ),
                                        ChoiceChip(
                                          backgroundColor: Color(0xFF834D1E),
                                          label: Text('SYRUPS',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          selected: _selectedChipIndex == 4,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _selectedChipIndex =
                                                  (selected ? 4 : null)!;
                                            });
                                          },
                                        ),
                                        ChoiceChip(
                                          backgroundColor: Color(0xFF834D1E),
                                          label: Text('FOOD',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          selected: _selectedChipIndex == 5,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _selectedChipIndex =
                                                  (selected ? 5 : null)!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  //lower container ui
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF834D1E)),
                                        color: Color(0xFFFCF2D9),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(60),
                                            topRight: Radius.circular(60))),
                                    width: double.infinity,
                                    height: 536,
                                    child: Consumer<Cart>(
                                      builder: (context, value, child) =>
                                          ListView.builder(
                                        itemCount: Dmenu.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            left: 15,
                                                            bottom: 8,
                                                            right: 8),
                                                    child: Container(
                                                      height: 150,
                                                      width: 110,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            //image
                                                            image: NetworkImage(
                                                                Dmenu[index]
                                                                    .image
                                                                    .toString()),
                                                            fit: BoxFit.cover),
                                                        //color: Color(0xFFFCF2D9),

                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 15),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  Dmenu[index]
                                                                          .name
                                                                          .toString() ??
                                                                      'no data',
                                                                  maxLines: 3,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          19,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xFF834D1E)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  cart.addItem(
                                                                    Dmenu[
                                                                        index],
                                                                    //Dmenu[index].name.toString(),
                                                                  );
                                                                },
                                                                child: Text(
                                                                    'Add to Cart'))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      )
                    ],
                  );
                }
              })
        ],
      ),
    ));
  }
}
