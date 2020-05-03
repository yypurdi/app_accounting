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
    Title:'AppCustomerTermOfPaySearch',
    Heading:'AppCustomerTermOfPay',
    CustomerId:{label :'CustomerId'},
    TermOfPaymentId:{label :'TermOfPaymentId'},
    AppCustomerTermOfPay:{Heading:'AppCustomerTermOfPay',
        CustomerId:{header:'CustomerId'},
        TermOfPaymentId:{header:'TermOfPaymentId'},
        },
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    if(jsonObj.rowid===undefined) jsonObj.rowid = 0;
    req.session.previouspath = 'searchAppCustomerTermOfPay?'+req._parsedUrl.query;
    dao.searchAppCustomerTermOfPay(jsonObj,function(err,rows) {
        parameter = {
            session: req.session,
            cookies: req.cookies,
            resource: appresource,
            dateFormat: dateFormat,
            records: rows,
        }
        res.render('AppCustomerTermOfPaySearchPage',parameter);
        console.log(parameter);        
    })
});

module.exports = router;