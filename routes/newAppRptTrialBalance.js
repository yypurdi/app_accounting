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
    Title:'AppRptTrialBalanceNew',
    Heading:'AppRptTrialBalance',
    RptTrialBalanceId:{label :'RptTrialBalanceId'},
    RptTrialBalanceName:{label :'RptTrialBalanceName'},
    DepartmentFrom:{label :'DepartmentFrom'},
    DepartmentTo:{label :'DepartmentTo'},
    CurrencyId:{label :'CurrencyId'},
    AccountNo:{label :'AccountNo'},
    EndingBalanceDebit:{label :'EndingBalanceDebit'},
    EndingBalanceCredit:{label :'EndingBalanceCredit'},
    DateCreated:{label :'DateCreated'},
    CreatedBy:{label :'CreatedBy'},
    }

router.get('/', sessionChecker, function(req, res, next) {
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
        statusCode:100,
        statusMessage:'',        
        record:{rptTrialBalanceId:'',
        rptTrialBalanceName:'',
        departmentFrom:'',
        departmentTo:'',
        currencyId:'',
        accountNo:'',
        endingBalanceDebit:'',
        endingBalanceCredit:'',
        dateCreated:'',
        createdBy:'',
        }
    }
    res.render('AppRptTrialBalanceNewPage',parameter);
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
    dao.newAppRptTrialBalance(jsonObj,function(err,rows) {
        if(err==null){
            parameter.statusCode = 200;
            parameter.statusMessage = 'Successfully created';
        }else{
            parameter.statusCode = err.code;
            parameter.statusMessage = err.message;
        }
        parameter.record = jsonObj;
        res.render('AppRptTrialBalanceNewPage',parameter);
        console.log(parameter);        
    });
});

module.exports = router;
