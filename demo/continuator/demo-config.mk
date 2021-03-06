###############################################################################
# Moleculizer - a stochastic simulator for cellular chemistry.
# Copyright (C) 2001  Walter Lawrence (Larry) Lok.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#    
# Contact information:
#   Larry Lok, Research Fellow          Voice: 510-981-8740
#   The Molecular Sciences Institute      Fax: 510-647-0699
#   2168 Shattuck Ave.                  Email: lok@molsci.org
#   Berkeley, CA 94704
###############################################################################

DEMO_NAME := continuator

DEMO_DIR := $(DEMO)/$(DEMO_NAME)

# Here using a different name from the usual, since this input file
# isn't strictly an input file for continuator.
INPUT_FILE := $(DEMO_DIR)/input.xml

DOC_INPUT_HTML := $(DEMO_DIR)/source.html

MZR_OUTPUT_DIR := $(DEMO_DIR)/moleculizer.out

CTR_OUTPUT_DIR := $(DEMO_DIR)/continuator.out

$(DEMO_DIR)/target : $(CTR_OUTPUT_DIR)/simulation-done $(DOC_INPUT_HTML)

$(MZR_OUTPUT_DIR) :
	mkdir $@

# Run the moleculizer simulation with 5 second clock-time limit.
# 
# Both continuator and moleculizer return error status when they time out, so
# we have to instruct make to ignore the error using the - syntax.  Also have
# to avoid usual habit of connecting these shell commands with &&, since one
# of them will fail.
$(MZR_OUTPUT_DIR)/simulation-done : $(INPUT_FILE) | $(MZR_OUTPUT_DIR)
	echo "Started at" `date` > $@
	cp $< $(@D)
	-cd $(@D) ;\
	moleculizer -t 5 < $(<F) ;\
	plot-dmp-files
	echo "Finished at" `date` >> $@

# Continuator starts in a copy of all of the output from moleculizer.
# Continuator will append to the output files of the moleculizer simulation.
$(CTR_OUTPUT_DIR) : $(MZR_OUTPUT_DIR)/simulation-done
	cp -r $(<D) $@

# Continue the timed-out simulation using the state dump that is produced
# upon time-out.  Continue the simulation for 5 seconds of clock-time only,
# causing a second time-out (and reducing the length of the simulation.)
# 
# Both continuator and moleculizer return error status when they time out, so
# we have to instruct make to ignore the error using the - syntax.  Also have
# to avoid usual habit of connecting these shell commands with &&, since one
# of them will fail.
$(CTR_OUTPUT_DIR)/simulation-done : $(INPUT_FILE) | $(CTR_OUTPUT_DIR)
	echo "Started at" `date` > $@
	-cd $(@D) ;\
	continuator timeout-state.xml -t 5 < $(<F) ;\
	plot-dmp-files

# Make documented html version of input file.
# 
# I'm somewhat uncomfortable using this relative path for the documentation
# URL.
$(DOC_INPUT_HTML) : FLAT_DOC_URL := ../../doc/static-doc/
$(DOC_INPUT_HTML) : $(INPUT_FILE)
	java org.apache.xalan.xslt.Process \
	-in $< \
	-xsl $(XSL)/arg-mzr2static-doc.xsl \
	-param flat-doc-url $(FLAT_DOC_URL) \
	-param caption $(<F) \
	-html \
	-out $@

# For redoing individual demos several times.
$(DEMO_DIR)/clean : CLN := $(MZR_OUTPUT_DIR) \
	$(CTR_OUTPUT_DIR) \
	$(DOC_INPUT_HTML)
$(DEMO_DIR)/clean :
	rm -rf $(CLN)

CLEAN_LIST +=  $(MZR_OUTPUT_DIR) \
	$(CTR_OUTPUT_DIR) \
	$(DOC_INPUT_HTML)

PREEN_LIST += $(DEMO_DIR)/*~ $(DEMO_DIR)/*.bak

