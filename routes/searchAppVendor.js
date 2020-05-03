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
    Title:'AppVendorSearch',
    Heading:'AppVendor',
    VendorId:{label :'VendorId'},
    VendorNo:{label :'VendorNo'},
    VendorName:{label :'VendorName'},
    VendorType:{label :'VendorType'},
    VendorClassification:{label :'VendorClassification'},
    VendorCategory:{label :'VendorCategory'},
    ContactPerson:{label :'ContactPerson'},
    ContactPosition:{label :'ContactPosition'},
    ContactPersonMobilePhone:{label :'ContactPersonMobilePhone'},
    ContactPersonEmail:{label :'ContactPersonEmail'},
    VendorTaxId:{label :'VendorTaxId'},
    VendorCreditLimit:{label :'VendorCreditLimit'},
    VendorPhone1:{label :'VendorPhone1'},
    VendorPhone2:{label :'VendorPhone2'},
    VendorFax:{label :'VendorFax'},
    VendorEmailCompany:{label :'VendorEmailCompany'},
    VendorWebsite:{label :'VendorWebsite'},
    VendorCurrency:{label :'VendorCurrency'},
    VendorAddress1:{label :'VendorAddress1'},
    VendorAddress2:{label :'VendorAddress2'},
    VendorPostalCode:{label :'VendorPostalCode'},
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
    AppVendor:{Heading:'AppVendor',
        VendorId:{header:'VendorId'},
        VendorNo:{header:'VendorNo'},
        VendorName:{header:'VendorName'},
        VendorType:{header:'VendorType'},
        VendorClassification:{header:'VendorClassification'},
        VendorCategory:{header:'VendorCategory'},
        ContactPerson:{header:'ContactPerson'},
        ContactPosition:{header:'ContactPosition'},
        ContactPersonMobilePhone:{header:'ContactPersonMobilePhone'},
        ContactPersonEmail:{header:'ContactPersonEmail'},
        VendorTaxId:{header:'VendorTaxId'},
        VendorCreditLimit:{header:'VendorCreditLimit'},
        VendorPhone1:{header:'VendorPhone1'},
        VendorPhone2:{header:'VendorPhone2'},
        VendorFax:{header:'VendorFax'},
        VendorEmailCompany:{header:'VendorEmailCompany'},
        VendorWebsite:{header:'VendorWebsite'},
        VendorCurrency:{header:'VendorCurrency'},
        VendorAddress1:{header:'VendorAddress1'},
        VendorAddress2:{header:'VendorAddress2'},
        VendorPostalCode:{header:'VendorPostalCode'},
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
    req.session.previouspath = 'searchAppVendor?'+req._parsedUrl.query;
    dao.searchAppVendor(jsonObj,function(err,rows) {
        parameter = {
            session: req.session,
            cookies: req.cookies,
            resource: appresource,
            dateFormat: dateFormat,
            records: rows,
        }
        res.render('AppVendorSearchPage',parameter);
        console.log(parameter);        
    })
});

module.exports = router;