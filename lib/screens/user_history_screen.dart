import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/screens/disease_detection.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/themes/colors.dart';

class UserCommentsScreen extends StatefulWidget {
  @override
  State<UserCommentsScreen> createState() => _UserCommentsScreenState();
}

class _UserCommentsScreenState extends State<UserCommentsScreen> {
  var allItems = List.generate(50, (index) => 'item $index');
  var items = [];
  var searchHistory = [];
  final TextEditingController searchController = TextEditingController();
  late Future<List<dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService().getMyHistory(context, null, null);
    searchController.addListener(queryListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.isCurrent) {
      setState(() {
        _future = ApiService().getMyHistory(context, null, null);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(queryListener);
    searchController.dispose();
  }

  void queryListener() {}

  void search(String query) async {
    setState(() {
      _future = ApiService().getMyHistory(context, null, query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // the desired height
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.background,
          elevation: 0.5,
          title: Text(
            "My Disease History",
            style: GoogleFonts.poppins(
              color: AppColors.onSurface,
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
            child: SizedBox(
              height: 40,
              child: SearchBar(
                onSubmitted: (query) {
                  search(query);
                },
                surfaceTintColor: MaterialStateProperty.all(AppColors.surface),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.background),
                overlayColor: MaterialStateProperty.all(AppColors.onPrimary),
                shadowColor:
                    MaterialStateProperty.all(AppColors.secondaryVariant),
                controller: searchController,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: AppColors.onSurface,
                  ),
                ),
                hintText: 'Search',
                textStyle: MaterialStateProperty.all(GoogleFonts.poppins(
                  color: AppColors.onSurface,
                )),
              ),
            ),
          ),
          Center(
            child: FutureBuilder<List<dynamic>>(
              future: ApiService()
                  .getMyHistory(context, 200, searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final List<dynamic> history = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: history.map((historyData) {
                        final String date = DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(historyData['dateTime']));
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiseaseDetection(
                                    data: {
                                      ...historyData['responses'][0],
                                      'imageUrl': historyData['imageUrl']
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Color(0xFFF8F9F9),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Color(0xFFE3E9E9),
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(historyData['imageUrl']),
                                ),
                                title: Text(
                                  'Disease: ${historyData['responses'][0]['label']}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                                subtitle: Text(
                                  'Date: $date',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: Color(0xFF2B826D),
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DiseaseDetection(
                                          data: {
                                            ...historyData['responses'][0],
                                            'imageUrl': historyData['imageUrl']
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return Text("No history available");
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
