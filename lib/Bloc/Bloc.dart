import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:split/Bloc/CommonVariables.dart';
// import 'package:split/Masterdata/uom.dart';
import 'package:split/src/APIprovider/customerApiProvider.dart';
import 'package:split/src/APIprovider/dashBoardApiProvider.dart';
import 'package:split/src/APIprovider/goodsReceiveApiProvider.dart';
import 'package:split/src/APIprovider/incotermApiProvider.dart';
import 'package:split/src/APIprovider/inquiryApiProvider.dart';
import 'package:split/src/APIprovider/invoiceApiProvider.dart';
import 'package:split/src/APIprovider/lookUpApiProvider.dart';
import 'package:split/src/APIprovider/masterProductApiProvider.dart';
import 'package:split/src/APIprovider/currencyApiProvider.dart';
import 'package:split/src/APIprovider/paymentApiProvider.dart';
import 'package:split/src/APIprovider/promotionApiProvider.dart';
import 'package:split/src/APIprovider/purchaseOrderApiProvider.dart';
import 'package:split/src/APIprovider/quotationApiProvider.dart';
import 'package:split/src/APIprovider/salesEntryApiProvider.dart';
import 'package:split/src/APIprovider/supplierApiProvider.dart';
import 'package:split/src/APIprovider/productCategoryApiprovider.dart';
import 'package:split/src/APIprovider/werehouseLocApiProvider.dart';
import 'package:split/src/Models/branchmodel.dart';
import 'package:split/src/Models/currencyModel.dart';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/dashBoardModel.dart';
import 'package:split/src/Models/goodsReceiveModel.dart';
import 'package:split/src/Models/incotermModel.dart';
import 'package:split/src/Models/inquiryModel.dart';
import 'package:split/src/Models/invoiceModel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/paymentModel.dart';
import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/productcategorymodel.dart';
import 'package:split/src/Models/lookupModel.dart';
import 'package:split/src/Models/promotionModel.dart';
import 'package:split/src/Models/purchaserOrderModel.dart';
import 'package:split/src/Models/quotationModel.dart';
import 'package:split/src/Models/salesEntryModel.dart';
import 'package:split/src/Models/suppliermodel.dart';
import 'validator.dart';


class Bloc extends Object with Validators 
{
  // Search streams
  final _searchTxtFldController = BehaviorSubject<String>();
  final _searchOptionDDController = BehaviorSubject<String>();
  Stream<String> get searchTextFld => _searchTxtFldController.stream.transform(validateTxtFld);
  Stream<String> get searchOptionDD => _searchOptionDDController.stream.transform(validateTxtFld);
  Function(String) get searchTextFldChanged => _searchTxtFldController.sink.add;
  Function(String) get searchOptionChanged => _searchOptionDDController.sink.add;

  listenSearch()
  {
    // _searchTxtFldController.stream.listen((onData) {
    // yet to implement
    // });
  }


  // End OF Search Streams
  // Supplier Tariff
  // final _stSuppController = BehaviorSubject<LisUomList

  //Initiate Streams (Product, Cutomers, Suppliers) List
  final _initUOMController = BehaviorSubject<List<Lookup>>();
  final _initIncoTermController = BehaviorSubject<List<Incoterm>>();
  final _initLocationController = BehaviorSubject<List<Lookup>>();
  final _initPaymentTypeController = BehaviorSubject<List<PaymentTypes>>();
  final _initCurrencyController = BehaviorSubject<List<Currency>>();
  final _initProdCategoryController = BehaviorSubject<List<ProductCategorys>>();
  final _initProductsController = BehaviorSubject<List<Product>>();
  final _initCustomersController = BehaviorSubject<List<Customer>>();
  final _initSuppliersController = BehaviorSubject<List<Supplier>>();
  final _initCountriesController = BehaviorSubject<List<CountryList>>();

  Stream<List<Lookup>> get initUOM => _initUOMController.transform(lookUpValidators);  
  Stream<List<Incoterm>> get initIncoterm => _initIncoTermController.transform(incoTermValidators);  
  Stream<List<Lookup>> get initLocation => _initLocationController.transform(lookUpValidators);  
  Stream<List<PaymentTypes>> get initPaymentType => _initPaymentTypeController.transform(paymentValidators);  
  Stream<List<Currency>> get initCurrency => _initCurrencyController.transform(currencyValidators);  
  Stream<List<ProductCategorys>> get initProdCategory => _initProdCategoryController.transform(productCategorysValidators);  
  Stream<List<Product>> get initProducts => _initProductsController.transform(productValidator);
  Stream<List<Customer>> get initCustomers => _initCustomersController.transform(customerValidator);
  Stream<List<Supplier>> get initSuppliers => _initSuppliersController.transform(supplierValidator);
  Stream<List<CountryList>> get initCountries => _initCountriesController.transform(countryValidator);
 
  Function(List<Lookup>) get initUOMChanged => _initUOMController.sink.add;
  Function(List<Incoterm>) get initIncotermChanged => _initIncoTermController.sink.add;
  Function(List<Lookup>) get initLocationChanged => _initLocationController.sink.add;
  Function(List<PaymentTypes>) get initPaymentTypeChanged => _initPaymentTypeController.sink.add;
  Function(List<Currency>) get initCurrencyChanged => _initCurrencyController.sink.add;  
  Function(List<ProductCategorys>) get initProdCategoryChanged => _initProdCategoryController.sink.add;
  Function(List<Product>) get initProductsChanged => _initProductsController.sink.add;
  Function(List<Customer>) get initCustomersChanged => _initCustomersController.sink.add;
  Function(List<Supplier>) get initSuppliersChanged => _initSuppliersController.sink.add;
  Function(List<CountryList>) get initCountriesChanged => _initCountriesController.sink.add;


  // initiate here
  initiateProducts(bool initReload) async 
  { 
    if(_initProductsController.value == null || initReload)
    {  
      ProductApiProvider proAPI = new ProductApiProvider();
      List<Product> products = await proAPI.productList();
      _initProductsController.sink.add(products);
    }
  }
  
  initiateCustomers(bool initReload) async 
  { 
    if(_initCustomersController.value == null || initReload)
    {   
      CustomerApiProvider custAPI = new CustomerApiProvider();
      List<Customer> customers = await custAPI.customerList();
      _initCustomersController.sink.add(customers);
    }
  }

  initiateSuppliers(bool initReload) async 
  { 
    if(_initSuppliersController.value == null || initReload)
    {   
      SupplierApiProvider custAPI = new SupplierApiProvider();
      List<Supplier> suppliers = await custAPI.supplierList();
      _initSuppliersController.sink.add(suppliers);
    }
  }

  initiateUOMs(bool initReload) async 
  { 
    if(_initUOMController.value == null || initReload)
    {   
      LookUpApiProvider lookupAPI = new LookUpApiProvider();
      List<Lookup> products = await lookupAPI.uomList();
      _initUOMController.sink.add(products);
    }
  }

  initiateIncoTerm(bool initReload) async 
  { 
    if(_initIncoTermController.value == null || initReload)
    {   
      IncotermApiProvider incoTrmApi = new IncotermApiProvider();
      List<Incoterm> incoTerm = await incoTrmApi.incotermList();
      _initIncoTermController.sink.add(incoTerm);
    }
  }  
  
  initiateLocation(bool initReload) async 
  { 
    if(_initLocationController.value == null || initReload)
    {   
     WareHouseLocApi locApi = new WareHouseLocApi();
      List<Lookup> location = await locApi.wareHousLocList();
      _initLocationController.sink.add(location);
    }
  }  
  
  initiatePaymentType(bool initReload) async 
  { 
    if(_initPaymentTypeController.value == null || initReload)
    {   
      PaymentApiProvider paymentApi = new PaymentApiProvider();
      List<PaymentTypes> payment = await paymentApi.paymentList();
      _initPaymentTypeController.sink.add(payment);
    }
  }
  
  initiateCurrencys(bool initReload) async 
  { 
    if(_initCurrencyController.value == null || initReload)
    {   
      CurrencyApiProvider currAPI = new CurrencyApiProvider();
      List<Currency> currencys = await currAPI.currencyList();
      _initCurrencyController.sink.add(currencys);
    }
  }

  initiateProdCategorys(bool initReload) async 
  { 
    if(_initProdCategoryController.value == null || initReload)
    {   
      ProductCateProvider prodCatAPI = new ProductCateProvider();
      List<ProductCategorys> prodCategories = await prodCatAPI.productCatList();
      _initProdCategoryController.sink.add(prodCategories);
    }
  }

  initiateCountrys(bool initReload) async
  {
    if(_initCountriesController.value == null || initReload)
    {
      SupplierApiProvider countryApi = new  SupplierApiProvider();
      List<CountryList> countryList = await countryApi.countrylist();
      _initCountriesController.sink.add(countryList);
    }
  }
  


  // -------------******--------------
  // initiateProductList(List<Product> productList)
  // {
  //   List<Product> products=[];
  //   if(_initProductsController.hasValue)
  //   { products.addAll(_initProductsController.value);}  
  //   products.addAll(productList);
  //   _initProductsController.sink.add(products);
  // }

  // initiateCustomerList(List<Customer> customerList)
  // {

  //   List<Customer> customers=[];
  //   if(_initCustomersController.hasValue)
  //   { customers.addAll(_initCustomersController.value); }  
  //   customers.addAll(customerList);
  //   _initCustomersController.sink.add(customers);
  // }
  
  // initiateSupplierList(List<Supplier> supplierList)
  // {
  //   List<Supplier> suppliers=[];
  //   if(_initSuppliersController.hasValue)
  //   { suppliers.addAll(_initSuppliersController.value); }  
  //   suppliers.addAll(supplierList);
  //   _initSuppliersController.sink.add(suppliers);
  // } 

  getProductName(String code)
  { String desc;
    if(_initProductsController.hasValue)
    { desc = _initProductsController.value.where((prod) => prod.productCode.trim() == code.trim()).first.description;}
    desc = (desc == null || desc == "") ? 'No description found' : desc;
    return desc;
  }

  getProductUOM(String code)
  { String uomCode;
    if(_initProductsController.hasValue)
    { uomCode = _initProductsController.value.where((prod) => prod.productCode.trim() == code.trim()).first.uom;}
    uomCode = (uomCode == null || uomCode == "") ? null : uomCode;
    return uomCode;
  }

  getProductSellingPrice(String code)
  { String sellPrice;
    if(_initProductsController.hasValue)
    { sellPrice = _initProductsController.value.where((prod) => prod.productCode.trim() == code.trim()).first.sellingPrice.toString();}
    sellPrice = (sellPrice == null || sellPrice == "") ? '0.0' : sellPrice;
    return sellPrice;
  }



  getCustomerName(String code)
  { 
    // initiateCustomers(true);
    String name;
    if(code == 'STD') {name="";}
    else{
        if(_initCustomersController.hasValue && _initCustomersController.value != null)
        { name = _initCustomersController.value.where((cust) => cust.customerCode.trim() == code.trim()).first.customerName;}
        name = (name == null || name == "") ? 'No Name found' : name;
    }  
    return name;
  }

  getCustomerAddress(String code)
  { String name;
    if(code == 'STD') {name="";}
    else{
        if(_initCustomersController.hasValue && _initCustomersController.value != null)
        { name = _initCustomersController.value.where((cust) => cust.customerCode.trim() == code.trim()).first.addressId;}
        name = (name == null || name == "") ? '' : name;
    }  
    return name;
  }

  getSupplierAddress(String code)
  { String address;
    if(code == 'STD') {address="";}
    else{
        if(_initSuppliersController.hasValue && _initSuppliersController.value != null)
        { address = _initSuppliersController.value.where((cust) => cust.customerCode.trim() == code.trim()).first.addressId;}
        address = (address == null || address == "") ? '' : address;
    }  
    return address;
  }

  getSupplierContactPerson(String code)
  { String contPerson;
    if(code == 'STD') {contPerson="";}
    else{
        if(_initSuppliersController.hasValue && _initSuppliersController.value != null)
        { contPerson = _initSuppliersController.value.where((cust) => cust.customerCode.trim() == code.trim()).first.contactPerson;}
        contPerson = (contPerson == null || contPerson == "") ? '' : contPerson;
    }  
    return contPerson;
  }
  
  

  getSupplierName(String code)
  { String name;
    if(_initSuppliersController.hasValue)
    { name = _initSuppliersController.value.where((supp) => supp.customerCode.trim() == code.trim()).first.customerName;}
    name = (name == null || name == "") ? 'No Name found' : name;
    return name;
  }

  // End of (Product, Cutomers, Suppliers) List

//DashBoard Stream
    final _dbIndexController = BehaviorSubject<String>();
    final _dbTotalSalesController = BehaviorSubject<String>();
    final _dashBoardController = BehaviorSubject<DashBoards>();
    Stream<String> get dbIndex => _dbIndexController.stream.transform(lookUpCodValidator);
    Stream<String> get totalSales => _dbTotalSalesController.stream.transform(lookUpCodValidator);
    Stream<DashBoards> get dashBoard => _dashBoardController.transform(dashBoardValidators);
    Function(DashBoards) get dashBoardChanged => _dashBoardController.sink.add;
    Function(String) get dbIndexChanged => _dbIndexController.sink.add;
    Function(String) get totalSalesChanged => _dbTotalSalesController.sink.add;

    fetchDashBoardDetails(int count) async
    {
      DashBoardApi dashBoardApi = new DashBoardApi();
      DashBoards dbMod = new DashBoards();
      dbMod = await dashBoardApi.getDashBoards(StaticsVar.branchID,count);
      
      _dashBoardController.sink.add(dbMod);
    }


// Stream<List<SalesEntryDetails>> get seDetails =>_seDetailsController.stream.transform(seDetailsValidators);
  //ProductCategory List
  final _proCatDtlsController = BehaviorSubject<List<ProductCategorys>>();
  //ProductCategory List
  Stream<List<ProductCategorys>> get proCatDtls => _proCatDtlsController.transform(validateProductCatDtls);
  //ProductCategory List
  Function(List<ProductCategorys>) get changeProCatDtls => _proCatDtlsController.sink.add;

  // NOTE UOM / PaymentType /  IncoTerms /  WareHouseLocation all this four comes under lookups
  // lookUp popup page
  final _lookUpCodeController = BehaviorSubject<String>();
  final _lookUpDesController = BehaviorSubject<String>(); 
  // lookUp popup page
  Stream<String> get lookUpCode => _lookUpCodeController.stream.transform(lookUpCodValidator);
  Stream<String> get lookUpDes => _lookUpDesController.stream.transform(lookUpDesValidator);
  // lookUp popup page
  Function(String) get lookUpCodeChanged => _lookUpCodeController.sink.add;
  Function(String) get lookUpDesChanged => _lookUpDesController.sink.add;

  // Currency popup page
  final _currCodeController = BehaviorSubject<String>();
  final _currDesController = BehaviorSubject<String>();
  final _currDes1Controller = BehaviorSubject<String>();
  // Currency popup page
  Stream<String> get currCode => _currCodeController.stream.transform(currCodeValidator);
  Stream<String> get currDes => _currDesController.stream.transform(currDescValidator);
  Stream<String> get currDes1 => _currDes1Controller.stream.transform(currDesc1Validator);
  // Currency popup page
  Function(String) get currCodeChanged => _currCodeController.sink.add;
  Function(String) get currDescChanged => _currDesController.sink.add;
  Function(String) get currDesc1Changed => _currDes1Controller.sink.add;


  // Incoterms popup page
  final _incoCodeController = BehaviorSubject<String>();
  final _incoDesController = BehaviorSubject<String>();
  // Incoterms popup page
  Stream<String> get incoCode => _incoCodeController.stream.transform(incoCodeValidator);
  Stream<String> get incoDes => _incoDesController.stream.transform(incoDescValidator);
  // Incoterms popup page
  Function(String) get incoCodeChanged => _incoCodeController.sink.add;
  Function(String) get incoDescChanged => _incoDesController.sink.add;

  //ProductCategoryPopupscreen
  final _prodCatCodeController =  BehaviorSubject<String>();
  final _prodCatdescripController = BehaviorSubject<String> ();

