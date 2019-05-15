###########################################################################
### Routing
###########################################################################

##In the layout window, click on Route -> Core Routing and Optimization

route_opt 

##Save the cel and report timing

save_mw_cel -as s386_route
report_placement_utilization > reports/s386_route_util.rpt
report_qor_snapshot > reports/s386_route_qor_snapshot.rpt
report_qor > reports/s386_route_qor.rpt
report_timing -max_paths 100 -delay max > reports/s386_route.setup.rpt
report_timing -max_paths 100 -delay min > reports/s386_route.hold.rpt
report_power > reports/s386_route_power.rpt

##POST ROUTE OPTIMIZATION STEPS

##Goto Layout Window, Route -> Verify Route


