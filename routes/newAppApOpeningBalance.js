/*
 * script route generated by KOMA
 * @author : Yan Yan Purdiansah
 */    
var express = require('express');
var router = express.Router();
var dateFormat = require('dateformat');    
var database = require('./dao');
var dao = new database.Dao();    
var sessionChecker = require('./security');
var appresource = {
    Title:'AppApOpeningBalanceNew',
    Heading:'AppApOpeningBalance',
    ApOpeningBalanceId:{label :'ApOpeningBalanceId'},
    VendorId:{label :'VendorId'},
    Date:{label :'Date'},
    InvoiceNo:{label :'InvoiceNo'},
    PurchaseOrderNo:{label :'PurchaseOrderNo'},
    CurrencyId:{label :'CurrencyId'},
    PayableValue:{label :'PayableValue'},
    TermOfPaymentId:{label :'TermOfPaymentId'},
    }

router.get('/', sessionChecker, function(req, res, next) {
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
        statusCode:100,
        statusMessage:'',        
        record:{apOpeningBalanceId:'',
        vendorId:'',
        date:'',
        invoiceNo:'',
        purchaseOrderNo:'',
        currencyId:'',
        payableValue:'',
        termOfPaymentId:'',
        }
    }
    res.render('AppApOpeningBalanceNewPage',parameter);
    console.log(parameter);
});
router.post('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.body;
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
    }    
    dao.newAppApOpeningBalance(jsonObj,function(err,rows) {
        if(err==null){
            parameter.statusCode = 200;
            parameter.statusMessage = 'Successfully created';
        }else{
            parameter.statusCode = err.code;
            parameter.statusMessage = err.message;
        }
        parameter.record = jsonObj;
        res.render('AppApOpeningBalanceNewPage',parameter);
        console.log(parameter);        
    });
});

module.exports = router;