  //ProductCategoryPopupscreen
   Stream<String> get prodCatCode => _prodCatCodeController.stream.transform(categoryValidator);
   Stream<String> get prodDescription => _prodCatdescripController.stream.transform(descriptorValidator);
  // Stream<bool> get saveCheck => Observable.combineLatest2(catCode, descriDts, (c,d,)=>true); 

   //ProductCategoryPopupscreen
   Function(String) get prodCatCodeChanged => _prodCatCodeController.sink.add;
   Function(String) get prodDescChanged => _prodCatdescripController.sink.add;


   //LocationPopUppage
   final _locCodeController = BehaviorSubject<String>();
   final _locdesController = BehaviorSubject<String>();
   //LocationPopUppage
   Stream<String> get locCode => _locCodeController.stream.transform(locCodePopupValidator);
   Stream<String> get locDescription => _locdesController.stream.transform(locDescPoupValidator);
   //LocationPopUppage
   Function(String) get locCodeChanged => _locCodeController.sink.add;
   Function(String) get locDesChanged => _locdesController.sink.add;

     //Payment PopUppage
   final _payTypeController = BehaviorSubject<String>();
   final _paydesController = BehaviorSubject<String>();
     //Payment PopUppage
   Stream<String> get payCatCode => _payTypeController.stream.transform(payTypePopupValidator);
   Stream<String> get payDescription => _paydesController.stream.transform(payDescPoupValidator);
     //Payment PopUppage
   Function(String) get paypopCodeChanged => _payTypeController.sink.add;
   Function(String) get paypopDesChanged => _paydesController.sink.add;

  // Quotation Standard tariff page
  // final _standardTariffController = BehaviorSubject<String>();

    //Products PopUppage
   final _productCodemasterController = BehaviorSubject<String>();  
   final _productdesController = BehaviorSubject<String>();
   final _proBarCodeController = BehaviorSubject<String>();
   final _procatUomDrodwnController = BehaviorSubject<String>();
   final _proColorController =   BehaviorSubject<String>();
   final _reOrderqtyController =  BehaviorSubject<String>();
   final _proCatergoryDDController =  BehaviorSubject<String>();
   final  _sizeController =  BehaviorSubject<String>();  
   final _whLocDDController =  BehaviorSubject<String>();

  //Products PopUppage
  Stream<String> get prodMasCode => _productCodemasterController.stream.transform(productDescPoupValidator);
  Stream<String> get prodDesCode => _productdesController.stream.transform(productDescPoupValidator);
  Stream<String> get prodBarCode => _proBarCodeController.stream.transform(productBarCodePoupValidator);
  Stream<String> get prodcatUOMdd => _procatUomDrodwnController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<String> get prodColor => _proColorController.stream.transform(proColorPoupValidator);
  Stream<String> get prodreOrderQty => _reOrderqtyController.stream.transform(proReOrderQtyPoupValidator);
  Stream<String> get prodCateDD => _proCatergoryDDController.stream.transform(proCatergoryPoupValidator);
  Stream<String> get proSizeControll => _sizeController.stream.transform(proSizePoupValidator);
  Stream<String> get whLocDD => _whLocDDController.stream.transform(proWhLocationPoupValidator);
  
  //Products PopUppage
  Function(String) get prodcodeMasChanged => _productdesController.sink.add;
  Function(String) get proDesChanged => _productdesController.sink.add;
  Function(String) get propopBarCodeChanged => _proBarCodeController.sink.add;
  Function(String) get proUOMMasterddChanged => _procatUomDrodwnController.sink.add;
  Function(String) get proColorChanged => _proColorController.sink.add;
  Function(String) get prodReOrderChanged => _reOrderqtyController.sink.add;
  Function(String) get prodCateddChanged => _proCatergoryDDController.sink.add;
  Function(String) get proSizeChanged => _sizeController.sink.add;
  Function(String) get whLocDDChanged => _whLocDDController.sink.add;
    
  // Promotions popup
  final _proCodeDDController =  BehaviorSubject<String>();
  final _effectiveDateController =  BehaviorSubject<DateTime>();
  final _expiryDateController =  BehaviorSubject<DateTime>();
  final _discountTypeDController =  BehaviorSubject<String>();
  final _amountController =  BehaviorSubject<String>();
  final _prodCodesDDController =  BehaviorSubject<String>();
  final _qtyController =  BehaviorSubject<String>();
  final _promTypeController =  BehaviorSubject<String>();

  Stream<String> get promoCodedd => _proCodeDDController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<DateTime> get effectivePromo => _effectiveDateController.stream.transform(dateTimeValidator);
  Stream<DateTime> get expiryPromo => _expiryDateController.stream.transform(dateTimeValidator);
  Stream<String> get discountPromo => _discountTypeDController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<String> get amountPromo => _amountController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<String> get promoCodesdd => _prodCodesDDController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<String> get qtypromo => _qtyController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<String> get promoType => _promTypeController.stream.transform(proUOMDrpdwnPoupValidator);

  Function(String) get promoCodeddChanged => _proCodeDDController.sink.add;
  Function(DateTime) get effectivePromoChanged => _effectiveDateController.sink.add;
  Function(DateTime) get expiryPromoChanged => _expiryDateController.sink.add;
  Function(String) get discountPromoChanged => _discountTypeDController.sink.add;
  Function(String) get amountPromoChanged => _amountController.sink.add;
  Function(String) get promoCodesddChanged => _prodCodesDDController.sink.add;
  Function(String) get qtypromoChanded => _qtyController.sink.add;
  Function(String) get promoTypeChanded => _promTypeController.sink.add;    


  //Add Customer Details

  final _cusNameController = BehaviorSubject<String>();
  final _cusCodesController = BehaviorSubject<String>();
  final _cusRegController = BehaviorSubject<String>();
  final _creditTermController = BehaviorSubject<String>();
  final _custaddress1Controller = BehaviorSubject<String>();
  final _custaddress2Controller = BehaviorSubject<String>();
  final _custcityNameController = BehaviorSubject<String>();
  final _custstateNameController = BehaviorSubject<String>();
  final _custzipCodeController = BehaviorSubject<String>();
  final _custphoneNumController = BehaviorSubject<String>();
  final _custfaxNumController = BehaviorSubject<String>();
  final _custemailAddController = BehaviorSubject<String>();
  final _custcountriesController = BehaviorSubject<String>();
  final _customerListController = BehaviorSubject<List<Customer>>();

  Stream<String> get nameCustomer => _cusNameController.stream.transform(lookUpCodValidator);
  Stream<String> get codeCustomer => _cusCodesController.stream.transform(lookUpCodValidator);
  Stream<String> get regCustomer =>  _cusRegController.stream.transform(lookUpCodValidator);
  Stream<String> get custCreditTerm => _creditTermController.stream.transform(validateTxtFldCreditTerm);
  Stream<String> get custaddress1 => _custaddress1Controller.stream.transform(lookUpCodValidator);
  Stream<String> get custaddress2 => _custaddress2Controller.stream.transform(lookUpCodValidator);
  Stream<String> get custcity => _custcityNameController.stream.transform(lookUpCodValidator);
  Stream<String> get custstate => _custstateNameController.stream.transform(lookUpCodValidator);
  Stream<String> get custzipCode => _custzipCodeController.stream.transform(lookUpCodValidator);
  Stream<String> get custphoneNum => _custphoneNumController.stream.transform(lookUpCodValidator);
  Stream<String> get custfaxNum => _custfaxNumController.stream.transform(lookUpCodValidator);
  Stream<String> get custemailAdr => _custemailAddController.stream.transform(lookUpCodValidator);
  Stream<String> get custcountry => _custcountriesController.stream.transform(lookUpCodValidator);
  Stream<List<Customer>> get customerList => _customerListController.stream.transform(customerValidator);

  Function(String) get custNameChange => _cusNameController.sink.add;
  Function(String) get codeCustomerChange => _cusCodesController.sink.add;
  Function(String) get custRegChange => _cusRegController.sink.add;
  Function(String) get custCreditChange => _creditTermController.sink.add;
  Function(String) get custadress1Change => _custaddress1Controller.sink.add;
  Function(String) get custadress2Change => _custaddress2Controller.sink.add;
  Function(String) get custcityChange => _custcityNameController.sink.add;
  Function(String) get custstateChange => _custstateNameController.sink.add;
  Function(String) get custzipCodeChange => _custzipCodeController.sink.add;
  Function(String) get custphoneNumChange => _custphoneNumController.sink.add;
  Function(String) get custfaxNumChange => _custfaxNumController.sink.add;
  Function(String) get custemailAddChange => _custemailAddController.sink.add;
  Function(String) get custcountryChange => _custcountriesController.sink.add;
  Function(List<Customer>) get customerLisChanged => _customerListController.sink.add;

  initCustomerList() async
  {
    CustomerApiProvider custAPI = new CustomerApiProvider();
    //List<Customer> customers = 
    await custAPI.customerList().then((onValue){return onValue;});
    //return customers;
    //if(customers.length>0) { _customerListController.sink.add(customers);}
     //_customerListController.sink.add(customers);
  }

  // END of Customer List


  //Add Supplier Details
  final _supplierCodeController = BehaviorSubject<String>();
  final _supplierNameController = BehaviorSubject<String>();
  final _supplierRegController = BehaviorSubject<String>();
  final _supplierTypeController = BehaviorSubject<String>();
  final _contactPersonController = BehaviorSubject<String>();
  final _address1Controller = BehaviorSubject<String>();
  final _address2Controller = BehaviorSubject<String>();
  final _cityNameController = BehaviorSubject<String>();
  final _stateNameController = BehaviorSubject<String>();
  final _countriesController = BehaviorSubject<String>();
  final _zipCodeController = BehaviorSubject<String>();
  final _phoneNumController = BehaviorSubject<String>();
  final _faxNumController = BehaviorSubject<String>();
  final _emailAddController = BehaviorSubject<String>();



  Stream<String> get codeSupp => _supplierCodeController.stream.transform(validateTxtFld);
  Stream<String> get nameSupp => _supplierNameController.stream.transform(validateTxtFld);
  Stream<String> get regSupp =>  _supplierRegController.stream.transform(validateTxtFld);
  Stream<String> get custSupp => _supplierTypeController.stream.transform(validateTxtFld);
  Stream<String> get contactPerson => _contactPersonController.stream.transform(validateTxtFld);
  Stream<String> get address1 => _address1Controller.stream.transform(validateTxtFld);
  Stream<String> get address2 => _address2Controller.stream.transform(validateTxtFld);
  Stream<String> get city => _cityNameController.stream.transform(validateTxtFld);
  Stream<String> get state => _stateNameController.stream.transform(validateTxtFld);
  Stream<String> get country => _countriesController.stream.transform(validateTxtFld);
  Stream<String> get zipCode => _zipCodeController.stream.transform(zipValidator);
  Stream<String> get phoneNum => _phoneNumController.stream.transform(phoneValidator);
  Stream<String> get faxNum => _faxNumController.stream.transform(faxValidator);
  Stream<String> get emailAdr => _emailAddController.stream.transform(emailValidator);
  
  Function(String) get suppCodeChange => _supplierCodeController.sink.add;
  Function(String) get suppNameChange => _supplierNameController.sink.add;
  Function(String) get suppRegChange => _supplierRegController.sink.add;
  Function(String) get suppCustChange => _supplierTypeController.sink.add;
  Function(String) get contactChange => _contactPersonController.sink.add;
  Function(String) get adress1Change => _address1Controller.sink.add;
  Function(String) get adress2Change => _address2Controller.sink.add;
  Function(String) get cityChange => _cityNameController.sink.add;
  Function(String) get stateChange => _stateNameController.sink.add;
  Function(String) get countryChange => _countriesController.sink.add;
  Function(String) get zipCodeChange => _zipCodeController.sink.add;
  Function(String) get phoneNumChange => _phoneNumController.sink.add;
  Function(String) get faxNumChange => _faxNumController.sink.add;
  Function(String) get emailAddChange => _emailAddController.sink.add;
 
  //Purchase Orders
  final _poTotalAmountController = BehaviorSubject<String>();
  final _poOtherChargesController = BehaviorSubject<String>();
  final _poVATController = BehaviorSubject<bool>();
  final _poNetAmtController = BehaviorSubject<String>();

  final _poSuppCodeController = BehaviorSubject<String>();
  final _poNumberController = BehaviorSubject<String>();
  final _poDateController = BehaviorSubject<DateTime>();
  final _suppNameController = BehaviorSubject<String>();
  final _poContactPerController = BehaviorSubject<String>();
  final _adressController = BehaviorSubject<String>();
  final _shipingDateController = BehaviorSubject<DateTime>();
  final _estimateDateController = BehaviorSubject<DateTime>();
  final _referenceNumController = BehaviorSubject<String>();
  final _paymentController = BehaviorSubject<String>();
  final _prNumController = BehaviorSubject<String>();
  final _remarksController = BehaviorSubject<String>();
  final _poItemsController = BehaviorSubject<List<PurchaseOrderDetails>>();

  Stream<String> get poTotalAmt =>  _poTotalAmountController.stream.transform(validateTxtFld);
  Stream<String> get poOtherCharges =>  _poOtherChargesController.stream.transform(validateTxtFld);
  Stream<bool> get poVat =>  _poVATController.stream.transform(isSelectedValidator);
  Stream<String> get poNetAmt =>  _poNetAmtController.stream.transform(validateTxtFld);
  Stream<String> get poSuppCodeStream =>  _poSuppCodeController.stream.transform(validateTxtFld);
  Stream<String> get poNumberStream =>  _poNumberController.stream.transform(validateTxtFld);
  Stream<DateTime> get datePurStream => _poDateController.stream.transform(dateTimeValidator);
  Stream<String> get suplNameStream => _suppNameController.stream.transform(validatedropDown);
  Stream<String> get contactPerStream => _poContactPerController.stream.transform(validateTxtFld);
  Stream<String> get adressStream => _adressController.stream.transform(validateTxtFld);
  Stream<DateTime> get shipDateStream => _shipingDateController.stream.transform(dateTimeValidator);
  Stream<DateTime> get estDateStream => _estimateDateController.stream.transform(dateTimeValidator);
  Stream<String> get refNumStream => _referenceNumController.stream.transform(validateTxtFld);
  Stream<String> get payTypeStream => _paymentController.stream.transform(validatedropDown);
  Stream<String> get prNumStream => _prNumController.stream.transform(validateTxtFld);
  Stream<String> get remarksStream => _remarksController.stream.transform(validateTxtFld);
  Stream<List<PurchaseOrderDetails>> get poItems => _poItemsController.stream.transform(poHeaderValidators);

  Function(String) get poTotalAmtChanged => _poTotalAmountController.sink.add;
  Function(String) get poOtherChargesChanged => _poOtherChargesController.sink.add;
  Function(bool) get poVatChanged => _poVATController.sink.add;
  Function(String) get poNetAmtChanged => _poNetAmtController.sink.add;
  Function(String) get poSuppCodeChanged => _poSuppCodeController.sink.add;
  Function(String) get poNumberChanged => _poNumberController.sink.add;
  Function(DateTime) get datePurChanged => _poDateController.sink.add;
  Function(String) get suppNameChanged => _suppNameController.sink.add;
  Function(String) get contactPerChanged => _poContactPerController.sink.add;
  Function(String) get adressChanged => _adressController.sink.add;
  Function(DateTime) get shippingdateChanged => _shipingDateController.sink.add;
  Function(DateTime) get estDateChanged => _estimateDateController.sink.add;
  Function(String) get refNumChanged => _referenceNumController.sink.add;
  Function(String) get payTypeChanged => _paymentController.sink.add;
  Function(String) get prNumChanged => _prNumController.sink.add;
  Function(String) get remarksChanged => _remarksController.sink.add;
  Function(List<PurchaseOrderDetails>) get poItemsChanged => _poItemsController.sink.add;

  //Purchase Order product popup details
  
  final _poProdCodeDDpopupController = BehaviorSubject<String>();
  final _poUOMunitDDController = BehaviorSubject<String>();
  final _poQuantitypopupController = BehaviorSubject<String>();
  final _poCurrencyPopupController = BehaviorSubject<String>();
  final _unitPricePopupController = BehaviorSubject<String>();
  final _poDetailsController = BehaviorSubject<List<PurchaseOrderDetails>>();


