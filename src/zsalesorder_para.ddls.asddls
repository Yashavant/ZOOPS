@AbapCatalog.sqlViewName: 'ZSALESORDER_P'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Parameter View'
define view ZSALESORDER_PARA
  with parameters
    Order_no      : vbeln_va,
    @Environment.systemField: #SYSTEM_DATE
    exchange_date : abap.dats,
    currency_key  : abap.cuky
  as select from    vbak as header
    left outer join vbap as item on header.vbeln = item.vbeln
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

  currency_conversion( amount => item.netwr, 
                       source_currency => item.waerk, 
                       target_currency => $parameters.currency_key, 
                       exchange_rate_date => $parameters.exchange_date,
                       exchange_rate_type => 'M'
                       
                        ) as converted_Value,
             $parameters.currency_key as Target_currency
             
                       
}

