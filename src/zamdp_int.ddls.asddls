@EndUserText.label: 'AMDP for Calculate Interest'
define table function ZAMDP_INT
with parameters 
@Environment.systemField:#CLIENT 
p_clnt: abap.clnt,
@Environment.systemField: #SYSTEM_DATE
p_keydate :sydatum
returns {
  mandt : mandt;
  reference : referenz;
  effective_date:abap.dats;
  
}
implemented by method zamdp_class_int=>get_interest_rate;