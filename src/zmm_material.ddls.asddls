@AbapCatalog.sqlViewName: 'ZMATERIAL_V'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material Details'
define view ZMM_MATERIAL
  as select from mara
{
  key matnr,
      ernam,
      mtart,
      matkl,
      brgew,
      ntgew,
      gewei,
      volum,
      voleh
}
