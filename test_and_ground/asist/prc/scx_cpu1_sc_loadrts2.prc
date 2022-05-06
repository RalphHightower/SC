PROC scx_cpu1_sc_loadrts2

local logging = %liv (log_procedure)
%liv (log_procedure) = FALSE

#include "cfe_utils.h"
#include "cfe_platform_cfg.h"
#include "sc_platform_cfg.h"

%liv (log_procedure) = logging

;**********************************************************************
; Define local variables
;**********************************************************************
local rtsFileName = SC_RTS_FILE_NAME
local slashLoc = %locate(rtsFileName,"/")
local hostCPU = "CPU3"

;; loop until all slashes are found
while (slashLoc <> 0) do
  rtsFileName = %substring(rtsFileName,slashLoc+1,%length(rtsFileName))
  slashLoc = %locate(rtsFileName,"/")
enddo

rtsFileName = %lower(rtsFileName) & "002.tbl"
write "==> RTS Load file name = '",rtsFileName,"'"

;; Compile the rts
compile_rts "scx_cpu1_rts2_load" 2

;; Create the RTS Table Load file
s scx_cpu1_load_ats_rts("scx_cpu1_rts2_load",rtsFileName)

;; ftp the file to the appropriate location
s ftp_file ("CF:0", rtsFileName, rtsFileName,hostCPU,"P")

ENDPROC