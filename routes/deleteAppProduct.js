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
    Title:'AppProductDelete',
    Heading:'AppProduct',
    ProductId:{label :'ProductId'},
    ProductCode:{label :'ProductCode'},
    ProductDesc:{label :'ProductDesc'},
    BaseUnit:{label :'BaseUnit'},
    ReportUnit:{label :'ReportUnit'},
    ProductGroup1st:{label :'ProductGroup1st'},
    ProductGroup2nd:{label :'ProductGroup2nd'},
    ProductGroup3rd:{label :'ProductGroup3rd'},
    ProductGroup4th:{label :'ProductGroup4th'},
    AliasCode:{label :'AliasCode'},
    IsUseSerialNumber:{label :'IsUseSerialNumber'},
    IsUseLot:{label :'IsUseLot'},
    IsConsignment:{label :'IsConsignment'},
    IsNotActive:{label :'IsNotActive'},
    IsSeasonalProduct:{label :'IsSeasonalProduct'},
    ProductCategoryId:{label :'ProductCategoryId'},
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
    }
    dao.deleteAppProduct(jsonObj,function(err,rows) {
        if(err==null){
            parameter.statusCode = 200;
            parameter.statusMessage = 'Successfully created';
        }else{
            parameter.statusCode = err.code;
            parameter.statusMessage = err.message;
        }
        res.redirect(req.session.previouspath);
        console.log(parameter);        
    });
});

module.exports = router;
