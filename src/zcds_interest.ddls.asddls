@AbapCatalog.sqlViewName: 'ZCDS_INTERESTV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Calculate Interest rate'
define view ZCDS_INTEREST as select from t056p {
    referenz as reference,
    datab as effective_date,
    cast( cast( 99999999 - cast(cast(datab as abap.numc( 8 )) as abap.int4 ) as abap.char( 12 )) as abap.dats  ) as conv_effect
}
