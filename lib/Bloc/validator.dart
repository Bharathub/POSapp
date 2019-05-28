import 'dart:async';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/goodsReceiveModel.dart';
import 'package:split/src/Models/incotermModel.dart';
import 'package:split/src/Models/inquiryModel.dart';
import 'package:split/src/Models/invoiceModel.dart';
import 'package:split/src/Models/lookupModel.dart';
import 'package:split/src/Models/paymentModel.dart';
import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/purchaserOrderModel.dart';
import 'package:split/src/Models/quotationModel.dart';
import 'package:split/src/Models/salesEntryModel.dart';
import 'package:split/src/Models/suppliermodel.dart';
import 'package:split/src/Models/productcategorymodel.dart';
import 'package:split/src/Models/currencyModel.dart';

  // common validators
  final validatedropDown = StreamTransformer<String,String>.fromHandlers(
  handleData: (dpvalue, sink) {
   
    if (dpvalue.isNotEmpty) 
        {
          sink.add(dpvalue);
        }
        else
        {
          sink.addError('Select Data !');
        
        }
  });
  final validateTxtFld = StreamTransformer<String,String>.fromHandlers(
      handleData: (txtFld, sink) {
        if (txtFld.isNotEmpty) 
          {
            sink.add(txtFld);
          }
          else
          {
            sink.addError('Enter data.');
          }
  });

    var validateTxtFldCreditTerm = StreamTransformer<String,String>.fromHandlers(
    handleData: (txtFld, sink) {
    if (txtFld.isNotEmpty){sink.add(txtFld);}
      else{sink.addError('Enter data.');}

  });

   var zipValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (zip,sink){
      if(zip.length >=6){
        sink.add(zip);
      }else{
        sink.addError("Zip Code is not Valid");
      }
    }
  );


   var phoneValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (phone,sink){
      if(phone.length >=10){
        sink.add(phone);
      }else{
        sink.addError("Mobile Number is not Valid");
      }
    }
  );
  var faxValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (fax,sink){
      if(fax.length >=10){
        sink.add(fax);
      }else{
        sink.addError("Fax Number is not Valid");
      }
    }
  );

  final validatecalender = StreamTransformer<String,String>.fromHandlers(
    handleData: (calendervalue, sink) {
   
    if (calendervalue.isNotEmpty) 
        {
          sink.add(calendervalue);
        }
        else
        {
          sink.addError('Select Date !');
        
          }
      });



class Validators {

