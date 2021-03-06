/////////////////////////////////////////////////////////////////////////////
// Moleculizer - a stochastic simulator for cellular chemistry.
// Copyright (C) 2001  Walter Lawrence (Larry) Lok.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//    
// Contact information:
//   Larry Lok, Research Fellow          Voice: 510-981-8740
//   The Molecular Sciences Institute      Fax: 510-647-0699
//   2168 Shattuck Ave.                  Email: lok@molsci.org
//   Berkeley, CA 94704
/////////////////////////////////////////////////////////////////////////////

#include "cft/cftEltName.hh"

namespace cft
{
  namespace eltName
  {
    // Kinase reactions with nucleotide binding treated as ordinary binding.
    // Generic omni-based reaction generator.
    const std::string omniGen("omni-gen");
    const std::string enablingOmniplex("enabling-omniplex");

    const std::string smallMolExchanges("small-mol-exchanges");
    const std::string smallMolExchange("small-mol-exchange");
    const std::string smallMolInstanceRef("small-mol-instance-ref");
    const std::string smallMolInstanceRef_nameAttr("name");
    const std::string smallMolRef("small-mol-ref");
    const std::string smallMolRef_nameAttr("name");

    const std::string modificationExchanges("modification-exchanges");
    const std::string modificationExchange("modification-exchange");
    const std::string modMolInstanceRef("mod-mol-instance-ref");
    const std::string modMolInstanceRef_nameAttr("name");
    const std::string modSiteRef("mod-site-ref");
    const std::string modSiteRef_nameAttr("name");
    const std::string installedModRef("installed-mod-ref");
    const std::string installedModRef_nameAttr("name");

    const std::string additionalReactantSpecies("additional-reactant-species");
    const std::string additionalReactantSpecies_nameAttr("name");
    const std::string additionalProductSpecies("additional-product-species");
    const std::string additionalProductSpecies_nameAttr("name");

    const std::string rate("rate");
    const std::string rate_valueAttr("value");

    const std::string uniMolGen("uni-mol-gen");
    const std::string enablingMol("enabling-mol");
    const std::string enablingMol_nameAttr("name");
    const std::string enablingModifications("enabling-modifications");
    const std::string modRef("mod-ref");
    const std::string modRef_nameAttr("name");
  }
}
