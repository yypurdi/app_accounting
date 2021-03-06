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
    Title:'AppCustomerSearch',
    Heading:'AppCustomer',
    CustomerId:{label :'CustomerId'},
    CustNo:{label :'CustNo'},
    CustName:{label :'CustName'},
    CustType:{label :'CustType'},
    CustClassification:{label :'CustClassification'},
    CustCategory:{label :'CustCategory'},
    ContactPerson:{label :'ContactPerson'},
    ContactPosition:{label :'ContactPosition'},
    ContactPersonMobilePhone:{label :'ContactPersonMobilePhone'},
    ContactPersonEmail:{label :'ContactPersonEmail'},
    CustTaxId:{label :'CustTaxId'},
    CustCreditLimit:{label :'CustCreditLimit'},
    CustPhone1:{label :'CustPhone1'},
    CustPhone2:{label :'CustPhone2'},
    CustFax:{label :'CustFax'},
    CustEmailCompany:{label :'CustEmailCompany'},
    CustWebsite:{label :'CustWebsite'},
    CustCurrency:{label :'CustCurrency'},
    CustAddress1:{label :'CustAddress1'},
    CustAddress2:{label :'CustAddress2'},
    CustPostalCode:{label :'CustPostalCode'},
    CityId:{label :'CityId'},
    ProvinceId:{label :'ProvinceId'},
    CountryId:{label :'CountryId'},
    DeliveryAddress1:{label :'DeliveryAddress1'},
    DeliveryAddress2:{label :'DeliveryAddress2'},
    DeliveryAddressPostalCode:{label :'DeliveryAddressPostalCode'},
    DeliveryAddressCity:{label :'DeliveryAddressCity'},
    DeliveryAddressProvince:{label :'DeliveryAddressProvince'},
    DeliveryAddressCountry:{label :'DeliveryAddressCountry'},
    ContactPerson2nd:{label :'ContactPerson2nd'},
    ContactPosition2nd:{label :'ContactPosition2nd'},
    ContactPersonMobilePhone2nd:{label :'ContactPersonMobilePhone2nd'},
    ContactPersonEmail2nd:{label :'ContactPersonEmail2nd'},
    ContactPerson3rd:{label :'ContactPerson3rd'},
    ContactPosition3rd:{label :'ContactPosition3rd'},
    ContactPersonMobilePhone3rd:{label :'ContactPersonMobilePhone3rd'},
    ContactPersonEmail3rd:{label :'ContactPersonEmail3rd'},
    Image:{label :'Image'},
    NotesDetails:{label :'NotesDetails'},
    Status:{label :'Status'},
    FirstContactDate:{label :'FirstContactDate'},
    AppCustomer:{Heading:'AppCustomer',
        CustomerId:{header:'CustomerId'},
        CustNo:{header:'CustNo'},
        CustName:{header:'CustName'},
        CustType:{header:'CustType'},
        CustClassification:{header:'CustClassification'},
        CustCategory:{header:'CustCategory'},
        ContactPerson:{header:'ContactPerson'},
        ContactPosition:{header:'ContactPosition'},
        ContactPersonMobilePhone:{header:'ContactPersonMobilePhone'},
        ContactPersonEmail:{header:'ContactPersonEmail'},
        CustTaxId:{header:'CustTaxId'},
        CustCreditLimit:{header:'CustCreditLimit'},
        CustPhone1:{header:'CustPhone1'},
        CustPhone2:{header:'CustPhone2'},
        CustFax:{header:'CustFax'},
        CustEmailCompany:{header:'CustEmailCompany'},
        CustWebsite:{header:'CustWebsite'},
        CustCurrency:{header:'CustCurrency'},
        CustAddress1:{header:'CustAddress1'},
        CustAddress2:{header:'CustAddress2'},
        CustPostalCode:{header:'CustPostalCode'},
        CityId:{header:'CityId'},
        ProvinceId:{header:'ProvinceId'},
        CountryId:{header:'CountryId'},
        DeliveryAddress1:{header:'DeliveryAddress1'},
        DeliveryAddress2:{header:'DeliveryAddress2'},
        DeliveryAddressPostalCode:{header:'DeliveryAddressPostalCode'},
        DeliveryAddressCity:{header:'DeliveryAddressCity'},
        DeliveryAddressProvince:{header:'DeliveryAddressProvince'},
        DeliveryAddressCountry:{header:'DeliveryAddressCountry'},
        ContactPerson2nd:{header:'ContactPerson2nd'},
        ContactPosition2nd:{header:'ContactPosition2nd'},
        ContactPersonMobilePhone2nd:{header:'ContactPersonMobilePhone2nd'},
        ContactPersonEmail2nd:{header:'ContactPersonEmail2nd'},
        ContactPerson3rd:{header:'ContactPerson3rd'},
        ContactPosition3rd:{header:'ContactPosition3rd'},
        ContactPersonMobilePhone3rd:{header:'ContactPersonMobilePhone3rd'},
        ContactPersonEmail3rd:{header:'ContactPersonEmail3rd'},
        Image:{header:'Image'},
        NotesDetails:{header:'NotesDetails'},
        Status:{header:'Status'},
        FirstContactDate:{header:'FirstContactDate'},
        },
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    if(jsonObj.rowid===undefined) jsonObj.rowid = 0;
    req.session.previouspath = 'searchAppCustomer?'+req._parsedUrl.query;
    dao.searchAppCustomer(jsonObj,function(err,rows) {
        parameter = {
            session: req.session,
            cookies: req.cookies,
            resource: appresource,
            dateFormat: dateFormat,
            records: rows,
        }
        res.render('AppCustomerSearchPage',parameter);
        console.log(parameter);        
    })
});

module.exports = router;
