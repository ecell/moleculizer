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

#ifndef MZRBNDSITE_H
#define MZRBNDSITE_H

#include "utl/dom.hh"
#include "fnd/feature.hh"
#include "cpx/basicBndSite.hh"
#include "cpx/ftrSpec.hh"
#include "cpx/cxSite.hh"
#include "mol/siteFeature.hh"

namespace plx
{
  class mzrPlexSpecies;
  class mzrPlexFamily;
}

namespace bnd
{
  class mzrMol;
  
  class mzrBndSite :
    public cpx::basicBndSite,
    public siteFeature
  {
  public:
    mzrBndSite(const std::string& rName,
	       const std::set<std::string>& rShapeNames,
	       const std::string& rDefaultShapeName);

    // Version of cpx::basicBndSite::mustGetShape that incorporates
    // element Xpath.
    const cpx::siteShape*
    mustGetShape(const mzrMol* pMol,
		 const std::string& rShapeName,
		 const xmlpp::Node* pRequestingNode = 0) const
      throw(utl::xcpt);

    xmlpp::Element*
    insertElt(xmlpp::Element* pMolElt) const
      throw(utl::xcpt);
  };
}

#endif // MZRBNDSITE_H
