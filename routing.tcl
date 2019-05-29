###########################################################################
### Routing
###########################################################################

##In the layout window, click on Route -> Core Routing and Optimization

route_opt -effort low

##Save the cel and report timing

save_mw_cel -as fpu_route
report_placement_utilization > reports/fpu_route_util.rpt
report_qor_snapshot > reports/fpu_route_qor_snapshot.rpt
report_qor > reports/fpu_route_qor.rpt
report_timing -max_paths 100 -delay max > reports/fpu_route.setup.rpt
report_timing -max_paths 100 -delay min > reports/fpu_route.hold.rpt

##POST ROUTE OPTIMIZATION STEPS

##Goto Layout Window, Route -> Verify Route