  var emailValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){
      // if(email.contains('')){
        sink.add(email);
      // }else{sink.addError('Email is not valid');}
    }

  );

  var passwordlValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      // if(password.length>0){
        sink.add(password);
      // }else{sink.addError('');//Here you can mention the how many char for password
      // }
    }

  );
  
  var currencyValidators = StreamTransformer<List<Currency>, List<Currency>>.fromHandlers(
    handleData: (currencyList, sink){
      // if(uomList.length>0) 
        {sink.add(currencyList);}
      // else{sink.addError('');}
      }
  );

  var productCategorysValidators = StreamTransformer<List<ProductCategorys>, List<ProductCategorys>>.fromHandlers(
    handleData: (productCategorys, sink){
      // if(uomList.length>0) 
        {sink.add(productCategorys);}
      // else{sink.addError('');}
      }
  );

  var lookUpValidators = StreamTransformer<List<Lookup>, List<Lookup>>.fromHandlers(
    handleData: (lookUps, sink){
      // if(uomList.length>0) 
        {sink.add(lookUps);}
      // else{sink.addError('');}
      }
  );

   var paymentValidators = StreamTransformer<List<PaymentTypes>, List<PaymentTypes>>.fromHandlers(
    handleData: (payments, sink){
      // if(uomList.length>0) 
        {sink.add(payments);}
      // else{sink.addError('');}
      }
  );

  var incoTermValidators = StreamTransformer<List<Incoterm>, List<Incoterm>>.fromHandlers(
    handleData: (incoTerms, sink){
      // if(uomList.length>0) 
        {sink.add(incoTerms);}
      // else{sink.addError('');}
      }
  );

  var customerValidator = StreamTransformer<List<Customer>, List<Customer>>.fromHandlers(
      handleData: (custlist, sink){
      // if(custlist.length>0) 
        {sink.add(custlist);}
      // else{sink.addError('');}
      }
  );

    var productValidator = StreamTransformer<List<Product>, List<Product>>.fromHandlers(
      handleData: (prodlist, sink){
      // if(prodlist.length>0) 
        {sink.add(prodlist);}
      // else{sink.addError('');}
      }
  );

  //Supplier list
  var supplierValidator = StreamTransformer<List<Supplier>, List<Supplier>>.fromHandlers(
    handleData: (suppList,sink){
      // if(suppList.length>0)
      { sink.add(suppList); }
      // else { sink.addError(''); }
    }
  );

    var countryValidator = StreamTransformer<List<CountryList>, List<CountryList>>.fromHandlers(
    handleData: (countryList,sink){
      // if(countryList.length>0)
      { sink.add(countryList); }
      // else { sink.addError(''); }
    }
  );


  // Validating product category list details Screen
  final validateProductCatDtls = StreamTransformer<List<ProductCategorys>, 
  List<ProductCategorys>>.fromHandlers(
  handleData: (pCatLsDetails, sink) {
    // if (pCatLsDetails.isNotEmpty) 
      {
        sink.add(pCatLsDetails);
      }
      // else {sink.addError('Invalid ProductList. !'); }
  });

  // product category popup details
     var  categoryValidator = StreamTransformer<String,String>.fromHandlers(
          handleData: (catCode,sink){
          // if(catCode.contains('')){
          sink.add(catCode);
          // }else{sink.addError('CategoryCode Invalid');}
          });

     var descriptorValidator = StreamTransformer<String,String>.fromHandlers(
         handleData: (descriDts,sink){
        //  if(descriDts.contains('')){
         sink.add(descriDts);
        //  }else{ sink.addError('Descriptor Invalid');}
        });

   //LocationPopUppage

    var locCodePopupValidator = StreamTransformer<String,String>.fromHandlers(
        handleData: (locCatCode,sink){
        // if(locCatCode.contains('')){
        sink.add(locCatCode);
        // }else{sink.addError('Code Invalid');}
      });
   //LocationPopUppage

    var locDescPoupValidator = StreamTransformer<String,String>.fromHandlers(
        handleData: (locDescription,sink){
        // if(locDescription.contains('')){
        sink.add(locDescription);
        // }else{ sink.addError('Description Invalid');}
       });

       
  // Lookup popup page

   var lookUpCodValidator = StreamTransformer<String,String>.fromHandlers(
        handleData: (lookUpCatpop,sink){
        // if(uomCatpop.isNotEmpty){
        sink.add(lookUpCatpop);
        // }else{ sink.addError('Enter some data');}
     } );
  // Lookup popup page
 
 
  var lookUpDesValidator = StreamTransformer<String,String>.fromHandlers(
        handleData: (uomDespop,sink){
        // if(uomDespop.isNotEmpty){
        sink.add(uomDespop);
        // }else{ sink.addError('Description Invalid');}
       });      

  // Currency popup page
  var currCodeValidator = StreamTransformer<String,String>.fromHandlers(
        handleData: (currDespop,sink){
        // if(currDespop.contains('')){
        sink.add(currDespop);
        // }else{ sink.addError('Code Invalid');}
       });
  // Currency popup page
  var currDescValidator = StreamTransformer<String,String>.fromHandlers(
        handleData: (currDespop,sink){
        // if(currDespop.contains('')){
        sink.add(currDespop);
        // }else{ sink.addError('Description Invalid');}
       });
  // Currency popup page
   var currDesc1Validator = StreamTransformer<String,String>.fromHandlers(
        handleData: (currDes1pop,sink){
        // if(currDes1pop.contains('')){
        sink.add(currDes1pop);
        // }else{ sink.addError('Description Invalid');}
       });    
  // Incoterms popup page
    var incoCodeValidator = StreamTransformer<String,String>.fromHandlers(
        handleData: (incoDespop,sink){
        // if(incoDespop.contains('')){
        sink.add(incoDespop);
        // }else{ sink.addError('Code Invalid');}
       });
  // Incoterms popup page
  var incoDescValidator = StreamTransformer<String,String>.fromHandlers(
        handleData: (incoDespop,sink){
        // if(incoDespop.contains('')){
        sink.add(incoDespop);
        // }else{ sink.addError('Description Invalid');}
       });


  // Paymenttype popup page

    var payTypePopupValidator= StreamTransformer<String,String>.fromHandlers(
        handleData: (payType,sink){
        // if(payType.contains('')){
        sink.add(payType);
        // }else{ sink.addError('PaymentType Invalid');}
       });

    var payDescPoupValidator= StreamTransformer<String,String>.fromHandlers(
        handleData: (payDespop,sink){
        // if(payDespop.contains('')){
        sink.add(payDespop);
        // }else{ sink.addError('Description Invalid');}
       });


    // Product popup page
    var productDescPoupValidator= StreamTransformer<String,String>.fromHandlers(
        handleData: (prodcodespop,sink){
        //if(prodcodespop.contains('')){
        sink.add(prodcodespop);
        //}else{ sink.addError('Description cannot be empty');}
       });
           
    var productBarCodePoupValidator= StreamTransformer<String,String>.fromHandlers(
        handleData: (prodDespop,sink){
        // if(prodDespop.contains('')){
        sink.add(prodDespop);
        // }else{ sink.addError('Description Invalid');}
       });

    var proUOMDrpdwnPoupValidator= StreamTransformer<String,String>.fromHandlers(
        handleData: (prodcodmastpop,sink){
        // if(prodcodmastpop.contains('')){
        sink.add(prodcodmastpop);
        // }else{ sink.addError('ProductCatergory Invalid');}
       });

