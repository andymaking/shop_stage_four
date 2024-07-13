import 'package:shopper/data/cache/constants.dart';
import 'package:shopper/utils/snack_message.dart';

import '../../../data/model/get-product-response.dart';
import '../../base-vm.dart';
import 'check-out.dart';

class CartViewModel extends BaseViewModel {
  List<Items> cartItems = [];

  deleteCartItem(int index) async {
    String name = cartItems[index].name??"";
    bool res = await repository.deleteFromCart(index);
    if(res){
      getCartItems();
      showCustomToast("$name removed from cart successfully", success:  true);
    }else{
      showCustomToast("Error removing $name");
    }
  }

  delete(int index)async{
    String name = cartItems[index].name??"";
    popDialog(
      context: navigationService.navigatorKey.currentState!.context,
      onTap: ()=> deleteCartItem(index),
      title: "Delete $name"
    );
  }

  getCartItems()async{
    startLoader();
    cartItems = await repository.getCart()??[];
    getPrice();
    notifyListeners();
    stopLoader();
  }

  updateItem(Items item, int index) async {
    cartItems[index] = item;
    print(cartItems[index].quantity);
    getPrice();
    await repository.storeCart(cartItems);
    notifyListeners();
  }

  navigateToCheckout(){
    navigationService.navigateToWidget(CheckOutScreen());
  }

  num totalPrice = 0;
  num discountedPrice = 0;
  num deliveryFee  = 1500;
  num payPrice = 0;

  getPrice() {
    totalPrice = cartItems.fold(0, (sum, item) => sum + ((item.quantity ?? 0)*(item.currentPrice?[0].value??0)));
    discountedPrice = totalPrice * (5/100);
    payPrice = (totalPrice + deliveryFee) - discountedPrice;

    print(payPrice);
    notifyListeners();
  }
}