  Stream<String> get poProdCodeDDpopupStream => _poProdCodeDDpopupController.stream.transform(validateTxtFld);
  Stream<String> get poUOMunitDDStream => _poUOMunitDDController.stream.transform(validateTxtFld);
  Stream<String> get poQuantitypopupStream => _poQuantitypopupController.stream.transform(validateTxtFld);
  Stream<String> get poCurrencyPopupStream => _poCurrencyPopupController.stream.transform(validateTxtFld);
  Stream<String> get unitPricePopupStream => _unitPricePopupController.stream.transform(validateTxtFld);
  Stream<List<PurchaseOrderDetails>> get poDetails => _poDetailsController.stream.transform(poDtlsValidators);


  Function(String) get poProdCodeDDpopupChanged => _poProdCodeDDpopupController.sink.add;
  Function(String) get poUOMunitDDChanged => _poUOMunitDDController.sink.add;
  Function(String) get poQuantitypopupsChanged => _poQuantitypopupController.sink.add;
  Function(String) get poCurrencyPopupChanged => _poCurrencyPopupController.sink.add;
  Function(String) get unitPricePopupChanged => _unitPricePopupController.sink.add;
  Function(List<PurchaseOrderDetails>) get poDetailsChanged => _poDetailsController.sink.add;

  // Quotation bloc
  // Standard Quotation
  final _qSQuotNoController =BehaviorSubject<String>();
  final _qSEffecDateController =BehaviorSubject<DateTime>();
  final _qSExprDateController =BehaviorSubject<DateTime>();
  final _qSProCodDropDwnController =BehaviorSubject<String>();
  final _qSellRateController =BehaviorSubject<String>();
  final _qSPaymentController =BehaviorSubject<String>();
  final _qProdDescriptionController =BehaviorSubject<String>();
  final _quotationItemsController = BehaviorSubject<List<QuotationItems>>();

  Stream<String> get qSQuotation => _qSQuotNoController.stream.transform(validateTxtFld);
  Stream<DateTime> get qSEffecDate => _qSEffecDateController.stream.transform(dateTimeValidator);
  Stream<DateTime> get qSExprDate => _qSExprDateController.stream.transform(dateTimeValidator);
  Stream<String> get qSProdCode => _qSProCodDropDwnController.stream.transform(validateTxtFld);
  Stream<String> get qSSellRate => _qSellRateController.stream.transform(validateTxtFld);
  Stream<String> get qSPayment => _qSPaymentController.stream.transform(validateTxtFld);
  Stream<String> get qProdDescription => _qProdDescriptionController.stream.transform(validateTxtFld);
  Stream<List<QuotationItems>> get quotationItems => _quotationItemsController.stream.transform(qoStdDtlsValidators);

  Function(String) get qSQuotationChanged  => _poQuantitypopupController.sink.add;
  Function(DateTime) get qSEffecDateChanged => _qSEffecDateController.sink.add;
  Function(DateTime) get qSExprDateChanged => _qSExprDateController.sink.add;
  Function(String) get qSProdCodeChanged  => _qSProCodDropDwnController.sink.add;
  Function(String) get qSSellRateChanged => _qSellRateController.sink.add;
  Function(String) get qSPaymentChanged => _qSPaymentController.sink.add;
  Function(String) get qProdDescriptiontChanged => _qProdDescriptionController.sink.add;
  Function(List<QuotationItems>) get quotationItemsChanged => _quotationItemsController.sink.add;

  // Quotation customer
  final _qCusNoController =BehaviorSubject<String>();
  final _qCusCCodeController =BehaviorSubject<String>();
  final _qCusEffecDateController =BehaviorSubject<DateTime>();
  final _qCusExprDateController =BehaviorSubject<DateTime>();
  final _qCusProdCodePUController =BehaviorSubject<String>();
  final _qCusSellratePUController =BehaviorSubject<String>();
  final _qCusPaymentPUController =BehaviorSubject<String>();
  final _qCustEffDateCtrl = BehaviorSubject<String>();
  final _qCustomerQuotListCtrl = BehaviorSubject<List<QuotationHd>>();

  Stream<String> get qCusNoCode => _qCusNoController.stream.transform(validateTxtFld);
  Stream<String> get qCusCCode => _qCusCCodeController.stream.transform(validateTxtFld);
  Stream<DateTime> get qCusEffecDate => _qCusEffecDateController.stream.transform(dateTimeValidator);
  Stream<DateTime> get qCusExprDate => _qCusExprDateController.stream.transform(dateTimeValidator);
  Stream<String> get qCusProdCodePU => _qCusProdCodePUController.stream.transform(validateTxtFld);
  Stream<String> get qCusSellratePU => _qCusSellratePUController.stream.transform(validateTxtFld);
  Stream<String> get qCusPaymentPU => _qCusPaymentPUController.stream.transform(validateTxtFld);
  Stream<String> get qCustEffDate => _qCustEffDateCtrl.stream.transform(validateTxtFld);
  Stream<List<QuotationHd>> get custQuotationList => _qCustomerQuotListCtrl.stream.transform(validateQuotationHd);
  
  Function(String) get qCusNoCodeChanged  => _qCusNoController.sink.add;
  Function(String) get qCusCCodeChanged  => _qCusCCodeController.sink.add;
  Function(DateTime) get qCusEffecDateChanged => _qCusEffecDateController.sink.add;
  Function(DateTime) get qCusExprDateChanged => _qCusExprDateController.sink.add;
  Function(String) get qCusProdCodePUChanged  => _qCusProdCodePUController.sink.add;
  Function(String) get qCusSellratePUChanged => _qCusSellratePUController.sink.add;
  Function(String) get qCusPaymentPUChanged => _qCusPaymentPUController.sink.add;
  Function(String) get qCustEffDateChanged => _qCustEffDateCtrl.sink.add;
  Function(List<QuotationHd>) get custQuotionListChanged => _qCustomerQuotListCtrl.sink.add;

  fillCustomerQuotList(bool isReload) async
  {
    //if(!_qCustomerQuotListCtrl.hasValue || _qCustomerQuotListCtrl.value == null )
    if(isReload)
    {
      QuotationApiProvider qtApi = new QuotationApiProvider();
      _qCustomerQuotListCtrl.sink.add(await qtApi.quotationCustomerList(StaticsVar.branchID));
    }

    _searchTxtFldController.stream.listen((onData) {
      //print(onData);
      if(onData.length == 0) {fillCustomerQuotList(true);}
      _qCustomerQuotListCtrl.sink.add(_qCustomerQuotListCtrl.value.where((cust) => cust.customerName.contains(onData)).toList());
    }); 
  }



// Supplier Quotation
  final _qSupDropDwnController =BehaviorSubject<String>();
  final _qSupEffecDateController =BehaviorSubject<DateTime>();
  final _qSupExprDateController =BehaviorSubject<DateTime>();
  final _qSupDropDwnPUController =BehaviorSubject<String>();
  final _qSupSellratePUController =BehaviorSubject<String>();
  final _qSupCurrentyDDController =BehaviorSubject<String>();

  Stream<String> get qSupDrpDwn => _qSupDropDwnController.stream.transform(validateTxtFld);
  Stream<DateTime> get qSupEffecDate => _qSupEffecDateController.stream.transform(dateTimeValidator);
  Stream<DateTime> get qSupExprDate => _qSupExprDateController.stream.transform(dateTimeValidator);
  Stream<String> get qSuppDropDwnPU => _qSupDropDwnPUController.stream.transform(validateTxtFld);
  Stream<String> get qSuppSellratePU => _qSupSellratePUController.stream.transform(validateTxtFld);
  Stream<String> get qSuppCurrentyDD => _qSupCurrentyDDController.stream.transform(validateTxtFld);

  Function(String) get qSupDrpDwnChanged  => _qSupDropDwnController.sink.add;
  Function(DateTime) get qSupEffecDateChanged => _qSupEffecDateController.sink.add;
  Function(DateTime) get qSupExprDateChanged => _qSupExprDateController.sink.add;
  Function(String) get qSuppDropDwnPUChanged  => _qSupDropDwnPUController.sink.add;
  Function(String) get qSuppSellratePUChanged => _qSupSellratePUController.sink.add;
  Function(String) get qSuppCurrentyDDChanged => _qSupSellratePUController.sink.add;

  // Transaction SALES ENTRY
  final _seCustNoController = BehaviorSubject<String>();
  final _seCustCodeController = BehaviorSubject<String>();
  final _seCustAddressController = BehaviorSubject<String>();
  final _seSalesDateController = BehaviorSubject<DateTime>();
  final _seDelvDateController = BehaviorSubject<DateTime>();
  final _sePaymentTypeController = BehaviorSubject<String>();
  final _seRemarksController = BehaviorSubject<String>();
  final _seQtyController = BehaviorSubject<String>();
  final _seUOMController = BehaviorSubject<String>();
  final _seProdCodeController = BehaviorSubject<String>();
  final _seDiscountTypeController = BehaviorSubject<String>();
  final _seSellRateController = BehaviorSubject<String>();
  final _seDiscountController = BehaviorSubject<String>();
  final _sePaidAmntController = BehaviorSubject<String>();
  final _seVatController = BehaviorSubject<bool>();
  final _seWHTaxController = BehaviorSubject<bool>();  
  final _seHeaderController = BehaviorSubject<SalesEntryHd>();
  final _seDetailsController = BehaviorSubject<List<SalesEntryDetails>>();

  Stream<String> get seCustNo => _seCustNoController.stream.transform(validateTxtFld);
  Stream<String> get seCustCode => _seCustCodeController.stream.transform(validateTxtFld);
  Stream<String> get seCustAddress => _seCustAddressController.stream.transform(validateTxtFld);
  Stream<DateTime> get seSalesDate =>_seSalesDateController.stream.transform(dateTimeValidator);
  Stream<DateTime> get seDelvDate =>_seDelvDateController.stream.transform(dateTimeValidator);
  Stream<String> get sePaymentType =>_sePaymentTypeController.stream.transform(validateTxtFld);
  Stream<String> get seRemarks =>_seRemarksController.stream.transform(validateTxtFld);
  Stream<String> get seQty =>_seQtyController.stream.transform(validateTxtFld);
  Stream<String> get seUOM =>_seUOMController.stream.transform(validateTxtFld);
  Stream<String> get seProdCode =>_seProdCodeController.stream.transform(validateTxtFld);
  Stream<String> get seDiscountType =>_seDiscountTypeController.stream.transform(validateTxtFld);
  Stream<String> get seDiscount =>_seDiscountController.stream.transform(validateTxtFld);
  Stream<String> get seSellRate =>_seSellRateController.stream.transform(validateTxtFld);
  Stream<String> get sePaidAmnt =>_sePaidAmntController.stream.transform(validateTxtFld);
  Stream<bool> get seVat =>_seVatController.stream.transform(isSelectedValidator);
  Stream<bool> get seWitHld =>_seWHTaxController.stream.transform(isSelectedValidator);
  Stream<SalesEntryHd> get seHeader =>_seHeaderController.stream.transform(seHeaderValidators);
  Stream<List<SalesEntryDetails>> get seDetails =>_seDetailsController.stream.transform(seDetailsValidators);
 
  Function(String) get seCustNoChanged  => _seCustNoController.sink.add;
  Function(String) get seCustCodeChanged  => _seCustCodeController.sink.add;
  Function(String) get seCustAddressChanged  => _seCustAddressController.sink.add;
  Function(DateTime) get seSalesDateChanged => _seSalesDateController.sink.add;
  Function(DateTime) get seDelvDateChanged => _seDelvDateController.sink.add;
  Function(String) get sePaymentTypeChanged  => _sePaymentTypeController.sink.add;
  Function(String) get seRemarksChanged  => _seRemarksController.sink.add;
  Function(String) get seQtyChanged  => _seQtyController.sink.add;
  Function(String) get seUOMChanged  => _seUOMController.sink.add;
  Function(String) get seProdCodeChanged  => _seProdCodeController.sink.add;
  Function(String) get seDiscountTypeChanged  => _seDiscountTypeController.sink.add;
  Function(String) get seDiscountChanged  => _seDiscountController.sink.add;
  Function(String) get seSellRateChanged  => _seSellRateController.sink.add;
  Function(String) get sePaindAmntChanged  => _sePaidAmntController.sink.add;
  Function(bool) get seVatChanged  => _seVatController.sink.add;
  Function(bool) get seWitHldChanged  => _seWHTaxController.sink.add;
  Function(List<SalesEntryDetails>) get seDetailsChanged  => _seDetailsController.sink.add;

  listenProdCode()
  {
    _seProdCodeController.stream.listen((onData) { getNaddSEDetails();});
  }

  getNaddSEDetails() async {
    SalesEntryApi seAPI =new SalesEntryApi();
    List<SalesEntryDetails> seDetailList = []; // new SalesEntryDetails();
    List<SalesEntryDetails> seDetails = [];
    bool isrepeated = false;

    if(_seDetailsController.hasValue && _seDetailsController.value != null) 
    {
      seDetails.addAll(_seDetailsController.value);
      for(SalesEntryDetails dtl in _seDetailsController.value) 
        { if(dtl.productCode.trim() == _seProdCodeController.value.trim()) {isrepeated = true;}}     
    }

  if (!isrepeated)
  {
    if(_seProdCodeController.value != null && _seQtyController.value != null)
    {
      seDetailList = await seAPI.getSalesEntryItem(StaticsVar.branchID, _seCustCodeController.value.trim(), 
                      _seProdCodeController.value.trim(), _seQtyController.value);
      if (seDetailList != null)
      {
        for(SalesEntryDetails sed in seDetailList)
        {
          sed.status = false;
          if(sed.parentProductCode == "")
          {  
            _seUOMController.sink.add(sed.uom == "" ? null : sed.uom);
            _seSellRateController.sink.add(sed.sellRate.toString());
          }
          seDetails.add(sed);          
        }
        _seDetailsController.sink.add(seDetails);
      }
    }  
  }  
  
    // after adding Set Detail Stream fields to null
    // _seProdCodeController.sink.add(null);
    // _seUOMController.sink.add(null);
    // _seQtyController.sink.add(null);
  }

  //updateSalesEntryDetail(String quotProdCode)
  addSEDetails(Users loginInfo)
  {
    SalesEntryDetails quotItem = new SalesEntryDetails();
    List<SalesEntryDetails> listSEDetails = [];
    bool isNew = true;
    if(_seDetailsController.value != null) {//listSEDetails.addAll(_seDetailsController.value); 
      for (SalesEntryDetails item in _seDetailsController.value)
      { 
        if(item.parentProductCode.trim() == _seProdCodeController.value.trim())
        {item.status = true;}

        if(item.productCode.trim() == _seProdCodeController.value.trim())
        { 
          isNew = false;
          item.productCode = _seProdCodeController.value;
          item.quantity = double.parse( _seQtyController.value);
          item.sellRate = double.parse(_seSellRateController.value); // bharath added 04.06.19.1.46pm
          item.sellPrice = (item.sellPrice == 0.0) ? (item.sellRate * item.quantity) : item.sellPrice;
          item.uom = (_seUOMController.value); //bharath added
          item.createdBy = loginInfo.userID;
          item.createdOn = DateTime.now();
          item.status = true;
          item.discountType = (_seDiscountTypeController.value);
          item.discountAmount = double.parse(_seDiscountTypeController.value == 'NONE' ? "0.0" : _seDiscountController.value );
          //'NONE','PERCENTAGE','AMOUNT',
          // print('DISC : ' + item.discountType);
          if(item.discountType=='AMOUNT')
            { item.partialPayment = (item.sellPrice == 0.0) ? 0.0 : (item.sellPrice - item.discountAmount); }
          if(item.discountType=='PERCENTAGE')
            {item.partialPayment = (item.sellPrice == 0.0) ? 0.0 : (item.sellPrice - ((item.sellPrice * item.discountAmount)/100));}
          if(item.discountType=='NONE') {item.partialPayment = item.sellPrice;}
        } 
        listSEDetails.add(item);
      }
    }

    if(isNew)
    {
      quotItem.productCode = _seProdCodeController.value;
      quotItem.quantity = double.parse( _seQtyController.value);
      quotItem.sellRate = double.parse(_seSellRateController.value); // bharath added 04.06.19.1.46pm
      quotItem.sellPrice = (quotItem.sellPrice == 0.0) ? (quotItem.sellRate * quotItem.quantity) : quotItem.sellPrice;
      quotItem.uom = _seUOMController.value; //bharath added
      quotItem.createdBy = loginInfo.userID;
      quotItem.createdOn = DateTime.now();
      quotItem.discountType = (_seDiscountTypeController.value);
      quotItem.status = true;
      quotItem.discountAmount = double.parse(_seDiscountTypeController.value == 'NONE' ? "0.0" : _seDiscountController.value );
      //'NONE','PERCENTAGE','AMOUNT',
      // print('DISC : ' + quotItem.discountType);
      if(quotItem.discountType=='AMOUNT')
        { quotItem.partialPayment = (quotItem.sellPrice == 0.0) ? 0.0 : (quotItem.sellPrice - quotItem.discountAmount); }
      if(quotItem.discountType=='PERCENTAGE')
        {quotItem.partialPayment = (quotItem.sellPrice == 0.0) ? 0.0 : (quotItem.sellPrice - ((quotItem.sellPrice * quotItem.discountAmount)/100));}
      if(quotItem.discountType=='NONE') {quotItem.partialPayment = quotItem.sellPrice;}
        
      listSEDetails.add(quotItem);      
    }

    _seDetailsController.sink.add(listSEDetails);
  }  

