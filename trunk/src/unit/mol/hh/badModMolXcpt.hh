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

#ifndef MOL_BADMODMOLXCPT_H
#define MOL_BADMODMOLXCPT_H

#include "utl/xcpt.hh"
#include "utl/dom.hh"
#include "cpx/modification.hh"
#include "mol/mzrModMol.hh"

namespace bnd
{
  // Exception thrown when a non-mod-mol appears where only a mod-mol will do.
  // For example, specifying a modification state for a small-mol might
  // provoke this exception.
  class badModMolXcpt : 
    public utl::xcpt
  {
    static std::string
    mkParseMsg(const mzrMol* pMol,
	       const xmlpp::Node* pOffendingNode = 0);

    // This message is used when a mod-mol query is being applied incorrectly
    // to a non mod-mol.
    static std::string
    mkQueryMsg(const cpx::modification* pMod,
	       int modNdx);

    badModMolXcpt(const std::string& rMsg) :
      utl::xcpt(rMsg)
    {}
    
  public:
    // For constructing this class of exception in the context of parsing.
    // (Message is useless without provided node.)
    static
    badModMolXcpt
    inParsing(const mzrMol* pMol,
	      const xmlpp::Node* pOffendingNode = 0)
    {
      return badModMolXcpt(mkParseMsg(pMol,
				      pOffendingNode));
    }
    
    // For constructing this class of exception in the special case that a
    // mod-mol query is being applied incorrectly to a non-mod-mol.
    // Generated "internal exception" type message.
    static
    badModMolXcpt
    inQuery(const cpx::modification* pMod,
	    int modNdx)
    {
     return badModMolXcpt(mkQueryMsg(pMod,
				     modNdx));
    }
  };

  // Test whether a mol is really a mod-mol.  If not, an exception is thrown.
  // The exception message includes Xpath of node, if provided.  (The error
  // message is nigh useless without Xpath.)
  mzrModMol*
  mustBeModMol(mzrMol* pMol,
	       const xmlpp::Node* pRequestingNode = 0)
    throw(badModMolXcpt);

  // Parsing time test whether a const mol is really a const mod-mol.  If not
  // an exception is thrown.  The exception message includes Xpath of nod, if
  // provided.  (The error message is nigh useless without Xpath.)
  const mzrModMol*
  mustBeModMol(const mzrMol* pMol,
	       const xmlpp::Node* pRequestingNode = 0)
    throw(badModMolXcpt);
}

#endif // MOL_BADMODMOLXCPT_H
