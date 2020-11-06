@AbapCatalog.sqlViewName: 'ZSDOPEN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Customer Open Item'
@VDM.viewType: #BASIC
define view ZSD_CUST_OPEN_ITEM
  as select from bsid
  association [1] to kna1 as _kna1 on $projection.kunnr = _kna1.kunnr
{
  bsid.kunnr  as kunnr,
  _kna1.name1 as name,
  bsid.bukrs  as BUKRS,
  bsid.gjahr  as GJAHR,
  bsid.belnr  as BELNR,
  bsid.dmbtr  as DMBTR,
  bsid.wrbtr  as WRBTR,
  bsid.waers  as WAERS,
  bsid.saknr  as saknr,

  _kna1 // Make association public
}
