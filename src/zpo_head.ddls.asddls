@AbapCatalog.sqlViewName: 'ZPOHEAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Po Header details'
define view ZPO_HEAD
  as select from    ekko       as header
    inner join ZPO_ITEM_D as item on header.ebeln = item.ebeln
{
  header.ebeln as ebeln,
  item.ebelp   as ebelp,
  header.bukrs as bukrs,
  header.lifnr as lifnr,
  item.werks   as werks,
  item.matnr   as matnr,
  item.maktx   as maktx,
  item.menge   as menge,
  item.meins   as meins,
  item.netpr   as netpr,
  header.waers as waers
}
where header.bstyp = 'F'
