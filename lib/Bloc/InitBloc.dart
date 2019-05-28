import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/suppliermodel.dart';
import 'validator.dart';

class InitiateBloc extends Object with Validators 
{
  //Initiate Streams (Product, Cutomers, Suppliers) List
  final _initProductsController = BehaviorSubject<List<Product>>();
  final _initCustomersController = BehaviorSubject<List<Customer>>();
  final _initSuppliersController = BehaviorSubject<List<Supplier>>();
  
  Stream<List<Product>> get initProducts => _initProductsController.transform(productValidator);
  Stream<List<Customer>> get initCustomers => _initCustomersController.transform(customerValidator);
  Stream<List<Supplier>> get initSuppliers => _initSuppliersController.transform(supplierValidator);
 
  Function(List<Product>) get initProductsChanged => _initProductsController.sink.add;
  Function(List<Customer>) get initCustomersChanged => _initCustomersController.sink.add;
  Function(List<Supplier>) get initSuppliersChanged => _initSuppliersController.sink.add;

  initiateProductList(List<Product> productList)
  {
    List<Product> products=[];
    if(_initProductsController.hasValue)
    { products.addAll(_initProductsController.value);}  
    products.addAll(productList);
    _initProductsController.sink.add(products);
  }
  
  initiateCustomerList(List<Customer> customerList)
  {
    List<Customer> customers=[];
    if(_initCustomersController.hasValue)
    { customers.addAll(_initCustomersController.value); }  
    customers.addAll(customerList);
    _initCustomersController.sink.add(customers);
  }
  
  initiateSupplierList(List<Supplier> supplierList)
  {
    List<Supplier> suppliers=[];
    if(_initSuppliersController.hasValue)
    { suppliers.addAll(_initSuppliersController.value); }  
    suppliers.addAll(supplierList);
    _initSuppliersController.sink.add(suppliers);
  } 

  getProductName(String code)
  { String desc;
    if(_initProductsController.hasValue)
    { desc = _initProductsController.value.where((prod) => prod.productCode.trim() == code.trim()).first.description;}
    desc = (desc == null || desc == "") ? 'No description found' : desc;
    return desc;
  }

  getCustomerName(String code)
  { String name;
    if(_initCustomersController.hasValue)
    { name = _initCustomersController.value.where((cust) => cust.customerCode.trim() == code.trim()).first.customerName;}
    name = (name == null || name == "") ? 'No Name found' : name;
    return name;
  }
  
  getSupplierName(String code)
  { String name;
    if(_initSuppliersController.hasValue)
    { name = _initSuppliersController.value.where((supp) => supp.customerCode.trim() == code.trim()).first.customerName;}
    name = (name == null || name == "") ? 'No Name found' : name;
    return name;
  }

  // End of (Product, Cutomers, Suppliers) List
}