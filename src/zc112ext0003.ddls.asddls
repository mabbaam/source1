@AbapCatalog.sqlViewAppendName: 'ZC112EXT0003_V'
@EndUserText.label: '[c1] fake standard table extend'
extend view zc112cds0003 with zc112ext0003 
{
 zc1120003.zzsaknr,
 zc1120003.zzkostl,
 zc1120003.zzshkzg,
 zc1120003.zzlgort
 
}