  SalesEntryHd getSalesEntry(Users loginInfo,String orderNum)
  {
    bool isPaidAmtCanEdit = (orderNum == "");

    SalesEntryHd seHD = new SalesEntryHd();
    seHD.orderNo = orderNum;
    seHD.orderDate= DateTime.now();
    seHD.branchId= StaticsVar.branchID;
    seHD.customerCode= _seCustCodeController.value;
    seHD.customerName = getCustomerName(_seCustCodeController.value);
    seHD.regNo= "";
    seHD.customerAddress= "";
    seHD.saleType= _sePaymentTypeController.value == null ? "" : _sePaymentTypeController.value;
    seHD.status= true;
    seHD.isApproved= false;
    seHD.createdBy= loginInfo.userID;
    seHD.createdOn= DateTime.now();
    seHD.modifiedBy = loginInfo.userID;
    seHD.modifiedOn = DateTime.now();
    seHD.isPayLater= false;
    seHD.paymentDays= 0;
    seHD.totalAmount= getAmt('TOTAL',isPaidAmtCanEdit);
    seHD.isVat= _seVatController.value == null ? false : _seVatController.value;
    seHD.isWhTax= _seWHTaxController.value == null ? false : _seWHTaxController.value;
    seHD.vatAmount= getAmt('VAT',isPaidAmtCanEdit);
    seHD.whTaxPercent= StaticsVar.whTaxPercent;
    seHD.withHoldingAmount= getAmt('WHTAX',isPaidAmtCanEdit);
    seHD.netAmount= getAmt('NET',isPaidAmtCanEdit);
    seHD.paidAmount= getAmt('PAID',isPaidAmtCanEdit);
    seHD.balanceAmount= getAmt('BALANCE',isPaidAmtCanEdit);
    seHD.discountAmount= getAmt('DISCOUNT',isPaidAmtCanEdit);
    seHD.paymentType = _sePaymentTypeController.value== null ? "" :  _sePaymentTypeController.value;
    seHD.isRequireDelivery = false;
    seHD.deliveryDate= _seDelvDateController.value == null ? DateTime.now() : _seDelvDateController.value;
    seHD.remarks= _seRemarksController.value == null ? "" :  _seRemarksController.value;
    seHD.uom= "";
    seHD.orderDetails = _seDetailsController.value;

    return seHD;
  }

  vatchecked()
  {
    _seVatController.stream.listen((onSelect)
    { _sePaidAmntController.sink.add("0.0");
      _seDetailsController.sink.add(_seDetailsController.value);});
    _seWHTaxController.stream.listen((onSelect)
    { _sePaidAmntController.sink.add("0.0");
      _seDetailsController.sink.add(_seDetailsController.value);});
    _sePaidAmntController.stream.listen((ondata){_seDetailsController.sink.add(_seDetailsController.value);});

    _seCustCodeController.stream.listen((ondata){_seCustAddressController.sink.add(getCustomerAddress(ondata));}); 
  }

  getAmt(String amtType, bool isPaidAmtCanEdit)
  {
    double amount = 0.00;
    double totAmt = 0.00;
    double netAmt = 0.00;
    double discAmt = 0.00;
    double vatAmt = 0.00;
    double whTaxAmt = 0.00;
    double paidAmt = 0.00;

    if(_seDetailsController.hasValue)
    {
      for (SalesEntryDetails quotItem in _seDetailsController.value)
      {
        //print('Partial AMT ' + quotItem.partialPayment.toString()); 
        if(quotItem.status)
        {  
          totAmt = totAmt + quotItem.sellPrice;
          netAmt = netAmt + quotItem.partialPayment;
          discAmt = totAmt - (netAmt > 0.00 ? netAmt : totAmt);
        }
      }
    }
    
    if(_seVatController.hasValue) // if checked Vat then net = net + Vat
      { if(_seVatController.value) 
        { //print('VAT AMT ' ); 
          vatAmt = ((totAmt - discAmt) * (StaticsVar.vatPercent/100));
          netAmt =  netAmt + vatAmt;}
      } 
    if(_seWHTaxController.hasValue) // if checked Vat then net = net - withHold tax
      { if(_seWHTaxController.value) 
        { //print('WHTAX AMT ' ); 
          whTaxAmt = ((totAmt - discAmt) * (StaticsVar.whTaxPercent/100));
          netAmt = netAmt - whTaxAmt;}
      }
    if(_sePaidAmntController.hasValue)
      { //print('PAID AMT ' ); 
        if(_sePaidAmntController.value == "0.0")
          { paidAmt = double.parse(netAmt.toStringAsFixed(2)); _sePaidAmntController.sink.add(paidAmt.toString());} // double.parse(_sePaidAmntController.value.toString());}
        else
          { paidAmt = double.parse(_sePaidAmntController.value == "" ? "0.0" : _sePaidAmntController.value.toString());}
        // if(isPaidAmtCanEdit) 
        // {paidAmt = double.parse(netAmt.toStringAsFixed(2)); //_sePaidAmntController.sink.add(paidAmt.toString());
        // }
      }
      
    if(amtType == 'TOTAL')
      {amount = totAmt;}
    if(amtType == 'DISCOUNT')
      {amount = discAmt;} 
      // if net amt is zero then disc is having wrong value, Hence condition applied
    if(amtType == 'NET')
      {amount = netAmt;}
    if(amtType == 'VAT')
      {amount = vatAmt;}
    if(amtType == 'WHTAX')
      {amount = whTaxAmt;}
    if(amtType == 'PAID')
      {amount = paidAmt;}      
    if(amtType == 'BALANCE')
      {amount = netAmt - paidAmt;}
     
    return (double.parse(amount.toStringAsFixed(2)));   
  }

  deleteSEDetail(String poProdCode)
  {
    List<SalesEntryDetails> listSEDtls = [];
    for (SalesEntryDetails seDT in _seDetailsController.value)
    {
      if(seDT.productCode.trim() == poProdCode.trim() || !seDT.status)
      {seDT.status = false;} else {seDT.status = true;}
      listSEDtls.add(seDT);
    }
    _seDetailsController.sink.add(listSEDtls);
    _seDetailsController.stream.listen((onData) => {});    
  }

  // END OF SALES ENTRY

  // Transaction GOODS RECEIVER Stream Declaration and 
  
  final _gRPOnoController =BehaviorSubject<String>();
  final _gRProdRectNOController =BehaviorSubject<String>();
  final _gRDateController =BehaviorSubject<DateTime>();
  final _gRVendorController =BehaviorSubject<String>();
  final _gRReceivedQtyController = BehaviorSubject<String>();
  final _gRHeaderController = BehaviorSubject<GoodsReceiverHD>();
  final _gRItemsController = BehaviorSubject<List<GoodsReceiveItems>>();

  Stream<String> get gRPOno => _gRPOnoController.stream.transform(validateTxtFld);
  Stream<String> get gRProdRectNO => _gRProdRectNOController.stream.transform(validateTxtFld);
  Stream<DateTime> get gRDate => _gRDateController.stream.transform(dateTimeValidator);
  Stream<String> get gRVendor => _gRVendorController.stream.transform(validateTxtFld);
  Stream<String> get gRReceivedQty => _gRReceivedQtyController.stream.transform(validateTxtFld);
  Stream<GoodsReceiverHD> get gRHeader => _gRHeaderController.stream.transform(gRHeaderValidators);
  Stream<List<GoodsReceiveItems>> get gRItems => _gRItemsController.stream.transform(gRItemsValidators);

  Function(String) get gRPOnoChanged  => _gRPOnoController.sink.add;
  Function(String) get gRProdRectNOeChanged => _gRProdRectNOController.sink.add;
  Function(DateTime)get gRDateChanged => _gRDateController.sink.add;
  Function(String) get gRVendorChanged  => _gRVendorController.sink.add;
  Function(String) get gRReceivedQtyChanged  => _gRReceivedQtyController.sink.add;
  Function(List<GoodsReceiveItems>) get gRItemsChanged  => _gRItemsController.sink.add;
  
    getPODetilsforGoodsReceive() async 
    {
    GoodsReceiverApi grAPI = new GoodsReceiverApi();
    GoodsReceiverHD grHD = new GoodsReceiverHD();

    grHD = await grAPI.getPOforGoodsReceiver(_gRPOnoController.value);
    if (grHD.documentNo != null) _gRProdRectNOController.sink.add(grHD.documentNo);
    if (grHD.documentDate != null) _gRDateController.sink.add(grHD.documentDate);
    if (grHD.supplierCode != null) _gRVendorController.sink.add(grHD.supplierCode);
    if (grHD != null ) _gRHeaderController.sink.add(grHD);
    if (grHD.goodsReceivePoDetailList != null) _gRItemsController.sink.add(grHD.goodsReceivePoDetailList);
    }

  clearGoodsReceivr()
  {
    _gRPOnoController.sink.add(null);
    _gRProdRectNOController.sink.add(null);
    _gRDateController.sink.add(null);
    _gRVendorController.sink.add(null);
    _gRItemsController.sink.add(null);
  }

  deleteGrItems(String productCode)
  {
    List<GoodsReceiveItems> listGrItems = [];
    for (GoodsReceiveItems quotItem in _gRItemsController.value)
    {
      if(quotItem.productCode.trim() != productCode.trim() || !quotItem.status) 
      {quotItem.status = true;} else {quotItem.status = false;}
      listGrItems.add(quotItem);
    }
    _gRItemsController.sink.add(listGrItems);
  }

  GoodsReceiverHD getSaveGoodsReceiver(Users loginInfo)
  {
    GoodsReceiverHD grHD = new GoodsReceiverHD();
    
    grHD = _gRHeaderController.value;
    grHD.modifiedBy =  loginInfo.userID;
    grHD.modifiedOn = DateTime.now();
    grHD.goodsReceivePoDetailList = _gRItemsController.value;

    return grHD;
  }

  editGoodsReceiverItem(String quotProdCode)
  {
    List<GoodsReceiveItems> listQuotItems = [];
    for (GoodsReceiveItems quotItem in _gRItemsController.value)
    { 
      if(quotItem.productCode==quotProdCode) 
      { quotItem.receiveQuantity = double.parse(_gRReceivedQtyController.value);
        quotItem.pendingQuantity = quotItem.pendingQuantity - double.parse(_gRReceivedQtyController.value);
      }
      listQuotItems.add(quotItem);
    }
    _gRItemsController.sink.add(listQuotItems);
  }

  fetchGoodsReceive(String documentNo) async
  {
    // if(documentNo == null || documentNo == ""){clearPO();}
    // else{
      GoodsReceiverApi grApi = new GoodsReceiverApi();
      GoodsReceiverHD grHD = await grApi.getGoodReceive(StaticsVar.branchID, documentNo);
        if(grHD != null)
          {
            _gRPOnoController.sink.add(grHD.poNo.trim());
            _gRProdRectNOController.sink.add(grHD.documentType.toString());
            _gRDateController.sink.add(grHD.documentDate);
            _gRVendorController.sink.add(grHD.supplierCode.toString());
            // _gRReceivedQtyController.sink.add(grHD.poNo.trim());
            // _gRHeaderController.sink.add(grHD.poNo.trim());
              if(grHD.goodsReceivePoDetailList != null)
              {_gRItemsController.sink.add(grHD.goodsReceivePoDetailList);}
          }
        // }
  }



  // ENDS GOODS RECEIVER

  // inquiry bloc
  final _branchInqDDController = BehaviorSubject<String>();
  final _productInqDDController = BehaviorSubject<String>();
  final _catInqDDController = BehaviorSubject<String>();
  final _suppliercatInqDDController = BehaviorSubject<String>();
  final _inquiryDtlsController = BehaviorSubject<String>();
  final _inqInvCusmrController = BehaviorSubject<String>();
  final _inqInvDateFromController = BehaviorSubject<DateTime>();
  final _inqInvDateToController = BehaviorSubject<DateTime>();
  final _inqInvPaymentTypController = BehaviorSubject<String>();
  final _stockInqDtlsController = BehaviorSubject<List<StockInquiry>>();

  Stream<String> get branchInqdd => _branchInqDDController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<String> get prodcatInqdd => _productInqDDController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<String> get catInqdd => _catInqDDController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<String> get supplierCodeInqdd => _suppliercatInqDDController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<String> get inqInvCustmr => _inqInvCusmrController.stream.transform(proUOMDrpdwnPoupValidator);
  Stream<DateTime> get inqInvDateFrom => _inqInvDateFromController.stream.transform(dateTimeValidator);
  Stream<DateTime> get inqInvDateTo => _inqInvDateToController.stream.transform(dateTimeValidator);
  Stream<String> get inqInvType => _inqInvPaymentTypController.stream.transform(proUOMDrpdwnPoupValidator);
 Stream<List<StockInquiry>> get stockInqDtls => _stockInqDtlsController.stream.transform(stockInqValidator);  


  Function(String) get branchInqddChanged => _branchInqDDController.sink.add;
  Function(String) get prodcatInqddChanged => _productInqDDController.sink.add;
  Function(String) get catInqddrddChanged => _catInqDDController.sink.add;
  Function(String) get supplierCodeInqddChanged => _suppliercatInqDDController.sink.add;
  Function(String) get inqInvCustmrChanged => _inqInvCusmrController.sink.add;
  Function(DateTime) get inqInvDateFromChanged => _inqInvDateFromController.sink.add;
  Function(DateTime) get inqInvDateToChanged => _inqInvDateToController.sink.add;
  Function(String) get inqInvTypeChanged => _inqInvPaymentTypController.sink.add;
  Function(List<StockInquiry>)get stockInqDtlsChanged => _stockInqDtlsController.sink.add;

  
  getSr4InqInvoices() async
  {
    InquiryApi inqApi = new InquiryApi();
    SrchUnApprdInvoice inqInvoice = new SrchUnApprdInvoice();
    
    inqInvoice.branchId = StaticsVar.branchID;
    inqInvoice.customerCode = _inqInvCusmrController.value;
    inqInvoice.dateFrom = _inqInvDateFromController.value;
    inqInvoice.dateTo = _inqInvDateToController.value;
    inqInvoice.invoiceType = _inqInvPaymentTypController.value;  
    _unApprvdInvController.sink.add(await inqApi.getInquiryInvoices(inqInvoice));
  }

  getSer4StockInq() async
  {
    InquiryApi inqApi = new InquiryApi();
    Search4StockEnq stockInq = new Search4StockEnq();
    
    stockInq.branchId = StaticsVar.branchID;
    stockInq.productCode = _productInqDDController.value;
    stockInq.productCategory = _catInqDDController.value;
    stockInq.supplierCode = _suppliercatInqDDController.value;
    _stockInqDtlsController.sink.add(await inqApi.getStockInquiry(stockInq));

  }

  clearStockInq()
  {
    _branchInqDDController.sink.add(null);
    _productInqDDController.sink.add(null);
    _catInqDDController.sink.add(null);
    _suppliercatInqDDController.sink.add(null);
    _stockInqDtlsController.sink.add(null);
  }

