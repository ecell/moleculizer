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

DEMO_NAME := tolerance

DEMO_DIR := $(DEMO)/$(DEMO_NAME)

# We need a substantial model to test tolerance, and this one also has the
# problem of "global species" in spades.
INPUT_FILE := $(DEMO_DIR)/scaffold.xml

DOC_INPUT_HTML := $(DEMO_DIR)/source.html

OUTPUT_DIR := $(DEMO_DIR)/$(DEMO_NAME).out

WITH_DIR := $(OUTPUT_DIR)/with-tolerance

WITHOUT_DIR := $(OUTPUT_DIR)/without-tolerance

$(DEMO_DIR)/target : $(WITH_DIR)/simulation-done \
	$(WITHOUT_DIR)/simulation-done \
	$(DOC_INPUT_HTML)

$(OUTPUT_DIR) :
	mkdir $@

$(WITH_DIR) : | $(OUTPUT_DIR)
	mkdir $@

$(WITH_DIR)/simulation-done : TOLERANCE := 0.05
$(WITH_DIR)/simulation-done : $(INPUT_FILE) | $(WITH_DIR)
	echo "Started at" `date` > $@
	cp $< $(@D)
	cd $(@D) \
	&& moleculizer -T $(TOLERANCE) < $(<F) \
	&& plot-dmp-files
	echo "Finished at" `date` >> $@

$(WITHOUT_DIR) : | $(OUTPUT_DIR)
	mkdir $@

$(WITHOUT_DIR)/simulation-done : $(INPUT_FILE) | $(WITHOUT_DIR)
	echo "Started at" `date` > $@
	cp $< $(@D)
	cd $(@D) \
	&& moleculizer < $(<F) \
	&& plot-dmp-files
	echo "Finished at" `date` >> $@

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

$(DEMO_DIR)/clean : CLN := $(OUTPUT_DIR) $(DOC_INPUT_HTML)
$(DEMO_DIR)/clean :
	rm -rf $(CLN)

CLEAN_LIST += $(OUTPUT_DIR) $(DOC_INPUT_HTML)

PREEN_LIST += $(DEMO_DIR)/*~ $(DEMO_DIR)/*.bak
