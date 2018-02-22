' Initialise target series
' For each var in the series list vars, take growth rates loaded in the series TREND_{var}
' and build the corresponding target series {var}_Tgt
subroutine init_target_series(string %vars)

  for %v {%vars}
    series {%v}_Tgt = {%v}
  next

  for !year = {%baseyear} + 1 to {%lastdate}
    %year = @str(!year)
    smpl {%year} {%year}
    for %v {%vars}
      {%v}_Tgt = {%v}_Tgt(-1) * (1 + {%v}_TREND)
    next
  next

  smpl @all

endsub


subroutine init_series(string %vars, string %suffix)
  for %v {%vars}
	%endo_v = %v + "_0"
	' If variable %v is endogenous
	if @isobject(%endo_v) then
	  series {%v}_{%suffix} = {%endo_v}
	else
	  series {%v}_{%suffix} = {%v}
	endif
  next
endsub


subroutine set_to(string %vars, string %suffix)
  for %v {%vars}
	series {%v} = {%v}_{%suffix}
  next
endsub


subroutine delete_series(string %vars, string %suffix)
  for %v {%vars}
	delete(noerr) {%v}_{%suffix}
  next
endsub


subroutine jacobian(string %x_vars, string %y_vars, string %year, scalar !initial_year)

  !delta = 0.005

  smpl {%year} {%year}

  call init_series(%x_vars, "Base")
  call init_series(%y_vars, "Base")

  ' Calculate partial derivatives with respect to each x_var
  for %x_var {%x_vars}

	' ' All the x_vars but one must take their base values
	' call set_to(%x_vars, "Base")

	' Small variation on the x_var along which we estimate a partial derivative
    if @elem({%x_var}_Base, %year) = 0 then
      {%x_var} = 1
    else
	  {%x_var} = (1 + !delta) * {%x_var}_Base
    endif

	' Estimation
    smpl !initial_year {%year}
	  a_3me.solve
    smpl {%year} {%year}

	' Estimate and store results
	for %y_var {%y_vars}
      if @elem({%x_var}_Base, %year) = 0 then
        series D_{%y_var}_{%x_var} = ({%y_var}_0 - {%y_var}_Base) / 1
      else
      	series D_{%y_var}_{%x_var} = ({%y_var}_0 - {%y_var}_Base) / (!delta * {%x_var}_Base)
      endif
	next

    ' Reset %x_var for the next iteration
	{%x_var} = {%x_var}_Base
  next

  smpl @all

endsub


subroutine jacobian_system(string %x_vars, string %y_vars, string %year)

  delete(noerr) jacobian_system_{%year}
  matrix(@wcount(%y_vars), @wcount(%x_vars)) jacobian_system_{%year}

  smpl {%year} {%year}

  for %x_var {%x_vars}
    %derivatives = @wcross(@wcross("D_", %y_vars), "_" + %x_var)
    group jacob_group {%derivatives}
    delete(noerr) mat_tmp
    matrix mat_tmp = @transpose(@convert(jacob_group))
    matplace(jacobian_system_{%year}, mat_tmp, 1, @wfind(%x_vars, %x_var))
  next

  %y_diffs = ""
  for %y_var {%y_vars}
    %y_diffs = %y_diffs + %y_var + "_Tgt" + "-" + %y_var + "_0 "
  next

  group jacob_targets {%y_diffs}
  delete(noerr) target
  vector target = @transpose(@convert(jacob_targets))
  vector x_delta = @solvesystem(jacobian_system_{%year}, target)

  for %x_var {%x_vars}
    {%x_var}_Calib = {%x_var} + x_delta(@wfind(%x_vars, %x_var))
  next

  smpl @all

endsub


subroutine solve_for_target(string %x_vars, string %y_vars, scalar !start_year, scalar !end_year)

  ' Reference solve
  a_3me.solve

  ' Backup the reference values of x_vars and y_vars
  call init_series(%x_vars, "Ref")

  ' Init calibration
  call init_series(%x_vars, "Calib")

  ' Init target series
  call init_target_series(%y_vars)

  for !year = !start_year to !end_year
    %year = @str(!year)
    call jacobian(%x_vars, %y_vars, %year, !start_year - 1)
    call jacobian_system(%x_vars, %y_vars, %year)

    ' Apply the calibration and solve the model
    call set_to(%x_vars, "Calib")
    a_3me.solve
  next

  ' Clean up

  ' Get the model back to its reference state
  call set_to(%x_vars, "Ref")

endsub