  clearInqInvoice()
  {
    String initdate = DateFormat("yyyy-MM-01").format(DateTime.now()).toString();
     _inqInvCusmrController.sink.add(null);
      _inqInvDateFromController.sink.add(DateTime.tryParse(initdate));
      _inqInvDateToController.sink.add(DateTime.now());
     _inqInvPaymentTypController.sink.add(null);
     _unApprvdInvController.sink.add(null);
  }
  // Billing

// Invoice Approval _invApDateToController
  final _invAprCustomerController =BehaviorSubject<String>();
  final _invApDateFromController =BehaviorSubject<DateTime>();
  final _invApDateToController =BehaviorSubject<DateTime>();
  final _invApprvdPaymentController =BehaviorSubject<String>();
  final _isInvSelectedController =BehaviorSubject<bool>();
  final _unBilldCustomerController =BehaviorSubject<String>();
  final _unBilldDateFormController =BehaviorSubject<DateTime>();
  final _unBilldDateToController =BehaviorSubject<DateTime>();
  final _unBilldPaymentController =BehaviorSubject<String>();
  final _unApprvdInvController = BehaviorSubject<List<UnApprovedInvoice>>();
  final _unBilledInvController = BehaviorSubject<List<UnBilledInvoice>>();

  Stream<String> get invAprCustomer => _invAprCustomerController.stream.transform(validateTxtFld);
  Stream<DateTime> get invApDateFrom => _invApDateFromController.stream.transform(dateTimeValidator);
  Stream<DateTime> get invApDateTo => _invApDateToController.stream.transform(dateTimeValidator);
  Stream<String> get invApprvlPayment => _invApprvdPaymentController.stream.transform(validateTxtFld);
  Stream<bool> get isInvSelected => _isInvSelectedController.stream.transform(isSelectedValidator);
  Stream<String> get unBilldCustomer => _unBilldCustomerController.stream.transform(validateTxtFld);
  Stream<DateTime> get unBilldDateFrom => _unBilldDateFormController.stream.transform(dateTimeValidator);
  Stream<DateTime> get unBilldDateTo => _unBilldDateToController.stream.transform(dateTimeValidator);
  Stream<String> get unBilldPayment => _unBilldPaymentController.stream.transform(validateTxtFld);
  Stream<List<UnApprovedInvoice>> get unApprvdInvoices => _unApprvdInvController.stream.transform(unApprvdInvValidator);
  Stream<List<UnBilledInvoice>> get unBilledInvoices => _unBilledInvController.stream.transform(unBilledInvValidator);  


  Function(String)get invAprCustomerChanged => _invAprCustomerController.sink.add;
  Function(DateTime)get invApDateChanged => _invApDateFromController.sink.add;
  Function(DateTime) get invApDateToChanged  => _invApDateToController.sink.add;
  Function(String)get invApprvlPaymentChenged => _invApprvdPaymentController.sink.add;
  Function(bool)get isInvSelectedChanged => _isInvSelectedController.sink.add;
  Function(String)get unBilldCustomerChanged => _unBilldCustomerController.sink.add;
  Function(DateTime)get unBilldDateFormChanged => _unBilldDateFormController.sink.add;
  Function(DateTime) get unBilldDateToChanged  => _unBilldDateToController.sink.add;
  Function(String)get unBilldPaymentChanged => _unBilldPaymentController.sink.add;
  Function(List<UnApprovedInvoice>)get unApprvdInvoicesChanged => _unApprvdInvController.sink.add;
  Function(List<UnBilledInvoice>)get unBilledInvoicesChanged => _unBilledInvController.sink.add;

  getSr4unApprvdInvoices() async
  {
    InvoiceApi invApi = new InvoiceApi();
    SrchUnApprdInvoice sr4unApprInv = new SrchUnApprdInvoice();
    
    sr4unApprInv.branchId = StaticsVar.branchID;
    sr4unApprInv.customerCode = _invAprCustomerController.value;
    sr4unApprInv.dateFrom = _invApDateFromController.value;
    sr4unApprInv.dateTo = _invApDateToController.value;
    sr4unApprInv.invoiceType = _invApprvdPaymentController.value;  
    _unApprvdInvController.sink.add(await invApi.getUnApprovedInvoices(sr4unApprInv));
      
    // return sr4unApprInv;
  }

  isInvoiceChecked(String invNo,bool isChked)
  {
    print('Invoice No. '+ invNo + ' - ' + (isChked ? 'true' : 'False'));
    if(_unApprvdInvController.value != null)
    {
      //unInvList.addAll(_unApprvdInvController.value);
      print('Invoice No1. '+ invNo + ' - ' + (isChked ? 'true' : 'False'));
      for(UnApprovedInvoice uaInv in _unApprvdInvController.value) 
      {
        if(uaInv.invoiceNo.trim() == invNo.trim())
        {
          uaInv.isChecked = isChked;
        }
      }
    }
    _unApprvdInvController.sink.add(_unApprvdInvController.value);
  }

  List<SelectedInvoices> selectedInvs(String userid)
  {
    List<SelectedInvoices> selInvs = [];

    //if(_unApprvdInvController.value != null)
    if(_unBilledInvController.value != null)
    {
      //print('Invoice No1.'+invNo);
      for(UnBilledInvoice uaInv in _unBilledInvController.value) 
      {
        if(uaInv.isChecked)
        {
          SelectedInvoices selinv = new SelectedInvoices();
          selinv.branchID = StaticsVar.branchID;
          selinv.invoiceNo = uaInv.invoiceNo.trim();
          selinv.userID = userid;

          selInvs.add(selinv);
        }
      }
    }    
    return selInvs;
  }

  List<SelectedInvoices> selectedInvs4Approval(String userid)
  {
    List<SelectedInvoices> selInvs = [];

    //if(_unApprvdInvController.value != null)
    if(_unApprvdInvController.value != null)
    {
      //print('Invoice No1.'+invNo);
      for(UnApprovedInvoice uaInv in _unApprvdInvController.value) 
      {
        if(uaInv.isChecked)
        {
          SelectedInvoices selinv = new SelectedInvoices();
          selinv.branchID = StaticsVar.branchID;
          selinv.invoiceNo = uaInv.invoiceNo.trim();
          selinv.userID = userid;

          selInvs.add(selinv);
        }
      }
    }
    return selInvs;
  }

  clearInvApprove()
  {
    //String initdate = DateFormat("yyyy-MM-01").format(DateTime.now()).toString();
    var date = DateTime.now(); 
    _invAprCustomerController.sink.add(null);
    //_invApDateFromController.sink.add(DateTime.tryParse(initdate));
    _invApDateFromController.sink.add(DateTime(date.year, date.month, 1));
    _invApDateToController.sink.add(DateTime.now());
    _invApprvdPaymentController.sink.add('CASH');  
    _unApprvdInvController.sink.add(null);
  }

  
  getSr4UnBilledInvoices() async
  {
    InvoiceApi invApi = new InvoiceApi();
    SrchUnApprdInvoice sr4UnBildInv = new SrchUnApprdInvoice();    
    sr4UnBildInv.branchId = StaticsVar.branchID;
    sr4UnBildInv.customerCode = _unBilldCustomerController.value;
    sr4UnBildInv.dateFrom = _unBilldDateFormController.value;
    sr4UnBildInv.dateTo = _unBilldDateToController.value; 
    sr4UnBildInv.invoiceType = _unBilldPaymentController.value;  
    _unBilledInvController.sink.add(await invApi.getUnBilledInvoices(sr4UnBildInv));
  }

  isUnbldInvoiceChecked(String invNo,bool isChkd)
  {
    print('Invoice No. '+ invNo + ' - ' + (isChkd ? 'true' : 'False'));
    if(_unBilledInvController.value != null)
    {
      //unInvList.addAll(_unBilledInvController.value);
      print('Invoice No1. '+ invNo + ' - ' + (isChkd ? 'true' : 'False'));
      for(UnBilledInvoice uaInv in _unBilledInvController.value) 
      {
        if(uaInv.invoiceNo.trim() == invNo.trim())
        {
          uaInv.isChecked = isChkd;
        }
      }
    }
    _unBilledInvController.sink.add(_unBilledInvController.value);
  }

 List<SelectedInvoices> selectedUnbillInvs(String userid)
  {
    List<SelectedInvoices> selInvs = [];

    if(_unBilledInvController.value != null)
    {
      //print('Invoice No1.'+invNo);
      for(UnBilledInvoice uaInv in _unBilledInvController.value) 
      {
        if(uaInv.isChecked)
        {
          SelectedInvoices selinv = new SelectedInvoices();
          selinv.branchID = StaticsVar.branchID;
          selinv.invoiceNo = uaInv.invoiceNo.trim();
          selinv.userID = userid;
          selInvs.add(selinv);
        }
      }
    }
    
    return selInvs;
  }

  clearUnbilledInv()
  {
    var date = DateTime.now(); 
    _unBilldCustomerController.sink.add(null);
    //_unBilldDateFormController.sink.add(DateTime.tryParse(initdate));
    _unBilldDateFormController.sink.add(DateTime(date.year, date.month, 1));
    _unBilldDateToController.sink.add(DateTime.now());
    _unBilldPaymentController.sink.add(null);  
    _unBilledInvController.sink.add(null);
  }


  // Customer invoice list
  final _cusInvCusName =BehaviorSubject<String>();
  final _cusInvAddressController =BehaviorSubject<String>();
  final _cusInvCusDate =BehaviorSubject<DateTime>();
  final _invNoController =BehaviorSubject<String>();
  final _orderNoController =BehaviorSubject<String>();
  final _itemNoController =BehaviorSubject<String>();
  final _prodCodController =BehaviorSubject<String>();
  final _prdDesController =BehaviorSubject<String>();
  final _quontityController =BehaviorSubject<String>();
  final _priceController =BehaviorSubject<String>();
  final _cusInvAmtController =BehaviorSubject<String>();
  final _cusDisAmtController =BehaviorSubject<String>();
  final _cusVATController =BehaviorSubject<String>();
  final _cusWHTaxController =BehaviorSubject<String>();
  final _cusTotAmtController =BehaviorSubject<String>();
  final _cusPaidAmtController =BehaviorSubject<String>();
  final _cusBalAmtController =BehaviorSubject<String>();
  final _cusinvDtlsController =BehaviorSubject<List<CustomerInvDts>>();

  Stream<String> get cusInvAmt => _cusInvAmtController.stream.transform(emailValidator);
  Stream<String> get cusDisAmt => _cusDisAmtController.stream.transform(emailValidator);
  Stream<String> get cusVAT => _cusVATController.stream.transform(emailValidator);
  Stream<String> get cusWHT => _cusWHTaxController.stream.transform(emailValidator);
  Stream<String> get cusTotAmt => _cusTotAmtController.stream.transform(emailValidator);
  Stream<String> get cusPaidAmt => _cusPaidAmtController.stream.transform(emailValidator);
  Stream<String> get cusBalAmt => _cusBalAmtController.stream.transform(emailValidator);


  Stream<String> get cusAddress => _cusInvAddressController.stream.transform(emailValidator);
  Stream<String> get cusName => _cusInvCusName.stream.transform(emailValidator);
  Stream<DateTime> get cusInvDate => _cusInvCusDate.stream.transform(dateTimeValidator);
  Stream<String> get cusInvNo => _invNoController.stream.transform(emailValidator);
  Stream<String> get cusInvOrderNo => _orderNoController.stream.transform(emailValidator);
  Stream<String> get cusInvItemNo => _itemNoController.stream.transform(emailValidator);
  Stream<String> get cusInvProdCode => _prodCodController.stream.transform(emailValidator);
  Stream<String> get cusInvPrdDes => _prdDesController.stream.transform(emailValidator);
  Stream<String> get cusInvQty => _quontityController.stream.transform(emailValidator);
  Stream<String> get cusInvPrice => _priceController.stream.transform(emailValidator);
  Stream<List<CustomerInvDts>> get cusInvDtls => _cusinvDtlsController.stream.transform(cusInvDtlsValidator);

  Function(String) get cusInvAmtChanged => _cusInvAmtController.sink.add;
  Function(String) get cusDisAmtChanged => _cusDisAmtController.sink.add;
  Function(String) get cusVATChanged => _cusVATController.sink.add;
  Function(String) get cusWHTChanged => _cusWHTaxController.sink.add;
  Function(String) get cusTotAmtChanged => _cusTotAmtController.sink.add;
  Function(String) get cusPaidAmtChanged => _cusPaidAmtController.sink.add;
  Function(String) get cusBalAmtChanged => _cusBalAmtController.sink.add;


  Function(String) get cusAddressChanged => _cusInvAddressController.sink.add;
  Function(String) get cusNameNoChanged => _cusInvCusName.sink.add;
  Function(DateTime) get cusInvDateChanged => _cusInvCusDate.sink.add;
  Function(String) get cusInvNoChanged => _invNoController.sink.add;
  Function(String) get cusInvOrderNoChanged => _orderNoController.sink.add;
  Function(String) get cusInvItemNoChanged => _itemNoController.sink.add;
  Function(String) get cusInvProdCodeChanged => _prodCodController.sink.add;
  Function(String) get cusInvPrdDesChanged => _prdDesController.sink.add;
  Function(String) get cusInvQtyChanged => _quontityController.sink.add;
  Function(String) get cusInvPriceChanged => _priceController.sink.add;
  Function(List<CustomerInvDts>) get cusInvDtlsChanged => _cusinvDtlsController.sink.add;

   
  fetchCusInvDtls(String invoiceNo) async
  {
    // if(invNo == null || invNo == ""){clearPO();}
    // else{
      _cusinvDtlsController.sink.add(null);
            
      InvoiceApi invApi = new InvoiceApi();
      CustomerInvHd cusHD = await invApi.getCusInvList(StaticsVar.branchID,invoiceNo);
        if(cusHD != null)
          {
            _invNoController.sink.add(cusHD.invoiceNo);
            _cusInvAddressController.sink.add(getCustomerAddress(cusHD.customerCode.trim()));            
            _orderNoController.sink.add(cusHD.orderNo);
            _cusInvCusName.sink.add(cusHD.customerName.toString());
            _cusInvCusDate.sink.add(cusHD.invoiceDate);
            _cusInvAmtController.sink.add(cusHD.invoiceAmount.toString());
            _cusDisAmtController.sink.add(cusHD.discountAmount.toString());
            _cusVATController.sink.add(cusHD.vatAmount.toString());
            _cusWHTaxController.sink.add(cusHD.whTaxPercent.toString());
            _cusTotAmtController.sink.add(cusHD.totalAmount.toString());
            _cusPaidAmtController.sink.add(cusHD.paidAmount.toString());
            _cusBalAmtController.sink.add(cusHD.balanceAmount.toString());    
            if(cusHD.invoiceDetails != null)
            {_cusinvDtlsController.sink.add(cusHD.invoiceDetails);}    
          }
        // }
  }

  //    display4InvDtls(String invNo)
  // {
  //   //List<QuotationItems> listQuotItems = [];
  //   for (CustomerInvDts invitems in _cusinvDtlsController.value)
  //   { if(invitems.invoiceNo == invNo) 
  //     {
  //           _invNoController.sink.add(invitems.invoiceNo);
  //            _orderNoController.sink.add(invitems.orderNo);
  //            _itemNoController.sink.add(invitems.itemNo.toString());
  //            _prodCodController.sink.add(invitems.productCode);
  //            _prdDesController.sink.add(invitems.productDescription);
  //            _quontityController.sink.add(invitems.quantity.toString());
  //            _priceController.sink.add(invitems.price.toString());      
  //     }
  //   }
  // }

 




  // Login Screen
  final _emailController =BehaviorSubject<String>();
  final _passwordController=  BehaviorSubject<String>();
  final _showPasswordController =BehaviorSubject<bool>();
  Stream<bool> get showPwd => _showPasswordController.stream.transform(showPwdValidator);  
  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password => _passwordController.stream.transform(passwordlValidator);
  Stream<bool> get submitCheck => Observable.combineLatest2(email, password, (e,p,)=>true);
  Function(bool) get showPwdChanged => _showPasswordController.sink.add;   
  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  showPassword(bool showpwd)
  {
    _showPasswordController.sink.add(showpwd);
  }

  // Supplier Tariff
  // Stream<List<Supplier>> get listViewDtls => _stSuppController.stream.transform(validatelistViewDtls);

