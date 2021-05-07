// version 16.1
include project_paths.do

use "`out_dir'/MCA_sumuse_pregtri", clear
reshape long sum_GR1_tri sum_GR2_tri sum_GR3_tri sum_GR4_tri sum_GR5_tri sum_GR6_tri sum_GR7_tri sum_GR8_tri sum_GR9_tri, i(pat_epi) j(preg_tri)
order preg_tri, b(sum_GR1_tri)

egen sum_GR_tri = rowtotal(sum_GR*_tri), missing

export delimited "`out_dir'/medfunc/medfunc.csv", replace
save "`out_dir'/medfunc", replace

preserve
keep if (preg_tri == 1)
export delimited "`out_dir'/medfunc/medfunc_tri1.csv", replace
save "`out_dir'/medfunc_tri1", replace
restore

preserve
keep if (preg_tri == 2)
export delimited "`out_dir'/medfunc/medfunc_tri2.csv", replace
save "`out_dir'/medfunc_tri2", replace
restore

preserve
keep if (preg_tri == 3)
export delimited "`out_dir'/medfunc/medfunc_tri3.csv", replace
save "`out_dir'/medfunc_tri3", replace
restore

preserve
keep if (risk == "Normal")
export delimited "`out_dir'/medfunc/medfunc_norm.csv", replace
save "`out_dir'/medfunc_norm", replace
restore

preserve
keep if (risk == "High-Risk")
export delimited "`out_dir'/medfunc/medfunc_high.csv", replace
save "`out_dir'/medfunc_high", replace
restore

use "`out_dir'/medfunc", clear
tabstat sum_GR_tri, s(median) by(preg_tri)

use "`out_dir'/medfunc", clear
tabstat sum_GR1_tri sum_GR2_tri sum_GR3_tri sum_GR5_tri, s(median) by(preg_tri)

use "`out_dir'/medfunc_norm", clear
tabstat sum_GR1_tri sum_GR2_tri sum_GR3_tri sum_GR5_tri, s(median) by(preg_tri)

use "`out_dir'/medfunc_high", clear
tabstat sum_GR1_tri sum_GR2_tri sum_GR3_tri sum_GR5_tri, s(median) by(preg_tri)

use "`out_dir'/medfunc_tri1", clear
tabstat sum_GR1_tri sum_GR2_tri sum_GR3_tri sum_GR5_tri, s(median) by(risk)

use "`out_dir'/medfunc_tri2", clear
tabstat sum_GR1_tri sum_GR2_tri sum_GR3_tri sum_GR5_tri, s(median) by(risk)

use "`out_dir'/medfunc_tri3", clear
tabstat sum_GR1_tri sum_GR2_tri sum_GR3_tri sum_GR5_tri, s(median) by(risk)
