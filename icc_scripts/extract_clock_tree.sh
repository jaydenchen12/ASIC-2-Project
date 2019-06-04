#!/bin/bash

grep -e 'Number of Sinks' ./reports/clock_tree.rpt
grep -e 'Number of CT Buffers' ./reports/clock_tree.rpt
grep -e 'Clock global Skew' ./reports/clock_tree.rpt
grep -e 'Longest path delay' ./reports/clock_tree.rpt
grep -e 'Shortest path delay' ./reports/clock_tree.rpt

