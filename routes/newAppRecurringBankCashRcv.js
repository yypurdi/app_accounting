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
    Title:'AppRecurringBankCashRcvNew',
    Heading:'AppRecurringBankCashRcv',
    RecurringBankCashReceiveId:{label :'RecurringBankCashReceiveId'},
    TransactionName:{label :'TransactionName'},
    Frequency:{label :'Frequency'},
    AccountNo:{label :'AccountNo'},
    IsPostDatedCheck:{label :'IsPostDatedCheck'},
    From:{label :'From'},
    Date:{label :'Date'},
    ReferenceNo:{label :'ReferenceNo'},
    Amount:{label :'Amount'},
    Memo:{label :'Memo'},
    }

router.get('/', sessionChecker, function(req, res, next) {
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
        statusCode:100,
        statusMessage:'',        
        record:{recurringBankCashReceiveId:'',
        transactionName:'',
        frequency:'',
        accountNo:'',
        isPostDatedCheck:'',
        from:'',
        date:'',
        referenceNo:'',
        amount:'',
        memo:'',
        }
    }
    res.render('AppRecurringBankCashRcvNewPage',parameter);
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
    dao.newAppRecurringBankCashRcv(jsonObj,function(err,rows) {
        if(err==null){
            parameter.statusCode = 200;
            parameter.statusMessage = 'Successfully created';
        }else{
            parameter.statusCode = err.code;
            parameter.statusMessage = err.message;
        }
        parameter.record = jsonObj;
        res.render('AppRecurringBankCashRcvNewPage',parameter);
        console.log(parameter);        
    });
});

module.exports = router;