@AbapCatalog.sqlViewName: 'ZSALES_CONS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
define view ZSALESORDER_CONS
  as select from ZSALESORDER_BASE
{

      //ZSALESORDER_BASE
      @Consumption.filter:{selectionType: #SINGLE,multipleSelections: true ,mandatory: false }
      @AnalyticsDetails.query.axis: #ROWS
      @Consumption.defaultValue: '3'
      @ObjectModel.foreignKey.association: '_vbak'
  key orderNo,
  @AnalyticsDetails.query.axis: #ROWS
  key item,
  @AnalyticsDetails.query.axis: #ROWS
      orderdate,
      @AnalyticsDetails.query.axis: #ROWS
      @Consumption.filter:{selectionType: #RANGE,multipleSelections: true ,mandatory: false }
      @ObjectModel.foreignKey.association: '_Material'
      material, 
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'orderunit'
      Orderquantity,
      @Semantics.unitOfMeasure: true
      orderunit,
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'currecny'
      Actualprice,
      @Semantics.currencyCode: true
      currecny,
      /* Associations */
      //ZSALESORDER_BASE
      _Material,
      _vbak
}
