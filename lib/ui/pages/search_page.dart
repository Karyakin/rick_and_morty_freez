import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rick_and_morty/bloc/character_bloc.dart';
import 'package:rick_and_morty/data/models/character.dart';

import '../widgets/custom_list_title.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Character _carrentCharacter;
  List<Results> _currentResults = [];
  int _currentPsge = 1;
  String _currentSearchStr = '';

  final RefreshController refreshController = RefreshController();
  bool _isPagination = false;

  @override
  void initState() {
    if (_currentResults.isEmpty) {
      context
          .read<CharacterBloc>()
          .add(const CharacterEvent.fetch(name: '', page: 1));
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 16, right: 15),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(59, 86, 86, 0.8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: 'Search Name',
                hintStyle: const TextStyle(color: Colors.white)),
            onChanged: (value) {
              _currentPsge = 1;
              _currentResults = [];
              _currentSearchStr = value;
              context
                  .read<CharacterBloc>()
                  .add(CharacterEvent.fetch(name: value, page: _currentPsge));
            },
          ),
        ),
        Expanded(
          child: state.when(
              loading: () {
                if (!_isPagination) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(strokeWidth: 2),
                        SizedBox(
                          width: 10,
                        ),
                        Text('loading...'),
                      ],
                    ),
                  );
                } else {
                  return _customListView(_currentResults);
                }
              },
              loaded: (characterLoaded) {
                _carrentCharacter = characterLoaded;
                if (_isPagination) {
                  // final List<Results> test = _currentResults;

                  // test.addAll(_carrentCharacter.results);

                  //_currentResults.addAll(_carrentCharacter.results);
                  _currentResults = _carrentCharacter.results;
                  refreshController.loadComplete();
                  _isPagination = false;
                } else {
                  _currentResults = _carrentCharacter.results;
                }

                return _currentResults.isNotEmpty
                    ? _customListView(
                        _currentResults) //Text('$_currentResults')
                    : const SizedBox();
              },
              error: () => const Text('Nothing found.')),
        ),
      ],
    );
  }

  Widget _customListView(List<Results> currentResult) {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp:
          true, // когда дойдем до конца списка чтобы появлялся идекатор загрузки
      enablePullDown: false, // когда дергаем список вних
      onLoading: () {
        _isPagination = true;
        _currentPsge++;
        if (_currentPsge <= _carrentCharacter.info.pages) {
          context.read<CharacterBloc>().add(CharacterEvent.fetch(
              name: _currentSearchStr, page: _currentPsge));
        } else {
          refreshController.loadNoData();
        }
      },
      child: ListView.separated(
        itemCount: currentResult.length,
        separatorBuilder: (_, index) => const SizedBox(height: 5),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final result = currentResult[index];
          return Padding(
              padding:
                  const EdgeInsets.only(right: 16, left: 16, bottom: 3, top: 3),
              child: CustomListTitle(results: result));
        },
      ),
    );
  }
}
