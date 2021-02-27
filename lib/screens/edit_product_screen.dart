import 'package:flutter/material.dart';
import 'package:shop/provider/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-products';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _edittedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) setState(() {});
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _saveForm() {
   final isValid= _form.currentState.validate();
   if(!isValid)
   return ;
    _form.currentState.save();
    print(_edittedProduct.title);
    print(_edittedProduct.price);
    print(_edittedProduct.description);
    print(_edittedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value){
                if(value.isEmpty)
                return 'Please Provide a Value';
                return null;
              },
              onSaved: (value) {
                _edittedProduct = Product(
                  id: null,
                  title: value,
                  description: _edittedProduct.description,
                  price: _edittedProduct.price,
                  imageUrl: _edittedProduct.imageUrl,
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator: (value){
                if(value.isEmpty)
                return 'Plz enter a price!';
                if(double.tryParse(value)==null)
                return 'Plz enter a valid number';
                if(double.parse(value)<=0)
                return 'Enter no. > 0';

                return null;
              },
              onSaved: (value) {
                _edittedProduct = Product(
                  id: null,
                  title: _edittedProduct.title,
                  description: _edittedProduct.description,
                  price: double.parse(value),
                  imageUrl: _edittedProduct.imageUrl,
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 2,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              validator: (value){
                if(value.isEmpty)
                return 'Enter a description';
                if(value.length < 10)
                return 'Should be atleast 10 characters';

                return null;

              },
              onSaved: (value) {
                _edittedProduct = Product(
                  id: null,
                  title: _edittedProduct.title,
                  description: value,
                  price: _edittedProduct.price,
                  imageUrl: _edittedProduct.imageUrl,
                );
              },
              // textInputAction: TextInputAction.next,
              // onFieldSubmitted: (_) {
              //   FocusScope.of(context).requestFocus(_priceFocusNode);
              // },
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(
                    top: 8,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? Text('Enter a URL')
                      : FittedBox(
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    validator: (value)
                    {
                      if(value.isEmpty)
                      return 'Provide a url';
                      if(!value.startsWith('http') &&!value.startsWith('https') )
                      return 'Enter a valid url';
                      if(!value.endsWith('.png')&&!value.endsWith('jpg')&&!value.endsWith('jpeg'))
                      return 'enter a valid extension file';

                      return null;
                    },
              onSaved: (value) {
                _edittedProduct = Product(
                  id: null,
                  title: _edittedProduct.title,
                  description: _edittedProduct.description,
                  price: _edittedProduct.price,
                  imageUrl: value,
                );
              },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
