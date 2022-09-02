@AbapCatalog.sqlViewName: 'ZC112CDS0003_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[c1] fake standard table'
define view zc112cds0003 as select from zc1120003 
{
    bukrs,
    belnr,
    gjahr,
    buzei,
    bschl
}
