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
    Title:'AppPayGradeRead',
    Heading:'AppPayGrade',
    PayGradeId:{label :'PayGradeId'},
    PayGradeName:{label :'PayGradeName'},
    MinSalary:{label :'MinSalary'},
    MaxSalary:{label :'MaxSalary'},
    Currency:{label :'Currency'},
    AppEmployee:{Heading:'AppEmployee',
        EmployeeId:{header:'EmployeeId'},
        EmployeeNumber:{header:'EmployeeNumber'},
        Firstname:{header:'Firstname'},
        Middlename:{header:'Middlename'},
        Lastname:{header:'Lastname'},
        Nationality:{header:'Nationality'},
        Dob:{header:'Dob'},
        Gender:{header:'Gender'},
        MaritalStatus:{header:'MaritalStatus'},
        Ethnicity:{header:'Ethnicity'},
        KtpNumber:{header:'KtpNumber'},
        PassportNumber:{header:'PassportNumber'},
        DrivingLicenceNo:{header:'DrivingLicenceNo'},
        AddressLine1:{header:'AddressLine1'},
        AddressLine2:{header:'AddressLine2'},
        CityId:{header:'CityId'},
        CountryId:{header:'CountryId'},
        ProvinceId:{header:'ProvinceId'},
        PostalCode:{header:'PostalCode'},
        HomePhone:{header:'HomePhone'},
        MobilePhone:{header:'MobilePhone'},
        WorkEmail:{header:'WorkEmail'},
        PrivateEmail:{header:'PrivateEmail'},
        JoinedDate:{header:'JoinedDate'},
        ConfirmationDate:{header:'ConfirmationDate'},
        TerminationDate:{header:'TerminationDate'},
        SupervisorName:{header:'SupervisorName'},
        IndirectSupervisorName:{header:'IndirectSupervisorName'},
        FirstLevelApprover:{header:'FirstLevelApprover'},
        SecondLevelApprover:{header:'SecondLevelApprover'},
        ThirdLevelApprover:{header:'ThirdLevelApprover'},
        Notes:{header:'Notes'},
        DepartmentId:{header:'DepartmentId'},
        WorkStationId:{header:'WorkStationId'},
        JobTitleId:{header:'JobTitleId'},
        PayGradeId:{header:'PayGradeId'},
        EmploymentStatusId:{header:'EmploymentStatusId'},
        },
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    jsonObj.rowid = 0;
    req.session.previouspath = 'readAppPayGrade?'+req._parsedUrl.query;
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
    }
    var readAppPayGrade = new Promise((resolve, reject) => {
        setTimeout(() => {
            dao.readAppPayGrade(jsonObj,function(err,rows) {
                if(err) res.status(err.code).end();
                else{
                    if(rows[0]===undefined) res.redirect('/searchAppPayGrade');
                    else{ 
                        jsonObj = rows[0];
                        resolve(jsonObj);
                    }
                }
            });
        },1000);
    });
    
    var appEmployee = new Promise((resolve, reject) => {
        setTimeout(() => {
            dao.searchAppEmployee(jsonObj,function(err,rows) {
                jsonObj.appEmployee = rows;
                resolve(jsonObj);
            });
        },1000);
    });
    
    var sendResult = (results) => {
        console.log(jsonObj)
        parameter.record = jsonObj;        
        res.render('AppPayGradeReadPage',parameter);
    }    
    Promise.all([readAppPayGrade,appEmployee]).then(sendResult);
});

module.exports = router;