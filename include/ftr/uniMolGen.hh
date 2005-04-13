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

#ifndef UNIMOLGEN_H
#define UNIMOLGEN_H

#include "mzr/reactionFamily.hh"
#include "mol/molQuery.hh"
#include "plex/cxMolParam.hh"
#include "plex/plexFeature.hh"
#include "ftr/uniMolExtrap.hh"

namespace ftr
{
  class molModExchange
  {
  public:
    int modSiteNdx;
    const bnd::modification* pReplacementMod;

    molModExchange() :
      modSiteNdx(-1),
      pReplacementMod(0)
    {}

    molModExchange(int modSite,
		   const bnd::modification* pMod) :
      modSiteNdx(modSite),
      pReplacementMod(pMod)
    {}
  };

  class uniMolRxnGen :
    public plx::molInContext::rxnGen
  {
    // To intern reactions for memory management.
    mzr::mzrUnit& rMzrUnit;

    // To recognize the new complex.
    plx::plexUnit& rPlexUnit;

    // The mod-mol triggering reaction generation.
    bnd::modMol* pEnablingMol;

    // Queries on the mol's state that must be passed to enable
    // reaction generation.
    bnd::andMolQueries* pMolQueries;

    // Exchanges of modifications.
    const std::vector<molModExchange> molModExchanges;

    // Additional massive reactant; null if there is no additional reactant.
    mzr::species* pAdditionalReactant;

    // Additional product; null if there is no additional product.
    mzr::species* pAdditionalProduct;

    // Reaction family to receive generated reactions.
    mzr::reactionFamily* pFamily;

    // Rate extrapolator, which sometimes is unary and sometimes is binary.
    // This omniRxnGen is responsible for memory management of its
    // extrapolator.
    const uniMolExtrapolator* pExtrapolator;

  public:
    uniMolRxnGen(mzr::mzrUnit& refMzrUnit,
		 plx::plexUnit& refPlexUnit,
		 bnd::modMol* pEnablingModMol,
		 bnd::andMolQueries* pAndMolQueries,
		 const std::vector<molModExchange>& rModExchanges,
		 mzr::species* pAuxReactant,
		 mzr::species* pAuxProduct,
		 mzr::reactionFamily* pReactionFamily,
		 const uniMolExtrapolator* pUniMolExtrapolator) :
      rMzrUnit(refMzrUnit),
      rPlexUnit(refPlexUnit),
      pEnablingMol(pEnablingModMol),
      pMolQueries(pAndMolQueries),
      molModExchanges(rModExchanges),
      pAdditionalReactant(pAuxReactant),
      pAdditionalProduct(pAuxProduct),
      pFamily(pReactionFamily),
      pExtrapolator(pUniMolExtrapolator)
    {}

    ~uniMolRxnGen(void)
    {
      delete pExtrapolator;
    }

    void
    makeReactions(const plx::molInContext& rContext) const;
  };
}

#endif // UNIMOLGEN_H
