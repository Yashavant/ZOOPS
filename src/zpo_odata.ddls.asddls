@AbapCatalog.sqlViewName: 'ZPOV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Details'
@VDM.viewType: #BASIC
define view ZPO_ODATA
  as select from ekko as header
  association [0..*] to ZPO_ITEM_D as _item on $projection.ebeln = _item.ebeln
{
  key header.ebeln,
  key _item.ebelp,
      header.lifnr,
      _item.matnr,
      _item.maktx,
      _item.menge,
      _item.meins,
      _item.netpr,
      header.waers
}