  // QUOTATION STARTS

  
  // getPODetilsforGoodsReceive() async {
  //   GoodsReceiverApi grAPI = new GoodsReceiverApi();
  //   GoodsReceiverHD grHD = new GoodsReceiverHD();

  //   grHD = await grAPI.getPOforGoodsReceiver(_gRPOnoController.value);
  //   if (grHD.documentNo != null) _gRProdRectNOController.sink.add(grHD.documentNo);
  //   if (grHD.documentDate != null) _gRDateController.sink.add(grHD.documentDate);
  //   if (grHD.supplierCode != null) _gRVendorController.sink.add(grHD.supplierCode);
  //   if (grHD != null ) _gRHeaderController.sink.add(grHD);
  //   if (grHD.goodsReceivePoDetailList != null) _gRItemsController.sink.add(grHD.goodsReceivePoDetailList);

  // }

  fillPOContactPersonNAddrs() 
  {
    _poSuppCodeController.stream.listen((onData)
    { 
      _poContactPerController.sink.add(getSupplierContactPerson(onData));
      _adressController.sink.add(getSupplierAddress(onData));
    });

    _poProdCodeDDpopupController.stream.listen((onData) async
    {
      ProductApiProvider prodApi = new ProductApiProvider();
      Product prod = new Product();
      prod = await prodApi.getProductDetail(_poSuppCodeController.value, onData);
      _poUOMunitDDController.sink.add(prod.uom);
      _unitPricePopupController.sink.add(prod.buyingPrice.toString());
    });
  }

  


  getPOSummaryAmt(String amtType)
  {
      double amount = 0.00;
      double totAmt = 0.00;
      double otherChgs = 0.00;
      double vatAmt = 0.00;

      if(_poDetailsController.hasValue)
      {
        for (PurchaseOrderDetails poItem in _poDetailsController.value)
        {
          if(poItem.status)
          {totAmt = totAmt + poItem.unitPrice * poItem.quantity;}     
        }
      }

      if(_poVATController.hasValue) // if checked Vat then net = net + Vat
        { if(_poVATController.value) 
          { //print('VAT AMT ' ); 
            vatAmt = ((totAmt) * (StaticsVar.vatPercent/100));
        }} 
      if(_poOtherChargesController.hasValue)
        { //print('Other AMT ' ); 
          if(_poOtherChargesController.value != "")
            { otherChgs = double.parse(_poOtherChargesController.value.toString());}
        }
        
      if(amtType == 'TOTAL')
        {amount = totAmt;}
      if(amtType == 'OTHER')
        {amount = otherChgs;} 
        // if net amt is zero then disc is having wrong value, Hence condition applied
      if(amtType == 'NET')
        {amount = totAmt + vatAmt + otherChgs;}
      if(amtType == 'VAT')
        {amount = vatAmt;}     
      
      return (double.parse(amount.toStringAsFixed(2)));   
    }

  fetchPO(String poNum) async
  {
    if(poNum == null || poNum == ""){clearPO();}
    else{
      PurchaseOrederApi poApi = new PurchaseOrederApi();
      PurchaseOrderHD poHD = await poApi.getPO(StaticsVar.branchID, poNum);
        if(poHD != null)
          {
            _poSuppCodeController.sink.add(poHD.supplierCode.trim());
            _poNumberController.sink.add(poHD.poNo.trim());
            _poDateController.sink.add(poHD.poDate);
            _suppNameController.sink.add(poHD.supplierName.trim());
            _poContactPerController.sink.add(poHD.contactPerson.trim());
            _adressController.sink.add(getSupplierAddress(poHD.supplierCode.trim()));
            _shipingDateController.sink.add(poHD.shipmentDate);
            _estimateDateController.sink.add(poHD.estimateDate);
            _referenceNumController.sink.add(poHD.referenceNo.trim());
            _paymentController.sink.add(poHD.paymentTerm.trim());
            _prNumController.sink.add(poHD.prNo.trim());
            _remarksController.sink.add(poHD.remarks.trim());
              if(poHD.purchaseOrderDetails != null)
              {_poDetailsController.sink.add(poHD.purchaseOrderDetails);}
          }
        }
  }


   bool validateSupplierCode()
  {
    bool isSuppCodeAvailable = false;
    
    if(_poSuppCodeController.hasValue)
    {
      if(_poSuppCodeController.value != null && _poSuppCodeController.value != '')
      {
        isSuppCodeAvailable = true;
      }
    }

                    
    return isSuppCodeAvailable;    
  }

   display4EditPODtls(String poProdCode)
  {
    //List<QuotationItems> listQuotItems = [];
    for (PurchaseOrderDetails poItems in _poDetailsController.value)
    { if(poItems.productCode == poProdCode) 
      {
        _poProdCodeDDpopupController.sink.add(poItems.productCode);
        _poQuantitypopupController.sink.add(poItems.quantity.toString());
        _unitPricePopupController.sink.add(poItems.unitPrice.toString());
        _poUOMunitDDController.sink.add(poItems.uom);
        _poCurrencyPopupController.sink.add(poItems.currencyCode);
      
       
        // print('PCODE: ' + poItems.productCode );
        // print('Quantity: ' + poItems.quantity.toString() );
        // print('UOM: ' + poItems.uom);
        // print('CURRENCY : ' + poItems.currencyCode );
        // print('UNIT PRICE : ' + poItems.unitPrice.toString());
      }
    }
  }


  clearPO()
  {
    _poSuppCodeController.sink.add(null);
    _poNumberController.sink.add(null);
    _poDateController.sink.add(null);
    _suppNameController.sink.add(null);
    _poContactPerController.sink.add(null);
    _adressController.sink.add(null);
    _shipingDateController.sink.add(null);
    _estimateDateController.sink.add(null);
    _referenceNumController.sink.add(null);
    _paymentController.sink.add(null);
    _prNumController.sink.add(null);
    _remarksController.sink.add(null);
    _poDetailsController.sink.add(null);      
  }

  clearDisplay4PO()
  {
    _poProdCodeDDpopupController.sink.add(null);
    _poQuantitypopupController.sink.add(null);
    _unitPricePopupController.sink.add(null);
    _poUOMunitDDController.sink.add(null);
    _poCurrencyPopupController.sink.add(null);
  }





  fetchQuotation(String quotNo) async
  { 
    if(quotNo == null || quotNo == ""){clearQuotationHD();}
    else{
      QuotationApiProvider qtApi = new QuotationApiProvider();

      QuotationHd qtHD = await qtApi.getQuotation(StaticsVar.branchID, quotNo.trim());
      if(qtHD != null)
      {
        _qCusNoController.sink.add(qtHD.quotationNo.trim());
        _qCusCCodeController.sink.add(qtHD.customerCode.trim());
        _qCusEffecDateController.sink.add(qtHD.effectiveDate);
        _qCusExprDateController.sink.add(qtHD.expiryDate);
        if(qtHD.quotationItems != null)
        {_quotationItemsController.sink.add(qtHD.quotationItems);}

        // print('CUST name:' + qtHD.customerName.toString());
        // print('EFF date:' + qtHD.effectiveDate.toString());
        // print('EXP date:' + qtHD.expiryDate.toString());
        // print('Quot Items Length: ' + qtHD.quotationItems.length.toString());
        // print('Stream Name:' + _qCusCCodeController.value);
        // print('EFF date:' + _qCusEffecDateController.value.toString());
        // print('EXP date:' + _qCusExprDateController.value.toString());
        // print('Stream Items Length: ' + _quotationItemsController.value.length.toString());
      }
    }
  }

  
  getQuotationHD(String quotationType, String quotNo)
  {
    QuotationHd qoHD = new QuotationHd();
    qoHD.quotationNo= quotNo;
    qoHD.branchId= StaticsVar.branchID;
    qoHD.quotationDate= DateTime.now();
    qoHD.effectiveDate= _qCusEffecDateController.value;
    qoHD.expiryDate= _qCusExprDateController.value;
    qoHD.customerCode= _qCusCCodeController.value;
    qoHD.customerName= quotationType == 'CUSTOMER' ? getCustomerName(_qCusCCodeController.value.trim()) : getSupplierName(_qCusCCodeController.value.trim());
    qoHD.status= true;
    qoHD.createdBy= "admin";
    qoHD.createdOn= DateTime.now();
    qoHD.modifiedBy= "admin";
    qoHD.modifiedOn=  DateTime.now();
    qoHD.quotationType= quotationType;
    qoHD.quotationItems = _quotationItemsController.value;

    return qoHD;
  }

  clearQuotationHD()
  {
    _qCusNoController.sink.add(null);
    _qCusEffecDateController.sink.add(null);
    _qCusExprDateController.sink.add(null);
    _qCusCCodeController.sink.add(null);
    _quotationItemsController.sink.add(null);
  }

  deleteQuotaionItem(String quotProdCode)
  {
    List<QuotationItems> listQuotItems = [];
    for (QuotationItems quotItem in _quotationItemsController.value)
    { 
      // if(quotItem.productCode!=quotProdCode) { listQuotItems.add(quotItem);}
      // else {quotItem.status = false;}
      if(quotItem.productCode.trim() == quotProdCode.trim() || !quotItem.status) 
        { quotItem.status = false;} 
      else { quotItem.status = true;}   
       listQuotItems.add(quotItem);
    }
      _quotationItemsController.sink.add(listQuotItems);
      //_quotationItemsController.stream.listen((onData) => {});
  }

  display4EditQuotaionItem(String quotProdCode, List<QuotationItems> quotItems)
  {
    if(quotProdCode == null || quotProdCode == ""){print('Product details Clearing.......'); clearDisplay4EditQuotItem();}
    else{
      if(_quotationItemsController.value == null){_quotationItemsController.sink.add(quotItems);}

      for (QuotationItems quotItem in _quotationItemsController.value)
      {
        // print('Product details printing.......');
        //  print('PCODE: ' + quotItem.productCode );
        //   print('CURRENCY : ' + quotItem.currencyCode );
        //   print('SELL RATE : ' + quotItem.sellRate.toString());
        if(quotItem.productCode.trim() == quotProdCode.trim())
        {
          _qCusProdCodePUController.sink.add(quotItem.productCode.trim());
          _qCusPaymentPUController.sink.add(quotItem.currencyCode);
          _qCusSellratePUController.sink.add(quotItem.sellRate.toString());
        }
      }
    }
    // _quotationItemsController.sink.add(listQuotItems);
    // _quotationItemsController.stream.listen((onData) => {});
  }

  clearDisplay4EditQuotItem()
  {
    _qCusProdCodePUController.sink.add(null);
    _qCusPaymentPUController.sink.add(null);
    _qCusSellratePUController.sink.add(null);
  }

  addproductDescription(String productDesc)
  {
    _qProdDescriptionController.sink.add(productDesc);

    return productDesc;
  }

  validateProductDuplicate(BuildContext context)
  {
    List<QuotationItems> listQuotItems = [];
    _qCusProdCodePUController.stream.listen((onData) 
    {       
    if(_quotationItemsController.value != null)  //  || _quotationItemsController.hasValue)
      { 
        listQuotItems.addAll(_quotationItemsController.value); 
        for(QuotationItems item in listQuotItems)
        { 
          if(item.productCode.trim() == onData.trim())
          {
            // StaticsVar.showAlert(context, 'Duplicate Product Selected');
            _qCusPaymentPUController.sink.add(item.currencyCode);
            _qCusSellratePUController.sink.add(item.sellRate.toString());

          }
        }
      }
     
    });
  }

  addQuotationItems()
  {
    List<QuotationItems> listQuotItems = [];
    bool isNew = true;

    if(_quotationItemsController.value != null)  //  || _quotationItemsController.hasValue)
    { listQuotItems.addAll(_quotationItemsController.value); 
      for(QuotationItems item in listQuotItems)
      { if(item.productCode.trim() == _qCusProdCodePUController.value.trim())
        { isNew = false;
          item.sellRate = double.parse(_qCusSellratePUController.value);
          item.currencyCode= _qCusPaymentPUController.value.trim();
          item.productDescription = getProductName(_qCusProdCodePUController.value.trim());
          item.modifiedBy="admin";
          item.modifiedOn= DateTime.now();
    } } }

    if(isNew)
    {
      QuotationItems qoItems = new QuotationItems();
      qoItems.itemId = 1;
      qoItems.quotationNo = "";
      qoItems.productCode=_qCusProdCodePUController.value;
      qoItems.productDescription = getProductName(_qCusProdCodePUController.value.trim());
      //if(_qProdDescriptionController.value != null ) {qoItems.productDescription= _qProdDescriptionController.value;}
      qoItems.barCode="";
      qoItems.sellRate = double.parse(_qCusSellratePUController.value);
      qoItems.currencyCode= _qCusPaymentPUController.value.trim();
      qoItems.status= true;
      qoItems.createdBy="admin";
      qoItems.createdOn= DateTime.now();
      qoItems.modifiedBy="admin";
      qoItems.modifiedOn= DateTime.now();
      qoItems.recordStatus= 1;

      listQuotItems.add(qoItems);
    }

    print("Added Item success - " + _qCusProdCodePUController.value);
    print("Added Item length - " + listQuotItems.length.toString());
    
    _quotationItemsController.sink..add(listQuotItems);
     print("Stream Item length - " + _quotationItemsController.value.length.toString());
    //_quotationItemsController.stream.listen((onData) => {});
  }

  // Quotation Edit list

  // setQuotTariff(DateTime effDate,DateTime expDate)
  // {
    
  //   // _qCusCCodeController.sink.add(cusDD);
  //   _qCusEffecDateController.sink.add(effDate);
  //   _qCusExprDateController.sink.add(expDate);
  // }


  // QUOTAION ENDS


  // initInvDateFrom(bool isEditMode)
  // {
  //   // if(!isEditMode) { 
  //     //_qCustEffDateCtrl.sink.add(DateTime.now().toString());
  //     // var date = new DateTime.now();
  //     _invApDateFromController.sink.add(DateTime.now());   
        
  // }
  //   initInvDateTo(bool isEditMode)
  // {
  //     _invApDateToController.sink.add(DateTime.now());    
  // }
  
  //  initUnbldInvDateFrom(bool isEditMode)
  // {
  //   // var date = new DateTime.now();
  //   _unBilldDateFormController.sink.add(DateTime.now());
  // }

  //   initUnBldInvDateTo(bool isEditMode)
  // {
  //     _unBilldDateToController.sink.add(DateTime.now());    
  // }

   initPODate(bool isEditMode)
  {
    // if(!isEditMode) { 
      //_qCustEffDateCtrl.sink.add(DateTime.now().toString());
      _poDateController.sink.add(DateTime.now());
  }

    initSalEntyDate(bool isEditMode)
  {
    // if(!isEditMode) { 
      //_qCustEffDateCtrl.sink.add(DateTime.now().toString());
      _seSalesDateController.sink.add(DateTime.now());
  }

     initinqInvDateFrm(bool isEditMode)
  {
    // if(!isEditMode) { 
      //_qCustEffDateCtrl.sink.add(DateTime.now().toString());
      _inqInvDateFromController.sink.add(DateTime.now());
  }

       initinqInvDateTo(bool isEditMode)
  {
    // if(!isEditMode) { 
      //_qCustEffDateCtrl.sink.add(DateTime.now().toString());
      _inqInvDateToController.sink.add(DateTime.now());
  }
 

  initDatePromotion(bool isEditMode)
  {
    if(!isEditMode) { 
      //_qCustEffDateCtrl.sink.add(DateTime.now().toString());
      _effectiveDateController.sink.add(DateTime.now());}
  }
  initDateCust(bool isEditMode)
  {
    if(!isEditMode) { 
      //_qCustEffDateCtrl.sink.add(DateTime.now().toString());
      _qCusEffecDateController.sink.add(DateTime.now());}
  }
  initDateSupplier()
  {
    _qSupEffecDateController.sink.add(DateTime.now());
  }
    // Master data popup UOM lookups Flatbutton Edits Starts here

  setUOMDtls(String code, String description)
  {
    _lookUpCodeController.sink.add(code);
    _lookUpDesController.sink.add(description);
  }

  clearLookUps()
  {
    _lookUpCodeController.sink.add(null);
    _lookUpDesController.sink.add(null);
    _lookUpCodeController.stream.listen((ondata) {print(ondata==null ? "LOOKUP CODE empty" : ondata.toString());});
    _lookUpDesController.stream.listen((ondata) {print(ondata==null ? "LOOKUP DESC empty" : ondata.toString());});
  }

