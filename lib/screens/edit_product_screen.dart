import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

// image url: https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png
class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode(); // like useRef
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_imageURLListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _imageURLListener() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlController.text.startsWith('http')) return;
      setState(() {});
    }
  }

  void _saveForm() {
    setState(() {
      _isLoading = true;
    });
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();

    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct);
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .then((_) => {Navigator.of(context).pop()});
    }
    _isLoading = false;
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_imageURLListener);
    _priceFocusNode.dispose(); // free up the memory
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: _isLoading
          ? Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: _editedProduct.title,
                          decoration: InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: ((_value) => FocusScope.of(context)
                              .requestFocus(
                                  _priceFocusNode)), // done automatically by flutter now
                          validator: (value) {
                            if (value.isEmpty) return "add something";
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                              title: value,
                              price: _editedProduct.price,
                              description: _editedProduct.description,
                              id: _editedProduct.id,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _editedProduct.price.toString(),
                          decoration: InputDecoration(labelText: 'Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _priceFocusNode,
                          validator: (value) {
                            if (value.isEmpty) return "add something";
                            if (double.tryParse(value) == null)
                              return "add number";
                            if (double.parse(value) <= 0) return 'min price 0';
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                              title: _editedProduct.title,
                              price: double.parse(value),
                              description: _editedProduct.description,
                              id: _editedProduct.id,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _editedProduct.description,
                          decoration: InputDecoration(labelText: 'Description'),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          validator: (value) {
                            if (value.isEmpty) return "add something";
                            if (value.length < 10) return "atleast 10 char";
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: value,
                              id: _editedProduct.id,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite,
                            );
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(top: 8, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.green)),
                              child: _imageUrlController.text.isEmpty
                                  ? Text("Show URL")
                                  : FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(
                                          _imageUrlController.text)),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                focusNode: _imageUrlFocusNode,
                                onFieldSubmitted: (_value) => {_saveForm()},
                                validator: (value) {
                                  if (value.isEmpty) return "add something";
                                  if (!value.startsWith('http'))
                                    return "enter url";
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedProduct = Product(
                                    title: _editedProduct.title,
                                    price: _editedProduct.price,
                                    description: _editedProduct.description,
                                    id: _editedProduct.id,
                                    isFavorite: _editedProduct.isFavorite,
                                    imageUrl: value,
                                  );
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
