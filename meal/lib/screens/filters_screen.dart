import "package:flutter/material.dart";
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchTile(String title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: currentValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () => widget.saveFilters({
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            }),
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchTile(
                  "Gluten Free",
                  "description",
                  _glutenFree,
                  (newValue) => {
                        setState(() {
                          _glutenFree = newValue;
                        })
                      }),
              _buildSwitchTile(
                  "Vegetarian",
                  "description",
                  _vegetarian,
                  (newValue) => {
                        setState(() {
                          _vegetarian = newValue;
                        })
                      }),
              _buildSwitchTile(
                  "Lactose Free",
                  "description",
                  _lactoseFree,
                  (newValue) => {
                        setState(() {
                          _lactoseFree = newValue;
                        })
                      }),
              _buildSwitchTile(
                  "Vegan",
                  "description",
                  _vegan,
                  (newValue) => {
                        setState(() {
                          _vegan = newValue;
                        })
                      }),
            ],
          ))
        ],
      ),
    );
  }
}
