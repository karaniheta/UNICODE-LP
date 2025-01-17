import 'dart:async';
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
  Timer? _debounce;

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
    searchController.addListener(_onSearchChanged);
    _cachedFuture = getPostApi();
  }

  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        _fetchSearchResults(searchController.text);
      } else {
        _cachedFuture = getPostApi();
      }
    });
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
                  _selectedChipIndex])); // updated api url with category variable and category as Categories[_selectedChipIndex]
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

  Future<void> _fetchSearchResults(String query) async {
    try {
      final response = await http.get(Uri.parse(
          'https://unicode-flutter-lp-new-final.onrender.com/search_products?q=$query'));

      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        setState(() {
          Dmenu = data.map<PostsModel>((i) => PostsModel.fromJson(i)).toList();
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
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
                  return Text('loading...');
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
                            icon: Icon(Icons.notifications),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 690,
                            decoration: BoxDecoration(color: Color(0xFFF8E3B6)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, right: 20, left: 20),
                                  child: SearchBar(
                                    controller: searchController,
                                    onChanged: (value) => _onSearchChanged(),
                                    leading: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.search)),
                                    trailing: [
                                      IconButton(
                                        onPressed: () {
                                          _onSearchChanged();
                                        },
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
                                        backgroundColor: Color(
                                            0xFFF8E3B6), // Transparent background when not selected
                                        selectedColor: Color(
                                            0xFF834D1E), // Brown background when selected
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Adjust border radius
                                          side: BorderSide(
                                            color: Color(
                                                0xFF834D1E), // Brown border
                                            width: 2, // Border thickness
                                          ),
                                        ),
                                        label: Text(
                                          'All',
                                          style: TextStyle(
                                            color: _selectedChipIndex == 0
                                                ? Colors
                                                    .white // White text when selected
                                                : Color(
                                                    0xFF834D1E), // Brown text when not selected
                                          ),
                                        ),
                                        selected: _selectedChipIndex == 0,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _selectedChipIndex = (selected
                                                ? 0
                                                : null)!; // Update selected chip index
                                            _cachedFuture =
                                                getPostApi(); // Call your function here
                                          });
                                        },
                                      ),
                                      ChoiceChip(
                                        backgroundColor: Color(
                                            0xFFF8E3B6), // Transparent background when not selected
                                        selectedColor: Color(
                                            0xFF834D1E), // Brown background when selected
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Adjust border radius
                                          side: BorderSide(
                                            color: Color(
                                                0xFF834D1E), // Brown border
                                            width: 2, // Border thickness
                                          ),
                                        ),
                                        label: Text(
                                          'Hot Beverages',
                                          style: TextStyle(
                                            color: _selectedChipIndex == 1
                                                ? Colors
                                                    .white // White text when selected
                                                : Color(
                                                    0xFF834D1E), // Brown text when not selected
                                          ),
                                        ),
                                        selected: _selectedChipIndex == 1,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _selectedChipIndex = (selected
                                                ? 1
                                                : null)!; // Update selected chip index
                                            _cachedFuture =
                                                getPostApi(); // Call your function here
                                          });
                                        },
                                      ),
                                      ChoiceChip(
                                        backgroundColor: Color(
                                            0xFFF8E3B6), // Transparent background when not selected
                                        selectedColor: Color(
                                            0xFF834D1E), // Brown background when selected
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Adjust border radius
                                          side: BorderSide(
                                            color: Color(
                                                0xFF834D1E), // Brown border
                                            width: 2, // Border thickness
                                          ),
                                        ),
                                        label: Text(
                                          'Cold Beverages',
                                          style: TextStyle(
                                            color: _selectedChipIndex == 2
                                                ? Colors
                                                    .white // White text when selected
                                                : Color(
                                                    0xFF834D1E), // Brown text when not selected
                                          ),
                                        ),
                                        selected: _selectedChipIndex == 2,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _selectedChipIndex = (selected
                                                ? 2
                                                : null)!; // Update selected chip index
                                            _cachedFuture =
                                                getPostApi(); // Call your function here
                                          });
                                        },
                                      ),
                                      ChoiceChip(
                                        backgroundColor: Color(
                                            0xFFF8E3B6), // Transparent background when not selected
                                        selectedColor: Color(
                                            0xFF834D1E), // Brown background when selected
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Adjust border radius
                                          side: BorderSide(
                                            color: Color(
                                                0xFF834D1E), // Brown border
                                            width: 2, // Border thickness
                                          ),
                                        ),
                                        label: Text(
                                          'Add-Ins',
                                          style: TextStyle(
                                            color: _selectedChipIndex == 3
                                                ? Colors
                                                    .white // White text when selected
                                                : Color(
                                                    0xFF834D1E), // Brown text when not selected
                                          ),
                                        ),
                                        selected: _selectedChipIndex == 3,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _selectedChipIndex = (selected
                                                ? 3
                                                : null)!; // Update selected chip index
                                            _cachedFuture =
                                                getPostApi(); // Call your function here
                                          });
                                        },
                                      ),
                                      ChoiceChip(
                                        backgroundColor: Color(
                                            0xFFF8E3B6), // Transparent background when not selected
                                        selectedColor: Color(
                                            0xFF834D1E), // Brown background when selected
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Adjust border radius
                                          side: BorderSide(
                                            color: Color(
                                                0xFF834D1E), // Brown border
                                            width: 2, // Border thickness
                                          ),
                                        ),
                                        label: Text(
                                          'Syrups',
                                          style: TextStyle(
                                            color: _selectedChipIndex == 4
                                                ? Colors
                                                    .white // White text when selected
                                                : Color(
                                                    0xFF834D1E), // Brown text when not selected
                                          ),
                                        ),
                                        selected: _selectedChipIndex == 4,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _selectedChipIndex = (selected
                                                ? 4
                                                : null)!; // Update selected chip index
                                            _cachedFuture =
                                                getPostApi(); // Call your function here
                                          });
                                        },
                                      ),
                                      ChoiceChip(
                                        backgroundColor: Color(
                                            0xFFF8E3B6), // Transparent background when not selected
                                        selectedColor: Color(
                                            0xFF834D1E), // Brown background when selected
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Adjust border radius
                                          side: BorderSide(
                                            color: Color(
                                                0xFF834D1E), // Brown border
                                            width: 2, // Border thickness
                                          ),
                                        ),
                                        label: Text(
                                          'Food',
                                          style: TextStyle(
                                            color: _selectedChipIndex == 5
                                                ? Colors
                                                    .white // White text when selected
                                                : Color(
                                                    0xFF834D1E), // Brown text when not selected
                                          ),
                                        ),
                                        selected: _selectedChipIndex == 5,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _selectedChipIndex = (selected
                                                ? 5
                                                : null)!; // Update selected chip index
                                            _cachedFuture =
                                                getPostApi(); // Call your function here
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                // lower container UI
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFF834D1E)),
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
                                                          // image
                                                          image: NetworkImage(
                                                              Dmenu[index]
                                                                  .image
                                                                  .toString()),
                                                          fit: BoxFit.cover),
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
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
                                                                .only(top: 15),
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
                                                          Text(
                                                            "Rs.100",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF834D1E),
                                                                fontSize: 15),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF834D1E),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8), // Set button border radius
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                cart.addItem(
                                                                  Dmenu[index],
                                                                );
                                                              },
                                                              child: Text(
                                                                'Add to Cart',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14),
                                                              ))
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
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
