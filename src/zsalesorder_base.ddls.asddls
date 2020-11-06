@AbapCatalog.sqlViewName: 'ZSALESORDER_B'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Base View for Sales Order'
@VDM.viewType: #BASIC
@Analytics.dataCategory: #CUBE
define view ZSALESORDER_BASE
  as select from    vbak as header
    left outer join vbap as item on header.vbeln = item.vbeln
  association [1..1] to I_Material as _Material on _Material.Material = item.matnr
  association [1] to vbak as _vbak on _vbak.vbeln = header.vbeln
{
  header.vbeln as orderNo,
  item.posnr   as item,
  header.erdat as orderdate,
  item.matnr   as material,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'orderunit'
  item.kwmeng  as Orderquantity,
  @Semantics.unitOfMeasure: true
  item.meins   as orderunit,
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'currecny'
  item.netwr   as Actualprice,
  @Semantics.currencyCode: true
  item.waerk   as currecny,
  _Material,
  _vbak
}
