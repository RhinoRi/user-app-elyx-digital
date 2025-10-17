import 'package:elyx_digital_user_app/core/constants/app_colors.dart';
import 'package:elyx_digital_user_app/features/users/bloc/user_bloc.dart';
import 'package:elyx_digital_user_app/features/users/bloc/user_event.dart';
import 'package:elyx_digital_user_app/features/users/bloc/user_state.dart';
import 'package:elyx_digital_user_app/features/users/widgets/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<UserBloc>().add(LoadMoreUsersEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppbar(
          isSearching: isSearching,
          ctrler: _searchController,
          context: context,
          iconPressed: () {
            setState(() {
              if (isSearching) {
                isSearching = false;
                _searchController.clear(); // Clear the search query

                BlocProvider.of<UserBloc>(context).add(UserFetchDataEvent());
              } else {
                isSearching = true;
              }
            });
          },
        ),
        body: BlocConsumer<UserBloc, UserState>(
          listenWhen: (previous, current) =>
              current is UserLoaded &&
              current.hasReachedEnd &&
              previous is UserLoaded &&
              !previous.hasReachedEnd,
          listener: (context, state) {
            if (state is UserLoaded && state.hasReachedEnd) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No more data to load'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoading || state is UserInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(UserFetchDataEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is UserLoaded) {
              if (state.data.isEmpty) {
                return Center(child: Text("No such user exists"));
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<UserBloc>().add(RefreshUsersEvent());
                  },
                  child: UserListView(
                    usersList: state.data,
                    scrollCtrler: _scrollController,
                  ),
                );
              }
            } else {
              return Center(child: Text(noDataText));
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

PreferredSizeWidget myAppbar({
  required bool isSearching,
  required TextEditingController ctrler,
  required void Function()? iconPressed,
  required BuildContext context,
}) {
  return AppBar(
    centerTitle: true,
    toolbarHeight: 120,
    backgroundColor: appSecondaryColor,
    title: isSearching
        ?
          // search bar to filter list...
          TextField(
            autofocus: true,
            controller: ctrler,
            cursorColor: appPrimaryColor,
            decoration: InputDecoration(
              hintText: 'Search...',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: appSecondaryColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: appPrimaryColor, width: 2),
              ),
            ),
            onChanged: (query) {
              context.read<UserBloc>().add(UserSearchDataEvent(query));
            },
          )
        : Text(
            appName,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: appPrimaryColor,
              wordSpacing: 1.4,
            ),
          ),
    actions: [
      IconButton(
        icon: Icon(isSearching ? Icons.cancel : Icons.search),
        onPressed: iconPressed,
        color: appPrimaryColor,
      ),
    ],
  );
}
