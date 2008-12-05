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

#include "cml/cmlUnit.hh"
#include "cml/cmlEltName.hh"
#include "cml/dupMolNameXcpt.hh"
#include "cml/unkMolXcpt.hh"
#include "cml/unkModXcpt.hh"
#include "cml/badModMolXcpt.hh"
#include "cml/badSmallMolXcpt.hh"
#include "cml/dupModNameXcpt.hh"

namespace cml
{
  cmlUnit::
  cmlUnit(cpt::cptApp& rCptApp) :
    cpt::unit("mol",
	      rCptApp)
  {
    // Register the model elements that this unit is
    // responsible for.
    inputCap.addModelContentName(eltName::modifications);
    inputCap.addModelContentName(eltName::mols);

    // This unit isn't responsible for any reaction generators,
    // explicit species, species streams, or events.
  }

  void
  cmlUnit::
  mustAddMol(cptMol* pMol,
	     const xmlpp::Node* pRequestingNode)
    throw(utl::xcpt)
  {
    if(! addMol(pMol))
      throw dupMolNameXcpt(pMol->getName(),
			   pRequestingNode);
  }

  cptMol*
  cmlUnit::
  mustFindMol(const std::string& rMolName,
	      const xmlpp::Node* pRequestingNode) const
    throw(utl::xcpt)
  {
    cptMol* pMol = findMol(rMolName);

    if(0 == pMol) 
      throw unkMolXcpt(rMolName,
		       pRequestingNode);
    return pMol;
  }

  cptModMol*
  cmlUnit::
  mustFindModMol(const std::string& rModMolName,
		 const xmlpp::Node* pRequestingNode) const
    throw(utl::xcpt)
  {
    return mustBeModMol(mustFindMol(rModMolName,
				    pRequestingNode),
			pRequestingNode);
  }

  cptSmallMol*
  cmlUnit::
  mustFindSmallMol(const std::string& rSmallMolName,
		   const xmlpp::Node* pRequestingNode) const
    throw(utl::xcpt)
  {
    return mustBeSmallMol(mustFindMol(rSmallMolName,
				      pRequestingNode),
			  pRequestingNode);
  }

  void
  cmlUnit::
  mustAddMod(const cpx::modification* pModification,
	     const xmlpp::Node* pRequestingNode)
    throw(utl::xcpt)
  {
    if(! addMod(pModification))
      throw(dupModNameXcpt(pModification->getName(),
			   pRequestingNode));
  }

  const cpx::modification*
  cmlUnit::
  mustGetMod(const std::string& rModificationName,
	     xmlpp::Node* pRequestingNode) const
    throw(utl::xcpt)
  {
    const cpx::modification* pMod = getMod(rModificationName);

    if(! pMod) throw unkModXcpt(rModificationName,
				pRequestingNode);
    return pMod;
  }

  class getValueMod :
    public std::unary_function
  <std::pair<std::string, std::string>,
    std::pair<std::string, const cpx::modification*> >
  {
    const cmlUnit& rMolUnit;
      
  public:
    getValueMod(const cmlUnit& refMolUnit) :
      rMolUnit(refMolUnit)
    {}
      
    std::pair<std::string, const cpx::modification*>
    operator()(const std::pair<std::string, std::string>& rEntry) const
      throw(utl::xcpt)
    {
      return std::make_pair(rEntry.first,
			    rMolUnit.mustGetMod(rEntry.second));
    }
  };

  void
  cmlUnit::
  getModMap(const std::map<std::string, std::string>& rMapToModNames,
	    std::map<std::string, const cpx::modification*>& rMapToMods) const
    throw(utl::xcpt)
  {
    transform(rMapToModNames.begin(),
	      rMapToModNames.end(),
	      inserter(rMapToMods,
		       rMapToMods.begin()),
	      getValueMod(*this));
  }
}