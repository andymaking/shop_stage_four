import 'package:flutter/cupertino.dart';
import 'package:shopper/data/cache/app-images.dart';

import '../../base-vm.dart';

class HomeViewModel extends BaseViewModel {

  List<Product> techProduct = [
    Product(
        name: "Joystick Game Controller",
        description: "Wired UCOM USB Pad....",
        image: AppImages.pad,
        price: 11250,
        rating: 5
    ),
    Product(
        name: "Apple IPhone 14 Pro",
        description: "6GB RAM + 128GB ROM",
        image: AppImages.phone,
        price: 1450000,
        rating: 5
    ),
    Product(
        name: "Touch Screen Smart Watch",
        description: "For Andriod & IOS",
        image: AppImages.watch,
        price: 9170,
        rating: 4
    ),
    Product(
        name: "Itel Bluetooth Earphones",
        description: "BUDS ACE Wireless Earpods",
        image: AppImages.earpod,
        price: 17660,
        rating: 5
    ),
    Product(
        name: "HP ENVY 15 X360",
        description: "INTEL Core i7 16GB RAM 512... ",
        image: AppImages.laptop,
        price: 1300000,
        rating: 5
    ),
    Product(
        name: "Oriamo 2000mAH PowerBank",
        description: "Wired UCOM USB Pad for PC....",
        image: AppImages.pad,
        price: 19990,
        rating: 5
    ),
    Product(
        name: "Joystick Game Controller",
        description: "Wired UCOM USB Pad....",
        image: AppImages.pad,
        price: 11250,
        rating: 5
    ),

  ];

  init()async{
    chunkGagdetList = chunkList(techProduct, 2);
  }

  List<List<Product>> chunkList(List<Product> list, int chunkSize) {
    List<List<Product>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }

  List<List<Product>> chunkGagdetList = [];

  var gagdetPageController = PageController();

  int gagdetIndex = 0;

  changeGagdetView(int? index){
    gagdetIndex = index??0;
    notifyListeners();
  }

  jump(int index){
    gagdetPageController.jumpTo(index.toDouble());
    notifyListeners();
  }



}

class Product {
  String name;
  String description;
  String image;
  double price;
  double rating;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
  });
}