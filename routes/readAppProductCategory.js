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
    Title:'AppProductCategoryRead',
    Heading:'AppProductCategory',
    ProductCategoryId:{label :'ProductCategoryId'},
    CategoryName:{label :'CategoryName'},
    Location:{label :'Location'},
    DepartmentId:{label :'DepartmentId'},
    IsInventory:{label :'IsInventory'},
    IsPurchased:{label :'IsPurchased'},
    IsSold:{label :'IsSold'},
    InventoryMethod:{label :'InventoryMethod'},
    AcctCodeCogs:{label :'AcctCodeCogs'},
    AcctCodeSales:{label :'AcctCodeSales'},
    AcctCodeSalesReturn:{label :'AcctCodeSalesReturn'},
    AcctCodeInventory:{label :'AcctCodeInventory'},
    AcctCodeConsignment:{label :'AcctCodeConsignment'},
    Image:{label :'Image'},
    AppProduct:{Heading:'AppProduct',
        ProductId:{header:'ProductId'},
        ProductCode:{header:'ProductCode'},
        ProductDesc:{header:'ProductDesc'},
        BaseUnit:{header:'BaseUnit'},
        ReportUnit:{header:'ReportUnit'},
        ProductGroup1st:{header:'ProductGroup1st'},
        ProductGroup2nd:{header:'ProductGroup2nd'},
        ProductGroup3rd:{header:'ProductGroup3rd'},
        ProductGroup4th:{header:'ProductGroup4th'},
        AliasCode:{header:'AliasCode'},
        IsUseSerialNumber:{header:'IsUseSerialNumber'},
        IsUseLot:{header:'IsUseLot'},
        IsConsignment:{header:'IsConsignment'},
        IsNotActive:{header:'IsNotActive'},
        IsSeasonalProduct:{header:'IsSeasonalProduct'},
        ProductCategoryId:{header:'ProductCategoryId'},
        },
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    jsonObj.rowid = 0;
    req.session.previouspath = 'readAppProductCategory?'+req._parsedUrl.query;
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
    }
    var readAppProductCategory = new Promise((resolve, reject) => {
        setTimeout(() => {
            dao.readAppProductCategory(jsonObj,function(err,rows) {
                if(err) res.status(err.code).end();
                else{
                    if(rows[0]===undefined) res.redirect('/searchAppProductCategory');
                    else{ 
                        jsonObj = rows[0];
                        resolve(jsonObj);
                    }
                }
            });
        },1000);
    });
    
    var appProduct = new Promise((resolve, reject) => {
        setTimeout(() => {
            dao.searchAppProduct(jsonObj,function(err,rows) {
                jsonObj.appProduct = rows;
                resolve(jsonObj);
            });
        },1000);
    });
    
    var sendResult = (results) => {
        console.log(jsonObj)
        parameter.record = jsonObj;        
        res.render('AppProductCategoryReadPage',parameter);
    }    
    Promise.all([readAppProductCategory,appProduct]).then(sendResult);
});

module.exports = router;
