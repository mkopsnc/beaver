program main
  use ids_routines
  implicit none

! I am using only one IDS - Summary
  type(ids_summary)   :: summary
  integer             :: status_read, status_write
  integer             :: pctx_read,   pctx_write

  character(len=132)  :: usr

  integer             :: shot_read,  run_read
  integer             :: shot_write, run_write

! In this sample code I use hardcoded locations
! input
  shot_read  = 1111
  run_read   = 997

! output
  shot_write = 1111
  run_write  = 999


  call get_environment_variable("USER",usr)

  write (*,*) 'Reading input data'

! Here is the part responsible for opening/creating pulse files
  call ual_begin_pulse_action(MDSPLUS_BACKEND, shot_read, run_read, usr, "test", "3", pctx_read, status_read)
  if (status_read.ne.0) ERROR STOP 'Error beggining the pulse context - input'

  call ual_open_pulse(pctx_read, OPEN_PULSE, "", status_read)
  if (status_read.ne.0) ERROR STOP 'Error opening the pulse file - input'

  call ual_begin_pulse_action(MDSPLUS_BACKEND, shot_write, run_write, usr, "test", "3", pctx_write, status_write)
  if (status_write.ne.0) ERROR STOP 'Error beggining the pulse context - output'

  call ual_open_pulse(pctx_write, CREATE_PULSE, "", status_write)
  if (status_write.ne.0) ERROR STOP 'Error opening the pulse file - output'

! This is the business logic of the code
  call ids_get(pctx_read, "summary", summary)

  write (*,*) 'summary%ids_properties%comment: ', summary%ids_properties%comment

  summary%ids_properties%comment = 'Modified by the code'

  call ids_put(pctx_write, "summary", summary)

  write (*,*) 'Writing output data'

! Here is the part responsible for closing pulse files
  call ual_close_pulse(pctx_read, CLOSE_PULSE, "", status_read)
  if (status_read.ne.0) ERROR STOP 'Error closing the pulse - input'

  call ual_end_action(pctx_read, status_read)
  if (status_read.ne.0) ERROR STOP 'Error ending the pulse context - input'

  call ual_close_pulse(pctx_write, CLOSE_PULSE, "", status_write)
  if (status_write.ne.0) ERROR STOP 'Error closing the pulse - output'

  call ual_end_action(pctx_write, status_write)
  if (status_write.ne.0) ERROR STOP 'Error ending the pulse context - output'

end program main
