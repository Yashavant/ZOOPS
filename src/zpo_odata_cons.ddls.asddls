@AbapCatalog.sqlViewName: 'ZPOODATAV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consume OData'
@VDM.viewType: #CONSUMPTION
@OData.publish: true
define view ZPO_ODATA_CONS
  as select from ZPO_ODATA
{
      @UI.lineItem: [{position: 1 }]
  key ebeln,
      @UI.lineItem: [{position: 2 }]
  key ebelp,
      @UI.lineItem: [{position: 3 }]
      lifnr,
      @UI.lineItem: [{position: 4 }]
      matnr,
      @UI.lineItem: [{position: 5 }]
      maktx,
      @UI.lineItem: [{position: 6 }]
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      menge,
      @UI.lineItem: [{position: 7 }]
      @Semantics.unitOfMeasure: true
      meins,
      @UI.lineItem: [{position: 8 }]
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'waers'
      netpr,
      @UI.lineItem: [{position: 9 }]
      @Semantics.currencyCode: true
      waers

}
