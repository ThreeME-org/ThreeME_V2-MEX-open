' The subroutines in this file set up the standard shocks used for comparing
' the model behaviour with other models.
'
' Many of these shocks amount to 1% of baseline GDP, hence they must be calculated
' from an ex-ante baseline run of the model. These subroutine should therefore be
' run after the baseline has been solved.

' ============================================================================

subroutine standard_backup()

  smpl @all
  series PWD_20_bckp = PWD_20
  series PWD_21_bckp = PWD_21
  series Ttco_bckp = Ttco
  series TENERTD_22_bckp = TENERTD_22
  series TENERTM_22_bckp = TENERTM_22

  for %c 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22
    series TVATD_{%c}_bckp = TVATD_{%c}
    series TVATM_{%c}_bckp = TVATM_{%c}
    
  next

  IMP_BUD_19 = 0

endsub

subroutine standard_restore_backup()

  smpl @all
  PWD_20 = PWD_20_bckp
  PWD_21 = PWD_21_bckp
  Ttco = Ttco_bckp
  TENERTD_22 = TENERTD_22_bckp
  TENERTM_22 = TENERTM_22_bckp

  for %c 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 
    TVATD_{%c} = TVATD_{%c}_bckp
    TVATM_{%c} = TVATM_{%c}_bckp
    
  next

  IMP_BUD_19 = 0

endsub

' ============================================================================

subroutine standard_shock(string %shock)

  call standard_restore_backup

  smpl 2014 @last

' ************************************************
  ' 10% increase of fossil fuel prices
  if @lower(%shock) = "ff10" then

    PWD_20 = PWD_20 * 1.1
    PWD_21 = PWD_21 * 1.1

  endif

' ************************************************
  ' Increase of the carbon tax by 1% of GDP
  if @lower(%shock) = "co2" then

    TTco = Ttco + 0.01 * PGDP_0 * GDP_0 / EMS_TOT
    ' No redistribution
    Phi_Tco_H01 = 0
    Phi_Tco_ETS = 0
    Phi_Tco_NETS = 0

  endif

' ************************************************
  ' Increase of the electricity tax by 1% of GDP
  if @lower(%shock) = "elec" then

    TENERTD_22 = TENERTD_22 + 0.01 * GDP_0 / YQ_23_0
    ' TENERTM_22 = TENERTM_22 + 0.01 * GDP_0 / M_23_0

  endif

' ************************************************
  ' Increase of VAT by 1% of GDP
  if @lower(%shock) = "vat" then

    series VATratio = (PVAT_0 * VAT_0 + 0.01 * PGDP_0 * GDP_0) / (PVAT_0 * VAT_0)

    for %c 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 
      TVATD_{%c} = TVATD_{%c} * VATratio
      TVATM_{%c} = TVATM_{%c} * VATratio
      
    next

  endif

  ' ************************************************
  ' Increase of IAPU by 1% of GDP
  if @lower(%shock) = "iapu" then

    smpl 2014 2014
    IMP_BUD_19 = 0.01

  endif

  ' ************************************************

  smpl @all

endsub
