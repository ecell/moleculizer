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

# The name of this module.
UNIT_NAME := fnd

# The source files to be compiled, including the .cc extension.  These should
# all be in the cc directory.
CC_FILES := badDumpFileXcpt.cc \
	dumpStream.cc \
	speciesNotMassiveXcpt.cc \
	pchem.cc \
	physConst.cc

# The header files, including the .hh extension.  These should all be in the hh
# directory.
HH_FILES := badDumpFileXcpt.hh \
	basicDmpColumn.hh \
	basicDumpable.hh \
	basicReaction.hh \
	basicSpecies.hh \
	binaryRxnGen.hh \
	dmpColumn.hh \
	dumpable.hh \
	dumpStream.hh \
	event.hh \
	featureContext.hh \
	feature.hh \
	featureMap.hh \
	featureStimulus.hh \
	gillspReaction.hh \
	massive.hh \
	multiSpeciesDumpable.hh \
	newContextStimulus.hh \
	newSpeciesStimulus.hh \
	notifier.hh \
	pchem.hh \
	physConst.hh \
	query.hh \
	queryImpl.hh \
	querySpeciesDumpable.hh \
	rxnGen.hh \
	sensitive.hh \
	sensitiveOnce.hh \
	sensitivityList.hh \
	speciesNotMassiveXcpt.hh \
	stateVar.hh \
	varDumpable.hh

# Other units (really libs made by this build) that this
# module requires for linking.
REQUIRED_UNITS :=

# Libraries that are required for linking this module,
# but are not made by this build.
EXTRA_LIBS :=

# Archive libraries, not made by this build, used in the linking of this
# module.  These locations are typically configured in build-config.mk.
EXTRA_ARCHIVES :=

# Compiler flags and definitions to be used in compiling c++ files for this
# module.
COMPILE_DEFS :=

include $(BUILD)/unit.mk