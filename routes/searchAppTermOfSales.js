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
    Title:'AppTermOfSalesSearch',
    Heading:'AppTermOfSales',
    TermOfSalesId:{label :'TermOfSalesId'},
    TosCode:{label :'TosCode'},
    TosDesc:{label :'TosDesc'},
    DiscountDaysIndays:{label :'DiscountDaysIndays'},
    DueDateIndays:{label :'DueDateIndays'},
    EarlyDiscountInpercentage:{label :'EarlyDiscountInpercentage'},
    LateChargesInpercentage:{label :'LateChargesInpercentage'},
    AppTermOfSales:{Heading:'AppTermOfSales',
        TermOfSalesId:{header:'TermOfSalesId'},
        TosCode:{header:'TosCode'},
        TosDesc:{header:'TosDesc'},
        DiscountDaysIndays:{header:'DiscountDaysIndays'},
        DueDateIndays:{header:'DueDateIndays'},
        EarlyDiscountInpercentage:{header:'EarlyDiscountInpercentage'},
        LateChargesInpercentage:{header:'LateChargesInpercentage'},
        },
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    if(jsonObj.rowid===undefined) jsonObj.rowid = 0;
    req.session.previouspath = 'searchAppTermOfSales?'+req._parsedUrl.query;
    dao.searchAppTermOfSales(jsonObj,function(err,rows) {
        parameter = {
            session: req.session,
            cookies: req.cookies,
            resource: appresource,
            dateFormat: dateFormat,
            records: rows,
        }
        res.render('AppTermOfSalesSearchPage',parameter);
        console.log(parameter);        
    })
});

module.exports = router;