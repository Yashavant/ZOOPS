@AbapCatalog.sqlViewName: 'ZPOITEMV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Item Details'
@VDM.viewType: #BASIC
define view ZPO_ITEM_D
  as select from    ekpo as item
    left outer join makt as _desc on item.matnr = _desc.matnr
{
  key item.ebeln,
  key item.ebelp,
      item.matnr,
      _desc.maktx,
      item.menge,
      item.meins,
      item.netpr,
      item.werks
}
where
  _desc.spras = $session.system_language