  setCurrencyDtls(String code,String description,String description1)
  {
    _currCodeController.sink.add(code);
    _currDesController.sink.add(description);
    _currDes1Controller.sink.add(description1);
  }

  setIncotermsDtls(String code,String description)
 {
   _incoCodeController.sink.add(code);
   _incoDesController.sink.add(description);
 }

  setProdCatDtls(String code,String description)
  {
    _prodCatCodeController.sink.add(code);
    _prodCatdescripController.sink.add(description);
  }

  setWhLocDtls(String code,String description)
  {
    
    _locCodeController.sink.add(code);
    _locdesController.sink.add(description);
  }
 
  setPaymentDtls(String code,String description)
  {
   
    _payTypeController.sink.add(code);
    _paydesController.sink.add(description);
  }

  //   setSalesEntry(String orderNum)
  // {
  //   _seCustCodeController.sink.add(orderNum);   
  // }
  
    fetchSalesEntry(String orderNum) async
    {
      if(orderNum == "" || orderNum == null) {clearSalesEntry();}
    else
    {
      SalesEntryApi poApi = new SalesEntryApi();
      SalesEntryHd salEnyHD = await poApi.getSalesEntry(StaticsVar.branchID, orderNum);
      if(salEnyHD != null)
      {
        _seCustNoController.sink.add(salEnyHD.orderNo);
        _seCustCodeController.sink.add(salEnyHD.customerCode);
        _seCustAddressController.sink.add(getCustomerAddress(salEnyHD.customerCode.trim()));
        _seSalesDateController.sink.add(salEnyHD.orderDate);
        _seDelvDateController.sink.add(salEnyHD.deliveryDate);
        _sePaymentTypeController.sink.add(salEnyHD.paymentType);
        _seRemarksController.sink.add(salEnyHD.remarks);
        _seVatController.sink.add(salEnyHD.isVat);
        _seWHTaxController.sink.add(salEnyHD.isWhTax);
        _sePaidAmntController.sink.add(salEnyHD.paidAmount.toString());
        // _seQtyController.inkadd(salEnyHD.customerCode);
        // _seUOMController.snkadd(salEnyHD.customerCode);
        // _seProdCodeControle.sink.add(salEnyHD.customerCode.);
        // _seDiscountTypeController.sink.add(salEnyHD.customerCode.);
        // _seDiscountController.sink.add(salEnyHD.customerCode.);
        // _seHeaderController.sink.add(salEnyHD.customerCode.);
        // _seDetailsController.sink.add(salEnyHD.customerCode.);


          if(salEnyHD.orderDetails != null)
          { print('SE DETAILS : ' +  salEnyHD.orderDetails.length.toString());
            _seDetailsController.sink.add(salEnyHD.orderDetails);}
  
      }
    } 
  }

   display4EditSalesEntryDtls(String orderNum)
  {
    if(orderNum == "" || orderNum == null){clearDisplay4SE();}
    {
    //List<QuotationItems> listQuotItems = [];
    for (SalesEntryDetails salEntyDtls in _seDetailsController.value)
      { if(salEntyDtls.productCode == orderNum) 
        {
          _seQtyController.sink.add(salEntyDtls.quantity.toString());
          // _seUOMController.sink.add(salEntyDtls.uom);
          _seProdCodeController.sink.add(salEntyDtls.productCode.toString());
          _seSellRateController.sink.add(salEntyDtls.sellRate.toString());
          _seDiscountTypeController.sink.add(salEntyDtls.discountType);
          _seDiscountController.sink.add(salEntyDtls.discountAmount.toString());       
        }
      }
    } 
  }

  clearSalesEntry()
  {
    _seCustAddressController.sink.add(null);
    _seCustAddressController.sink.add(null);
    _seCustNoController.sink.add(null);
    _seCustCodeController.sink.add(null);
    _seSalesDateController.sink.add(DateTime.now());
    _seDelvDateController.sink.add(null);
    _sePaymentTypeController.sink.add(null);
    _seRemarksController.sink.add(null);
    _seVatController.sink.add(false);
    _seWHTaxController.sink.add(false);
    _sePaidAmntController.sink.add("0.0");
    _seDetailsController.sink.add(null);
  }

  clearDisplay4SE()
  {
   // print('Clearing PoPup screen for SE....');
    _seQtyController.sink.add(null);
    _seProdCodeController.sink.add(null);
    _seUOMController.sink.add(null);
    _seSellRateController.sink.add(null);
    _seDiscountTypeController.sink.add('NONE');
    _seDiscountController.sink.add(null);
  }



  // setProducttDtls(String product,String catgCode)
  // {
  //   _productdesController.sink.add(product == "" ? "" : product);
  //   _proCatergoryDDController.sink.add(catgCode == "" ? null : catgCode);
  // }
  
  fetchProdutDtls(String prodCode) async
  {
    if(prodCode == "" || prodCode == null) {clearProductDtls();}
    else
    {
      ProductApiProvider productApi = new ProductApiProvider();
      Product products = await productApi.getProduct(prodCode);
      if(products != null)
      {
        _productCodemasterController.sink.add(products.productCode);
        _productdesController.sink.add(products.description.trim());
        _proBarCodeController.sink.add(products.barCode.trim());
        _procatUomDrodwnController.sink.add(products.uom.trim());
        _proColorController.sink.add(products.color.trim());
        _reOrderqtyController .sink.add(products.reOrderQty.toString());
        _proCatergoryDDController.sink.add(products.productCategory.trim());
        _sizeController.sink.add(products.size.trim());  
        _whLocDDController.sink.add(products.location.trim());
        _whLocDDController.sink.add(products.location == "" ? null : products.location);
      }
    }
  }

  setSupplierDtls(String supCode,)
  {
    _supplierCodeController.sink.add(supCode);
  }

  // fetchCustomer(String cusCode,String cusName,String regNo)
  // {   
  //   _cusCodesController.sink.add(cusCode);
  //   _cusNameController.sink.add(cusName);
  //   _cusRegController.sink.add(regNo);

  // }

  fetchCustomer(String cusCode) async 
  {  
    if(cusCode == null || cusCode == "") {clearCustomer();}
    else
    {
      CustomerApiProvider cusApi = new CustomerApiProvider();

      Customer cusMod = await cusApi.getCustomer(cusCode);
      if(cusMod != null)
      {
        _cusCodesController.sink.add(cusMod.customerCode);
        _cusNameController .sink.add(cusMod.customerName);
        _cusRegController .sink.add(cusMod.registrationNo);
        _creditTermController.sink.add(cusMod.creditTerm.toString());
        if(cusMod.customerAddress != null)
        {
          _custaddress1Controller.sink.add(cusMod.customerAddress.address1);
          _custaddress2Controller.sink.add(cusMod.customerAddress.address2);
          _custcityNameController.sink.add(cusMod.customerAddress.city);
          _custstateNameController.sink.add(cusMod.customerAddress.state);
          _custzipCodeController.sink.add(cusMod.customerAddress.zipcode);
          _custphoneNumController.sink.add(cusMod.customerAddress.phonenum);
          _custfaxNumController.sink.add(cusMod.customerAddress.fax);
          _custemailAddController.sink.add(cusMod.customerAddress.email);
          _custcountriesController.sink.add(cusMod.customerAddress.countryCode == "" ? null : cusMod.customerAddress.countryCode);
        // _customerListController.sink.add(cusMod.customerCode); 
        }    
      } 
    }   
  }

  clearCustomer()
  {
    _cusCodesController.sink.add(null);
    _cusNameController .sink.add(null);
    _cusRegController .sink.add(null);
    _creditTermController.sink.add(null);
    _custaddress1Controller.sink.add(null);
    _custaddress2Controller.sink.add(null);
    _custcityNameController.sink.add(null);
    _custstateNameController.sink.add(null);
    _custzipCodeController.sink.add(null);
    _custphoneNumController.sink.add(null);
    _custfaxNumController.sink.add(null);
    _custemailAddController.sink.add(null);
    _custcountriesController.sink.add(null);
    _customerListController.sink.add(null);     
  }
  
  fetchSupplier(String supCode) async
  {
    if(supCode == null || supCode == "") {clearSupplier();}
    else
    {
      SupplierApiProvider supApi = new SupplierApiProvider();
      Supplier supMod = await supApi.getSupplier(supCode);
      //SupplierAddress suppAddrs = await supApi.getSupplier(supCode);
      if(supMod != null)
      {
        _supplierCodeController.sink.add(supMod.customerCode);
        _supplierNameController.sink.add(supMod.customerName);
        _supplierRegController.sink.add(supMod.registrationNo);
        _supplierTypeController.sink.add(supMod.customerType);
        _contactPersonController.sink.add(supMod.contactPerson);
        if(supMod.supplierAddress != null)
        {
          _address1Controller.sink.add(supMod.supplierAddress.address1);
          _address2Controller.sink.add(supMod.supplierAddress.address2);
          _cityNameController.sink.add(supMod.supplierAddress.city);
          _stateNameController.sink.add(supMod.supplierAddress.state);
          _countriesController.sink.add(supMod.supplierAddress.countryCode);
          _zipCodeController.sink.add(supMod.supplierAddress.zipcode);
          _phoneNumController.sink.add(supMod.supplierAddress.phonenum);
          _faxNumController.sink.add(supMod.supplierAddress.fax);
          _emailAddController.sink.add(supMod.supplierAddress.email);
        }
      }
    }
  }

  clearSupplier()
  {
    _supplierCodeController.sink.add(null);
    _supplierNameController.sink.add(null);
    _supplierRegController.sink.add(null);
    _supplierTypeController.sink.add(null);
    _contactPersonController.sink.add(null);
    _address1Controller.sink.add(null);
    _address2Controller.sink.add(null);
    _cityNameController.sink.add(null);
    _stateNameController.sink.add(null);
    _countriesController.sink.add(null);
    _zipCodeController.sink.add(null);
    _phoneNumController.sink.add(null);
    _faxNumController.sink.add(null);
    _emailAddController.sink.add(null);
  }

  fetchPromotion(String prodNo) async
  {
    if(prodNo == null || prodNo == ""){clearPromotions();}
    else
    {
      PromotionApiProvider proApi = new PromotionApiProvider();
      PromotionMod promMod = await proApi.getPromotion(StaticsVar.branchID,prodNo);
      if(promMod != null)
      {
        _proCodeDDController.sink.add(promMod.productCode);
        _effectiveDateController.sink.add(promMod.effectiveDate);
        _expiryDateController.sink.add(promMod.expiryDate);
        _promTypeController.sink.add(promMod.promotionType);
        
        if(promMod.promotionType == 'DISCOUNT')
        { 
          _discountTypeDController.sink.add(promMod.discountType);
          _amountController.sink.add(promMod.discountAmount.toString());
        }
        else 
        {
          _prodCodesDDController.sink.add(promMod.promoProduct);
          _qtyController.sink.add(promMod.qty.toString());
        }  

        // print('//**************************** THE PROMO ITEMS START HERE **************************//');
        // print('Promo type : ' + promMod.promotionType);
        // print('Disc Type : ' + promMod.discountType);
        // print('Disc amt : ' + promMod.discountAmount.toString());

        // // // print('Quot Items Length: ' + promMod.quotationItems.length.toString());


        // print('Stream Promot type:' + _promTypeController.value);
        // print('Disc Type :' + _discountTypeDController.value.toString());
        // print('Disc amt :' + _amountController.value.toString());
        // // print('Stream Items Length: ' + _quotationItemsController.value.length.toString());
      }
    }
  }
 
  clearPromotions()
  {
    _proCodeDDController.sink.add(null);
    _effectiveDateController.sink.add(null);
    _expiryDateController.sink.add(null);
    _promTypeController.sink.add(null);
    _discountTypeDController.sink.add(null);
    _amountController.sink.add(null);
    _prodCodesDDController.sink.add(null);
    _qtyController.sink.add(null);
  }

  setPromotionDtls(DateTime effecDate,DateTime exprDate)
  {
    // _proCodeDDController.sink.add(prodName);
    _effectiveDateController.sink.add(effecDate);
    _expiryDateController.add(exprDate);
  }
  
  //Master data popup edits UOM lookups Ends

  //Add PODETAILS
  addPODetails()
  {
    List<PurchaseOrderDetails> listPODtls = [];
    bool isNew = true;

    if(_poDetailsController.value != null)
      { listPODtls.addAll(_poDetailsController.value); }

      for(PurchaseOrderDetails item in listPODtls)
      { if(item.productCode.trim() == _poProdCodeDDpopupController.value.trim())
        { isNew = false;
          item.quantity = double.parse(_poQuantitypopupController.value);
          item.unitPrice = double.parse( _unitPricePopupController.value);
          item.currencyCode= _poCurrencyPopupController.value.trim();
          item.productDescription = getProductName(_poProdCodeDDpopupController.value.trim());
          item.modifiedBy="admin";
          item.modifiedOn= DateTime.now();
    } }
    if(isNew)
    {
      PurchaseOrderDetails poDtls = new PurchaseOrderDetails();
      poDtls.productCode = _poProdCodeDDpopupController.value;
      poDtls.uom = _poUOMunitDDController.value;
      poDtls.quantity = double.parse(_poQuantitypopupController.value);
      poDtls.currencyCode = _poCurrencyPopupController.value;
      poDtls.productDescription = getProductName(_poProdCodeDDpopupController.value.trim());
      poDtls.unitPrice = double.parse( _unitPricePopupController.value);
      poDtls.status = true;
      listPODtls.add(poDtls);
      _poDetailsController.sink.add(listPODtls);
      // _poDetailsController.stream.listen((onData) => {});
      // print("Added Item success - " + _poProdCodeDDpopupController.value);
      // print("Added Item length - " + listPODtls.length.toString());
      // _poDetailsController.sink..add(listPODtls);
      // print("Stream Item length - " + _poDetailsController.value.length.toString());
      // _poDetailsController.stream.listen((onData) => {});
    }
}
  //  addQuotationItems()
  // {
  //   List<QuotationItems> listQuotItems = [];
  //   bool isNew = true;

  //   if(_quotationItemsController.hasValue)
  //   { listQuotItems.addAll(_quotationItemsController.value); 

  //     for(QuotationItems item in listQuotItems)
  //     { if(item.productCode.trim() == _qCusProdCodePUController.value.trim())
  //       { isNew = false;
  //         item.sellRate = double.parse(_qCusSellratePUController.value);
  //         item.currencyCode= _qCusPaymentPUController.value.trim();
  //         item.modifiedBy="admin";
  //         item.modifiedOn= DateTime.now();
  //   } } }

  //   if(isNew)
  //   {
  //     QuotationItems qoItems = new QuotationItems();
  //     qoItems.itemId = 1;
  //     qoItems.quotationNo = "";
  //     qoItems.productCode=_qCusProdCodePUController.value;
  //     //if(_qProdDescriptionController.value != null ) {qoItems.productDescription= _qProdDescriptionController.value;}
  //     qoItems.barCode="";
  //     qoItems.sellRate = double.parse(_qCusSellratePUController.value);
  //     qoItems.currencyCode= _qCusPaymentPUController.value.trim();
  //     qoItems.status= true;
  //     qoItems.createdBy="admin";
  //     qoItems.createdOn= DateTime.now();
  //     qoItems.modifiedBy="admin";
  //     qoItems.modifiedOn= DateTime.now();
  //     qoItems.recordStatus= 1;

  //     listQuotItems.add(qoItems);
  //   }

  //   print("Added Item success - " + _qCusProdCodePUController.value);
  //   print("Added Item length - " + listQuotItems.length.toString());
    
  //   _quotationItemsController.sink..add(listQuotItems);
  //    print("Stream Item length - " + _quotationItemsController.value.length.toString());
  //   //_quotationItemsController.stream.listen((onData) => {});
  // }




  deletePODetail(String poProdCode)
  {
    List<PurchaseOrderDetails> listPODtls = [];
  
    for (PurchaseOrderDetails poDt in _poDetailsController.value)
    {
      if(poDt.productCode.trim() == poProdCode.trim() || !poDt.status)
      {poDt.status = false;} 
      else {poDt.status = true;}
      listPODtls.add(poDt);
    }
    _poDetailsController.sink.add(listPODtls);
    _poDetailsController.stream.listen((onData) => {});    
  }

