import 'package:food/src/core/constraints.dart';
import 'package:food/src/infrastructure/models/category.dart';
import 'package:food/src/infrastructure/models/item.dart';
import 'package:food/src/infrastructure/models/subcategory.dart';
import 'package:food/src/infrastructure/repositories/localfood.dart';
import 'package:food/src/presentation/shared/controller/base.dart';

class FoodController extends BaseController {
  final _localdb = new LocalDB();

  List<LocalCategory> _categories = [];
  List<LocalCategory> get categories => _categories;

  List<LocalSubCategory> _subcategories = [];
  List<LocalSubCategory> get subcategories => _subcategories;

  List<LocalItem> _items = [];
  List<LocalItem> get items => _items;

  List<LocalCategory> _filtercategories = [];
  List<LocalCategory> get filtercategories => _filtercategories;

  List<LocalSubCategory> _filtersubcategories = [];
  List<LocalSubCategory> get filtersubcategories => _filtersubcategories;

  List<LocalItem> _filteritems = [];
  List<LocalItem> get filteritems => _filteritems;

  void resetFilter() {
    _filtercategories = [];
    _filtersubcategories = [];
    _filteritems = [];
    notifyListeners();
  }

  Future<void> getInitialData() async {
    await getCategories();
    await getAllSubCategories();
    await getAllItems();
  }

  Future<void> getCategories() async {
    try {
      _categories = [];
      setAppState(AppState.Busy);
      _categories = await _localdb.getCategories();
      setAppState(AppState.Idle);
    } catch (e) {
      setAppState(AppState.Idle);
    }
  }

  Future<void> getAllSubCategories() async {
    try {
      _subcategories = [];
      setAppState(AppState.Busy);
      _subcategories = await _localdb.getAllSubCategories();
      setAppState(AppState.Idle);
    } catch (e) {
      setAppState(AppState.Idle);
    }
  }

  Future<void> getAllItems() async {
    try {
      _items = [];
      setAppState(AppState.Busy);
      _items = await _localdb.getAllItems();
      setAppState(AppState.Idle);
    } catch (e) {
      setAppState(AppState.Idle);
    }
  }

  List<String> getCategoryItems(int catId) {
    List<String> _dataitems = [];
    try {
      List<int> _subCatIds = [];
      if (_filtercategories.isEmpty) {
        for (var item in _subcategories.where((e) => e.catId == catId)) {
          if (!_subCatIds.contains(item.subCatId))
            _subCatIds.add(item.subCatId);
        }
        for (var id in _subCatIds) {
          var selectedItems = _items.where((e) => e.subCatId == id).toList();
          selectedItems.forEach((e) => _dataitems.add(e.name));
        }
      } else {
        for (var item in _filtersubcategories.where((e) => e.catId == catId)) {
          if (!_subCatIds.contains(item.subCatId))
            _subCatIds.add(item.subCatId);
        }
        for (var id in _subCatIds) {
          var selectedItems =
              _filteritems.where((e) => e.subCatId == id).toList();
          selectedItems.forEach((e) => _dataitems.add(e.name));
        }
      }
    } catch (e) {
      print(e);
    }
    return _dataitems;
  }

  Future<void> searchItems(String text) async {
    List<int> _subCatIds = [];
    List<int> _catIds = [];

    _filteritems = await _localdb.searchItem(text);
    //retrive subcategory ids
    for (var item in _filteritems) {
      if (!_subCatIds.contains(item.subCatId)) _subCatIds.add(item.subCatId);
    }
    //set filter sub category
    _filtersubcategories = await _localdb.getSubCategoriesById(_subCatIds);
    //retrive category ids
    for (var item in _filtersubcategories) {
      if (!_catIds.contains(item.catId)) _catIds.add(item.catId);
    }
    //set filter category
    _filtercategories = await _localdb.getCategoriesById(_catIds);

    notifyListeners();
  }
}
