@AbapCatalog.sqlViewName: 'ZDEMOSFLIGHT1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sflight'
define view ZDEMO_SFLIGHT1 as select from sflight {
    carrid,
    connid,
    price,
    currency
}
