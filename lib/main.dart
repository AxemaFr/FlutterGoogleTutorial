import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'list-item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
      ),
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map((WordPair pair) {
              return ListItem(title: pair.first, subtitle: pair.second, leftIcon: null, rightIcon: null);
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    Random r = new Random();
    double falseProbability = .5;
    bool leftRandom = r.nextDouble() > falseProbability;
    bool rightRandom = r.nextDouble() > falseProbability;

    final alreadySaved = _saved.contains(pair);

    Icon leftIcon = leftRandom ? Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    ) : null;
    Icon rightIcon = rightRandom ? Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    ) : null;

    return new ListItem(
        title: pair.first,
        subtitle: pair.second,
        leftIcon: leftIcon,
        rightIcon: rightIcon,
        onTap: (title, subtitle) => this._handleItemClick(title, subtitle)
    );
  }

  void _handleItemClick(String title, String subtitle) {
    print('abc');
    final pair = new WordPair(title, subtitle);
    final alreadySaved = _saved.contains(pair);

    setState(() {
      if (alreadySaved) {
        _saved.remove(pair);
      } else {
        _saved.add(pair);
      }
    });
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }
}
