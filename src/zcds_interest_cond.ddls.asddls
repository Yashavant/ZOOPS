@AbapCatalog.sqlViewName: 'ZCDS_INTEREST_CV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Calculate Interest rate'
define view ZCDS_INTEREST_COND
  with parameters
    p_keydate : sydatum
  as select from ZCDS_INTEREST
{
  reference,
  max(conv_effect) as effective_date
}
where
  conv_effect <= $parameters.p_keydate
group by
  reference
