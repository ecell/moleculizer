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

DEMO_NAME := heinrich-sbml

DEMO_DIR := $(DEMO)/$(DEMO_NAME)

# No reason for this variation, except that this demo doesn't really
# improve on the straight heinrich demo, except for generating sbml.
# 
# Consider consolidating this demo with the plain heinrich demo.
INPUT_FILE := $(DEMO_DIR)/heinrich.xml

DOC_INPUT_HTML := $(DEMO_DIR)/source.html

OUTPUT_DIR := $(DEMO_DIR)/$(DEMO_NAME).out

$(DEMO_DIR)/target : $(OUTPUT_DIR)/heinrich-pretty.sbml \
	$(OUTPUT_DIR)/heinrich-state-pretty.xml \
	$(DOC_INPUT_HTML)

$(OUTPUT_DIR) :
	mkdir $@

# Run the moleculizer simulation.
$(OUTPUT_DIR)/simulation-done : $(INPUT_FILE) | $(OUTPUT_DIR)
	echo "Started at" `date` > $@
	cp $< $(@D)
	cd $(@D) \
	&& moleculizer < $(<F) \
	&& plot-dmp-files
	echo "Finished at" `date` >> $@

# Convert moleculizer state dump to sbml.
$(OUTPUT_DIR)/heinrich.sbml : $(OUTPUT_DIR)/simulation-done
	state2sbml $(@D)/heinrich-state.xml $@

# Pretty-print (indent) sbml.
$(OUTPUT_DIR)/heinrich-pretty.sbml : $(OUTPUT_DIR)/heinrich.sbml
	xmlpretty $< $@

# Pretty-print (indent) state dump.
$(OUTPUT_DIR)/heinrich-state-pretty.xml : $(OUTPUT_DIR)/simulation-done
	xmlpretty $(@D)/heinrich-state.xml $@

# Make documented html version of input file.
# 
# I'm somewhat uncomfortable using this relative path for the documentation
# URL.
$(DOC_INPUT_HTML) : FLAT_DOC_URL := ../../doc/static-doc/
$(DOC_INPUT_HTML) : $(INPUT_FILE)
	java org.apache.xalan.xslt.Process \
	-in $< \
	-xsl $(XSL)/arg-any2static-doc.xsl \
	-param flat-doc-url $(FLAT_DOC_URL) \
	-param caption $(<F) \
	-html \
	-out $@

# For iterating a single demo.
$(DEMO_DIR)/clean : CLN := $(OUTPUT_DIR) $(DOC_INPUT_HTML)
$(DEMO_DIR)/clean :
	rm -rf $(CLN)

CLEAN_LIST += $(OUTPUT_DIR) $(DOC_INPUT_HTML)

PREEN_LIST += $(DEMO_DIR)/*~ $(DEMO_DIR)/*.bak