// Date&Time validateor
  var dateTimeValidator= StreamTransformer<DateTime,DateTime>.fromHandlers(
    handleData: (prodcodmastpop,sink){
      // if(prodcodmastpop.){
      sink.add(prodcodmastpop);
      // }else{ sink.addError('ProductCatergory Invalid');
      // }
    }
  );

  var proColorPoupValidator= StreamTransformer<String,String>.fromHandlers(
    handleData: (prodcodmastpop,sink){
    // if(prodcodmastpop.contains('')){
    sink.add(prodcodmastpop);
    // }else{ sink.addError('ProductCatergory Invalid');}
  });

  var proReOrderQtyPoupValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (reorderpop,sink){
    // if(reorderpop.contains('')){
    sink.add(reorderpop);
    // }else{ sink.addError('ProductCatergory Invalid');}
  });

  var proCatergoryPoupValidator= StreamTransformer<String,String>.fromHandlers(
    handleData: (prodUOMddpop,sink){
    // if(prodUOMddpop.contains('')){
    sink.add(prodUOMddpop);
    // }else{ sink.addError('ProductCatergory Invalid');}
  });

  var proSizePoupValidator= StreamTransformer<String,String>.fromHandlers(
    handleData: (prodUOMddpop,sink){
    // if(prodUOMddpop.contains('')){
    sink.add(prodUOMddpop);
    // }else{ sink.addError('ProductCatergory Invalid');}
  });

  var proWhLocationPoupValidator= StreamTransformer<String,String>.fromHandlers(
    handleData: (prodUOMddpop,sink){
    // if(prodUOMddpop.contains('')){
    sink.add(prodUOMddpop);
    // }else{ sink.addError('ProductCatergory Invalid');}
  });

        // Validating Inquiry details Screen
  final inqsaveDtlsValidators = StreamTransformer<List<InquiryModel>, List<InquiryModel>>.fromHandlers(
  handleData: (inqdtls, sink) {
    // if (inqdtls.isNotEmpty) 
      {
        sink.add(inqdtls);
      }
      // else{ sink.addError('Invalid Inquiry ');}
  });
// Purchase order HD
   var poHeaderValidators = StreamTransformer<List<PurchaseOrderDetails>, List<PurchaseOrderDetails>>.fromHandlers(
    handleData: (listViewDtls,sink){
      // if(listViewDtls.length>0)
      { sink.add(listViewDtls); }
      // else
      // { sink.addError(''); }
    }

  );

// purchase order details
    var poDtlsValidators = StreamTransformer<List<PurchaseOrderDetails>, List<PurchaseOrderDetails>>.fromHandlers(
    handleData: (listViewDtls,sink){
      // if(listViewDtls.length>0)
      { sink.add(listViewDtls); }
      // else { sink.addError(''); }
    }

  );

  // Quotation standard details
  var qoStdDtlsValidators = StreamTransformer<List<QuotationItems>, List<QuotationItems>>.fromHandlers(
      handleData: (listViewDtls,sink){
        // if(listViewDtls.length>0)
        { sink.add(listViewDtls); }
        // else
        // { sink.addError(''); }
      }
  );

  // Goods Receiver
  var gRItemsValidators = StreamTransformer<List<GoodsReceiveItems>, List<GoodsReceiveItems>>.fromHandlers(
      handleData: (goodsReceiver,sink){
        // if(goodsReceiver.length>0)
        { sink.add(goodsReceiver); }
        // else
        // { sink.addError(''); }
      }
  );

  var gRHeaderValidators = StreamTransformer<GoodsReceiverHD, GoodsReceiverHD>.fromHandlers(
      handleData: (goodsReceiver,sink){
        { sink.add(goodsReceiver); }
      }
  );
  
  // SALES ENTRY
  var seDetailsValidators = StreamTransformer<List<SalesEntryDetails>, List<SalesEntryDetails>>.fromHandlers(
    handleData: (goodsReceiver,sink){
      // if(goodsReceiver.length>0)
      { sink.add(goodsReceiver); }
      // else
      // { sink.addError(''); }
    }
  );

  var seHeaderValidators = StreamTransformer<SalesEntryHd, SalesEntryHd>.fromHandlers(
      handleData: (goodsReceiver,sink){
        { sink.add(goodsReceiver); }
      }
  );

   var unApprvdInvValidator = StreamTransformer<List<UnApprovedInvoice>, List<UnApprovedInvoice>>.fromHandlers(
    handleData: (unapprvdInv,sink)
    {
      { sink.add(unapprvdInv); }
    }
  );
  
  
}