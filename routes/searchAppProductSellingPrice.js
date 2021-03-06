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
    Title:'AppProductSellingPriceSearch',
    Heading:'AppProductSellingPrice',
    ProductPriceId:{label :'ProductPriceId'},
    ChangedDate:{label :'ChangedDate'},
    ChangedBy:{label :'ChangedBy'},
    NormalPriceEffectiveDate:{label :'NormalPriceEffectiveDate'},
    CalculationMethod:{label :'CalculationMethod'},
    AmountOfCalculationMethod:{label :'AmountOfCalculationMethod'},
    RoundUp:{label :'RoundUp'},
    SmallestUnit:{label :'SmallestUnit'},
    PricingBase:{label :'PricingBase'},
    IsIncludeTaxToSellingPrice:{label :'IsIncludeTaxToSellingPrice'},
    IsSelectedItem:{label :'IsSelectedItem'},
    CurrentSellingPrice:{label :'CurrentSellingPrice'},
    NewSellingPrice:{label :'NewSellingPrice'},
    EffectiveDateOfNewSellingPrice:{label :'EffectiveDateOfNewSellingPrice'},
    ProductId:{label :'ProductId'},
    AppProductSellingPrice:{Heading:'AppProductSellingPrice',
        ProductPriceId:{header:'ProductPriceId'},
        ChangedDate:{header:'ChangedDate'},
        ChangedBy:{header:'ChangedBy'},
        NormalPriceEffectiveDate:{header:'NormalPriceEffectiveDate'},
        CalculationMethod:{header:'CalculationMethod'},
        AmountOfCalculationMethod:{header:'AmountOfCalculationMethod'},
        RoundUp:{header:'RoundUp'},
        SmallestUnit:{header:'SmallestUnit'},
        PricingBase:{header:'PricingBase'},
        IsIncludeTaxToSellingPrice:{header:'IsIncludeTaxToSellingPrice'},
        IsSelectedItem:{header:'IsSelectedItem'},
        CurrentSellingPrice:{header:'CurrentSellingPrice'},
        NewSellingPrice:{header:'NewSellingPrice'},
        EffectiveDateOfNewSellingPrice:{header:'EffectiveDateOfNewSellingPrice'},
        ProductId:{header:'ProductId'},
        },
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    if(jsonObj.rowid===undefined) jsonObj.rowid = 0;
    req.session.previouspath = 'searchAppProductSellingPrice?'+req._parsedUrl.query;
    dao.searchAppProductSellingPrice(jsonObj,function(err,rows) {
        parameter = {
            session: req.session,
            cookies: req.cookies,
            resource: appresource,
            dateFormat: dateFormat,
            records: rows,
        }
        res.render('AppProductSellingPriceSearchPage',parameter);
        console.log(parameter);        
    })
});

module.exports = router;
