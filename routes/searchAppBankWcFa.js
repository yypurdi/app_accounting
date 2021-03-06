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
    Title:'AppBankWcFaSearch',
    Heading:'AppBankWcFa',
    BankWcFaId:{label :'BankWcFaId'},
    BankWriteCheckId:{label :'BankWriteCheckId'},
    AccountNo:{label :'AccountNo'},
    DepartmentId:{label :'DepartmentId'},
    Amount:{label :'Amount'},
    JobOrderNo:{label :'JobOrderNo'},
    AppBankWcFa:{Heading:'AppBankWcFa',
        BankWcFaId:{header:'BankWcFaId'},
        BankWriteCheckId:{header:'BankWriteCheckId'},
        AccountNo:{header:'AccountNo'},
        DepartmentId:{header:'DepartmentId'},
        Amount:{header:'Amount'},
        JobOrderNo:{header:'JobOrderNo'},
        },
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    if(jsonObj.rowid===undefined) jsonObj.rowid = 0;
    req.session.previouspath = 'searchAppBankWcFa?'+req._parsedUrl.query;
    dao.searchAppBankWcFa(jsonObj,function(err,rows) {
        parameter = {
            session: req.session,
            cookies: req.cookies,
            resource: appresource,
            dateFormat: dateFormat,
            records: rows,
        }
        res.render('AppBankWcFaSearchPage',parameter);
        console.log(parameter);        
    })
});

module.exports = router;