  getPurchaseOrder(String poNum)
  {
    PurchaseOrderHD poHD = new PurchaseOrderHD();
    poHD.poNo= poNum;
    poHD.poDate= _poDateController.value;
    poHD.branchId= StaticsVar.branchID;
    poHD.supplierCode = _poSuppCodeController.value;
    poHD.supplierName= _suppNameController.value;
    poHD.shipmentDate= _shipingDateController.value;
    poHD.receiveDate = null;
    poHD.estimateDate= _estimateDateController.value;
    poHD.referenceNo= _referenceNumController.value;
    poHD.buyer= "";
    poHD.prNo= _prNumController.value;
    poHD.incoTerms= "";
    poHD.paymentTerm= _paymentController.value;
    poHD.paymentTermDescription= "" ;
    poHD.poStatus= true;
    // poHD.totalAmount= _getPOTotAmount();
    poHD.totalAmount=  getPOSummaryAmt('TOTAL');
    poHD.otherCharges= getPOSummaryAmt('OTHER');
    poHD.isVat= _poVATController.value;
    poHD.vatAmount= getPOSummaryAmt('VAT');
    poHD.netAmount=getPOSummaryAmt('NET');
    poHD.isCancel= false;
    poHD.remarks= _remarksController.value;
    poHD.contactPerson= _poContactPerController.value;
    poHD.createdBy='admin';
    poHD.createdOn= DateTime.now();
    poHD.modifiedBy= "admin";
    poHD.modifiedOn= DateTime.now();
    poHD.purchaseOrderDetails = _poDetailsController.value;
    return poHD;
  }

  poVatchecked()
  {
    _poVATController.stream.listen((onSelect){_poDetailsController.sink.add(_poDetailsController.value);});
    _poOtherChargesController.stream.listen((ondata){_poDetailsController.sink.add(_poDetailsController.value);});  
  }

  Users getLoginUser()
  {
    //  Users user = Users( userID: _emailController.value,
    //     password: _passwordController.value,);

    Users user = new Users();

    user.userID = _emailController.value;
    user.password = _passwordController.value;

    return user;
  }

  ProductCategorys saveProdCatDtls()
  { 
    ProductCategorys proCatDts = ProductCategorys(
            categoryCode: _prodCatCodeController.value,
            description:  _prodCatdescripController.value,
              );
              proCatDts.createdBy = "admin";
              proCatDts.modifiedBy = "admin";
              proCatDts.isInternalStock = false;
            return proCatDts;
  }
  
  void clearProdCatDtls()
  { 
    _prodCatCodeController.sink.add(null);
    _prodCatdescripController.sink.add(null);
  }

  Lookup saveLookUpDtls(String catgory)
  {
    Lookup uomSavDtls = Lookup(

    lookupCode: _lookUpCodeController.value,
    description: _lookUpDesController.value,
    category: catgory,
    description2: "",
    status: true,
    );
    return uomSavDtls;
  }

  Product saveProductDtls(String productcode)
  {
    Product productSavDtls = Product(
      productCode: productcode,   
      description: _productdesController.value,
      barCode: _proBarCodeController.value,
      uom: _procatUomDrodwnController.value,
      color: _proColorController.value,
      reOrderQty: double.parse(_reOrderqtyController.value),
      productCategory: _proCatergoryDDController.value,
      size: _sizeController.value,
      location: _whLocDDController.value,
      status: true
      );

    productSavDtls.createdBy = "admin";
    productSavDtls.modifiedBy = "admin";

   return productSavDtls;
  }
  
  clearProductDtls()
  {
    _productCodemasterController.sink.add(null);
    _productdesController.sink.add(null);
    _proBarCodeController.sink.add(null);
    _procatUomDrodwnController.sink.add(null);
    _proColorController.sink.add(null);
    _reOrderqtyController.sink.add(null);
    _proCatergoryDDController.sink.add(null);
    _sizeController.sink.add(null);
    _whLocDDController.sink.add(null);
  }

  // inauiry Save
  Supplier saveSupplierInquiry()
  {
    Supplier productSavDtls =   Supplier(

      customerCode:_suppliercatInqDDController.value

      );

    productSavDtls.createdBy = "admin";
    productSavDtls.modifiedBy = "admin";

   return productSavDtls;
  }

    ProductCategorys saveProdCatInquiry()
  {
    ProductCategorys productSavDtls =   ProductCategorys(

      categoryCode:_catInqDDController.value

      );

    productSavDtls.createdBy = "admin";
    productSavDtls.modifiedBy = "admin";

   return productSavDtls;
  }

Product saveCatInquryDD()
   {
    Product productSavDtls =   Product(

      productCode:_catInqDDController.value

      );

    productSavDtls.createdBy = "admin";
    productSavDtls.modifiedBy = "admin";

   return productSavDtls;
  }

  BranchModel saveBranchInquryDD()
   {
    BranchModel productSavDtls =   BranchModel(

      branchCode:_branchInqDDController.value
      );

    productSavDtls.createdBy = "admin";
    productSavDtls.modifiedBy = "admin";

   return productSavDtls;
  }

  StockInquiry saveInqdtls()
  {

     StockInquiry inqSaveDts =   StockInquiry(

      productDescription:_branchInqDDController.value,
      productCategory: _proBarCodeController.value,
      size: _proCatergoryDDController.value
      
      );

    // productSavDtls.createdBy = "admin";
    // productSavDtls.modifiedBy = "admin";

   return inqSaveDts;

  }

  // SAVE promotions
  
  PromotionMod savePromoDtls(String promoID)
  {
    PromotionMod inqSaveDts = new PromotionMod();
    inqSaveDts.promotionID = promoID;
    inqSaveDts.productCode= _proCodeDDController.value;
  //  inqSaveDts.effectiveDate= _effectiveDateController.value.toString();
    inqSaveDts.effectiveDate= _effectiveDateController.value;
  //  inqSaveDts.expiryDate= _expiryDateController.value.toString();
    inqSaveDts.expiryDate= _expiryDateController.value;
    inqSaveDts.promotionType= _promTypeController.value;

    if(_promTypeController.value == 'DISCOUNT')
    {
    inqSaveDts.discountType=_discountTypeDController.value == null ? "" : _discountTypeDController.value;
    inqSaveDts.discountAmount= _amountController.value == null ? 0 : double.parse(_amountController.value);
    } 
    else
    {
    inqSaveDts.promoProduct= (_prodCodesDDController.value == null) ? "" : _prodCodesDDController.value;
    inqSaveDts.qty = _qtyController.value == null ? 0 : int.parse(_qtyController.value);
    }
    // savePromoDtls.createdBy = "admin";
  // savePromoDtls.modifiedBy = "admin";
    inqSaveDts.branchID = StaticsVar.branchID;
    inqSaveDts.status = true;
    return inqSaveDts;
    
  }
  




  // Lookup deleteLookUpList()
  // {
  //   Lookup lookupDelt = Lookup(
  //     lookupCode= 
      
    
  //   );
  //   return lookupDelt;
  // }

  Currency saveCurrencyDtls()
  {
    Currency currDtls = Currency(
      currencyCode: _currCodeController.value,
      description: _currDesController.value,
      description1: _currDes1Controller.value,
      );
    return currDtls;
  }

  clearCurrencyDetails()
  {
    _currCodeController.sink.add(null);
    _currDesController.sink.add(null);
    _currDes1Controller.sink.add(null)    ;
  }
  

  Customer saveCustomerDtls()
  {
    CustomerAddress saveCustAdd = new CustomerAddress();

    saveCustAdd.address1= _custaddress1Controller.value;
    saveCustAdd.address2= _custaddress2Controller.value;
    saveCustAdd.city= _custcityNameController.value;
    saveCustAdd.state= _custstateNameController.value;
    saveCustAdd.zipcode= _custzipCodeController.value;
    saveCustAdd.countryCode = _custcountriesController.value;
    saveCustAdd.phonenum= _custphoneNumController.value;
    saveCustAdd.fax= _custfaxNumController.value;
    saveCustAdd.email=_custemailAddController.value;
    saveCustAdd.addressType = "CUSTOMER";
          
    Customer saveCustDtls = Customer(
      // customerCode: _cusCodesController.value,                      
      customerName: _cusNameController.value,
      registrationNo: _cusRegController.value,
      creditTerm: int.parse(_creditTermController.value.toString()),
      status: true,
      customerAddress: saveCustAdd,
      customerType: "CUSTOMER",
      customerMode: "CUSTOMER",
      createdBy: "admin",
      modifiedBy: "admin",
    
    );
      return saveCustDtls;
  }

  
  Supplier saveSupplierDtls()
  {
    SupplierAddress saveSuppAdd = new SupplierAddress();
    saveSuppAdd.address1= _address1Controller.value;
    saveSuppAdd.address2= _address2Controller.value;
    saveSuppAdd.city= _cityNameController.value;
    saveSuppAdd.state= _stateNameController.value;
    saveSuppAdd.zipcode= _zipCodeController.value;
    saveSuppAdd.countryCode = _countriesController.value;
    saveSuppAdd.phonenum= _phoneNumController.value;
    saveSuppAdd.fax= _faxNumController.value;
    saveSuppAdd.email=_emailAddController.value;
    saveSuppAdd.addressType = "SUPPLIER";
    
    CountryList counName = new CountryList();
    counName.countryName= _countriesController.value;

    Supplier savsuppDtls = Supplier(
      customerName: _supplierNameController.value,
      registrationNo: _supplierRegController.value,
      customerType: _supplierTypeController.value,
      contactPerson: _contactPersonController.value,
      supplierAddress: saveSuppAdd,
      status: true,
      // countryList: _countriesController.value,
      // customerCode: "admin",
      customerMode: "SUPPLIER",
      createdBy: "admin",
      modifiedBy: "admin",
    );
      return savsuppDtls;
  }

  void dispose()
  {
    // Search Options
    _searchTxtFldController.close();
    _searchOptionDDController.close();

  // Login Screen
  _emailController?.close();
  _passwordController?.close();
  _showPasswordController.close();
      // _stSuppController.close();
  
  //Product List
  _initUOMController.close();
  _initIncoTermController.close();
  _initLocationController.close();
  _initPaymentTypeController.close();
  _initCurrencyController.close();
  _initProdCategoryController.close();
  _initProductsController.close();
  _initCustomersController.close();
  _initSuppliersController.close();
  _initCountriesController.close();
  //ProductCategoryPopupscreen
  _prodCatCodeController.close();
  _prodCatdescripController.close();

  //LocationPopUppage
  _locCodeController.close();
  _locdesController.close();
  
  // UOM popup page
  _lookUpCodeController.close();
  _lookUpDesController.close();
  
  // Currency popup page
  _currCodeController.close();
  _currDesController.close();
  _currDes1Controller.close();
  
  // IncoTerms popup page
  _incoCodeController.close();
  _incoDesController.close();
  
  // IncoTerms popup page
  _payTypeController.close();
  _paydesController.close();
  
  // product popup page
  _productCodemasterController.close();
  _proBarCodeController.close();
  _productdesController.cast(); 
  _procatUomDrodwnController.close();
  _proColorController.close();
  _reOrderqtyController.close();
  _sizeController.close();
  _proCatergoryDDController.close();
  _whLocDDController.close();
  // promotion popup
  _proCodeDDController.close();
  _effectiveDateController.close();
  _expiryDateController.close();
  _discountTypeDController.close();
  _amountController.close();
  _prodCodesDDController.close();
  _qtyController.close();
  _promTypeController.close();

  // inquery list
  _branchInqDDController.close();
  _catInqDDController.close();
  _suppliercatInqDDController.close();
  _productInqDDController.close();
  _inquiryDtlsController.close();
  _stockInqDtlsController.close();
  _inqInvCusmrController.close();
  _inqInvDateFromController.close();
  _inqInvDateToController.close();
  _inqInvPaymentTypController.close();



  //add supplier Detail poppup
    _supplierCodeController.close();
    _supplierNameController.close();
    _supplierRegController.close();
    _supplierTypeController.close();
    _contactPersonController.close();
    _address1Controller.close();
    _address2Controller.close();
    _cityNameController.close();
    _stateNameController.close();
    _zipCodeController.close();
    _phoneNumController.close();
    _faxNumController.close();
    _emailAddController.close();
    _countriesController.close();

    //add Customer Detail popup
    _cusNameController.close();
    _cusRegController.close();
    _creditTermController.close();
    _custaddress1Controller.close();
    _custaddress2Controller.close();
    _custcityNameController.close();
    _custcountriesController.close();
    _custemailAddController.close();
    _custfaxNumController.close();
    _custstateNameController.close();
    _custzipCodeController.close();
    _custphoneNumController.close();
    _cusCodesController.close();
    _customerListController.close();

// Purchase order

    _poTotalAmountController.close();
    _poOtherChargesController.close();
    _poVATController.close();
    _poNetAmtController.close();    
    _poSuppCodeController.close();
    _poNumberController.close();
    _poDateController.close();
    _suppNameController.close();
    _poContactPerController.close();
    _adressController.close();
    _shipingDateController.close();
    _estimateDateController.close();
    _referenceNumController.close();
    _paymentController.close();
    _prNumController.close();
    _remarksController.close();
    _poItemsController.close();

// purchase order product popup
  _poProdCodeDDpopupController.close();
  _poUOMunitDDController.close();
  _poQuantitypopupController.close();
   _poCurrencyPopupController.close();
   _unitPricePopupController.close();
   _poDetailsController.close();
  // Quotation bloc close
   _qSQuotNoController.close();
   _qSEffecDateController.close();
   _qSExprDateController.close();
  
   _qSProCodDropDwnController.close();
   _qSellRateController.close();
   _qSPaymentController.close();

   _qCusNoController.close();
   _qCusCCodeController.close();
   _qCusEffecDateController.close();
   _qCusExprDateController.close();
   _qCusProdCodePUController.close();
   _qCusSellratePUController.close();
   _qCusPaymentPUController.close();
   _qCustEffDateCtrl.close();
   _qCustomerQuotListCtrl.close();

   _qSupDropDwnController.close();
   _qSupEffecDateController.close();
   _qSupExprDateController.close();

   _qSupDropDwnPUController.close();
   _qSupSellratePUController.close();
   _qSupCurrentyDDController.close();
   _qProdDescriptionController.close();
   _quotationItemsController.close();

    // Good recieve
   _gRPOnoController.close();
   _gRProdRectNOController.close();
   _gRDateController.close();
   _gRVendorController.close();
   _gRReceivedQtyController.close();
   _gRHeaderController.close();
   _gRItemsController.close();

  // Sales entry Bloc
   _seCustNoController.close();
   _seCustCodeController.close();
   _seCustAddressController.close();
   _seSalesDateController.close();
   _seDelvDateController.close();
   _sePaymentTypeController.close();
   _seRemarksController.close();
   _seQtyController.close();
   _seUOMController.close();
   _seProdCodeController.close();
   _seDiscountTypeController.close();
   _seSellRateController.close();
   _seDiscountController.close();
   _seHeaderController.close();
   _seDetailsController.close();    
   _sePaidAmntController.close();
   _seVatController.close();
   _seWHTaxController.close();
   
  //dashBoard
    _dbIndexController.close();
    _dbTotalSalesController.close();
    _dashBoardController.close();
  // billing  
   _cusInvAmtController.close();
   _cusDisAmtController.close();
   _cusVATController.close();
   _cusWHTaxController.close();
   _cusTotAmtController.close();
   _cusPaidAmtController.close();
   _cusBalAmtController.close();
   _invAprCustomerController.close();
   _cusInvAddressController.close();
   _invApDateFromController.close();
   _invApDateToController.close();
   _invApprvdPaymentController.close();
   _isInvSelectedController.close();
   _unBilldCustomerController.close();
   _unBilldDateFormController.close();
   _unBilldDateToController.close();
   _unBilldPaymentController.close();
   _unApprvdInvController.close();
   _unBilledInvController.close();
  //  invoice customer details

   _cusInvCusName.close();
   _cusInvCusDate.close();
   _invNoController.close();
   _orderNoController.close();
   _itemNoController.close();
   _prodCodController.close();
   _prdDesController.close();
   _quontityController.close();
   _priceController.close();
   _cusinvDtlsController.close();
  }
}